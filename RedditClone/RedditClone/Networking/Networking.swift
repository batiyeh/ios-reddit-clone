//
//  Networking.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/12/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

public enum NetworkError: Error {
    case badUrl
}

public protocol Networkable {
    func request<T: Decodable>(request: URLRequest?) -> Observable<T>
    func request(urlString: String) -> Observable<Data>
}

public class Networking: Networkable {
    public func request<T: Decodable>(request: URLRequest?) -> Observable<T> {
        return Observable<T>.create { observer in
            if let request = request {
                let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                    self?.handleResponse(observer: observer, data: data, response: response, error: error)
                }
                return self.cancelTask(task: task)
            } else {
                return self.handleError(observer: observer, error: NetworkError.badUrl)
            }
        }
    }
    
    public func request(urlString: String) -> Observable<Data> {
        return Observable<Data>.create { observer in
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        observer.onNext(data)
                    } else if let error = error {
                        observer.onError(error)
                    }
                }
                return self.cancelTask(task: task)
            } else {
                observer.onError(NetworkError.badUrl)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
    
    private func handleResponse<T: Decodable>(observer: AnyObserver<T>, data: Data?, response: URLResponse?, error: Error?) {
        do {
            if let data = data {
                let model: T = try JSONDecoder().decode(T.self, from: data)
                observer.onNext(model)
            } else if let error = error {
                observer.onError(error)
            }
        } catch let error {
            observer.onError(error)
        }
        
        observer.onCompleted()
    }
    
    private func handleError<T: Decodable>(observer: AnyObserver<T>, error: NetworkError) -> Disposable {
        observer.onError(error)
        observer.onCompleted()
        return Disposables.create()
    }
    
    private func cancelTask(task: URLSessionDataTask) -> Cancelable {
        task.resume()
        return Disposables.create { task.cancel() }
    }
}
