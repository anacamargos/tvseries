//
//  SeriesRequest.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

enum SeriesRequest: NetworkRequest {

    case index(page: Int)
    case episodes(serieID: Int)
    case search(serieName: String)

    var baseURL: BaseURL { .serviceGroup(.tvmaze) }

    var path: String? {
        switch self {
        case .index:
            return "shows"
        case let .episodes(serieID):
            return "/shows/\(serieID)/episodes"
        case .search:
            return "/search/shows"
        }
    }

    var method: HTTPMethod {
        return .get
    }
}
