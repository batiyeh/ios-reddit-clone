//
//  Networking.swift
//  RedditClone
//
//  Created by Brian Atiyeh on 1/12/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RxSwift

public enum NetworkError: Error {
    case badUrl
}

public protocol Networkable {
    func request<T: Decodable>(request: URLRequest?) -> Observable<T>
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
