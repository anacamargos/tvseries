//
//  HTTPRequest.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

struct HTTPRequest: NetworkRequest {
    var baseURL: BaseURL
    var path: String?
    var method: HTTPMethod
    var urlParameters: URLParameters?
    var httpBody: HTTPBody?
    var headers: [String: String]
    var timeout: Double?

    init(
        baseURL: BaseURL,
        path: String? = nil,
        method: HTTPMethod,
        urlParameters: URLParameters? = nil,
        httpBody: HTTPBody? = nil,
        headers: [String: String] = [:],
        timeout: Double? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.urlParameters = urlParameters
        self.httpBody = httpBody
        self.headers = headers
        self.timeout = timeout
    }
}
