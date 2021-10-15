//
//  SeriesRequest.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

enum SeriesRequest: NetworkRequest {

    case series(page: Int)
    case episodes(serieID: Int)
    case search(serieName: String)

    var baseURL: BaseURL { .serviceGroup(.tvmaze) }

    var path: String? {
        switch self {
        case .series:
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
    
    var urlParameters: URLParameters? {
        switch self {
        case let .series(page):
            return .raw(["page": "\(page)"])
        default:
            return nil
        }
    }
}
