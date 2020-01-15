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

protocol Networkable {
    func request<T: Decodable>(request: URLRequest?) -> Observable<T>
}

class Networking: Networkable {
    func request<T: Decodable>(request: URLRequest?) -> Observable<T> {
        return Observable<T>.create { observer in
            if let request = request {
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            } else {
                observer.onError(NetworkError.badUrl)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
}
