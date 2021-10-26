//
//  SerieDetailsModels.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 26/10/21.
//

import Foundation

enum SerieDetails {
    
    struct Serie {
        let name: String
        let summary: String
        let imageURL: URL?
        let schedule: String
        let genres: String
    }
    
    enum Episode {
        struct ViewData {
            let id: Int
            let name: String
            let number: String
            let imageURL: URL?
        }
    }
    
    enum Season {
        struct ViewData {
            let season: Int
            let episodeCount: Int
        }
    }
    
    enum ViewState {
        case loading
        case error
        case content([Int: [SerieDetails.Episode.ViewData]])
    }
    
    enum Response {
        case loading
        case error
        case content(EpisodesUseCaseModel)
    }
}
