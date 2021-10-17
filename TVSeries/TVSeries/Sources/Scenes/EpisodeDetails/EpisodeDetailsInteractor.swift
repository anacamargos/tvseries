//
//  EpisodeDetailsInteractor.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import Foundation

protocol EpisodeDetailsBusinessLogic {
    func onViewDidLoad()
}

final class EpisodeDetailsInteractor {
    
    // MARK: - Dependencies

    private let presenter: EpisodeDetailsPresentationLogic
    private let parameters: EpisodeDetailsSceneParameters
    
    // MARK: - Initialization

    init(
        presenter: EpisodeDetailsPresentationLogic,
        parameters: EpisodeDetailsSceneParameters
    ) {
        self.presenter = presenter
        self.parameters = parameters
    }
}

// MARK: - SerieDetailsBusinessLogic

extension EpisodeDetailsInteractor: EpisodeDetailsBusinessLogic {
    
    func onViewDidLoad() {
        presenter.presentEpisodesResponse(parameters.selectedEpisode)
    }
}
