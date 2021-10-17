//
//  EpisodeDetailsPresenter.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import Foundation

protocol EpisodeDetailsPresentationLogic {
    func presentEpisodesResponse(_ response: EpisodesUseCaseModel.Episode)
}

final class EpisodeDetailsPresenter {
    
    // MARK: - Dependecies

    weak var viewController: EpisodeDetailsDisplayLogic?
}

// MARK: - EpisodeDetailsPresentationLogic

extension EpisodeDetailsPresenter: EpisodeDetailsPresentationLogic {
    
    func presentEpisodesResponse(_ response: EpisodesUseCaseModel.Episode) {
        let season = String(format: "%02d", response.season)
        let number = String(format: "%02d", response.number)
        let viewData = EpisodeDetails.ViewData(id: response.id, name: response.name, number: "S\(season) | E\(number)", summary: response.summary ?? "", imageURL: URL(string: response.image?.medium ?? ""))
        viewController?.displayEpisodeViewData(viewData)
    }
}
