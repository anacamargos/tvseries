//
//  NetworkResponse.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

/// Constrains the response and the status code.
struct NetworkResponse {

    let status: Status
    let data: Data?

    init(
        status: Status,
        data: Data?
    ) {
        self.status = status
        self.data = data
    }
}
