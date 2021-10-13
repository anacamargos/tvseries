//
//  NetworkDispatcher.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

protocol NetworkDispatcher {

    /// Dispatches a request and returns the value as data
    /// - Parameters:
    ///   - request: a request object
    ///   - then: the request result closure
    func dispatch(
        _ request: NetworkRequest,
        then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void
    )

    /// Dispatches a request and returns the value as the especified type
    /// - Parameters:
    ///   - type: the type of the object you want
    ///   - request: a request object
    ///   - then: the request result closure
    func requestCodable<T: Codable>(
        ofType type: T.Type,
        for request: NetworkRequest,
        then handle: @escaping (Result<T?, NetworkError>) -> Void
    )
}
