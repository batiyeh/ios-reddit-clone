//
//  MockNetworking.swift
//  RedditCloneTests
//
//  Created by Atiyeh, Brian (B.) on 1/18/20.
//  Copyright © 2020 Brian Atiyeh. All rights reserved.
//

import Foundation
import RedditClone
import RxSwift

public class MockNetworking: Networkable {
    public var requestedUrl: String?
    
    public func request<T>(request: URLRequest?) -> Observable<T> where T : Decodable {
        requestedUrl = request?.url?.absoluteString
        
        return Observable<T>.create { observer in
            if let _ = request {
                let value: T = MockResponse() as! T
                observer.onNext(value)
                observer.onCompleted()
                return Disposables.create()
            } else {
                observer.onError(NetworkError.badUrl)
                observer.onCompleted()
                return Disposables.create()
            }
        }
    }
}

public struct MockResponse: Decodable { }
