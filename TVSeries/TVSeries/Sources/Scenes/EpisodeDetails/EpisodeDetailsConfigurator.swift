//
//  EpisodeDetailsConfigurator.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import UIKit

struct EpisodeDetailsSceneParameters {
    let selectedEpisode: EpisodesUseCaseModel.Episode
}

final class EpisodeDetailsConfigurator {
    
    func resolveViewController(using parameters: EpisodeDetailsSceneParameters) -> UIViewController {
        let presenter = EpisodeDetailsPresenter()
        let interactor = EpisodeDetailsInteractor(presenter: presenter, parameters: parameters)
        let viewController = EpisodeDetailsViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
