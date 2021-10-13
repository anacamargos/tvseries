//
//  NetworkResponseDecoder.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

protocol NetworkResponseDecoder {

    func decodeDataRequestResult<T: Codable>(
        _ result: Result<NetworkResponse, NetworkError>,
        ofType: T.Type,
        then handle: @escaping (Result<T?, NetworkError>) -> Void
    )
}
