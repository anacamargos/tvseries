//
//  NetworkRequestBuilder.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

protocol NetworkRequestBuilder {

    // MARK: - Initialization

    /// Intitializes a builder
    /// - Parameters:
    ///   - request: the NetworkRequest to init the builder
    ///   - networkConfiguration: configuration parameters
    init(
        request: NetworkRequest,
        networkConfiguration: NetworkConfiguration
    )

    /// Builds an URLRequest as previously defined.
    ///
    /// - Returns: A configured URLRequest.
    func build() throws -> URLRequest
}
