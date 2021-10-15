//
//  SeriesModels.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import Foundation

enum Series {
    
    enum Response {
        case content(SeriesUseCaseModel)
        case loading
        case error
        case empty
    }
    
    enum ViewState {
        case content(ViewData)
        case loading
        case error
        case empty
    }
    
    struct ViewData {
        let series: [Serie]
    }
    
    struct Serie {
        let id: Int
        let name: String
        let imageURL: URL?
        let summary: String
    }
}
