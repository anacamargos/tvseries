//
//  SerieDetailsRouter.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import UIKit

protocol SerieDetailsRoutingLogic {
    func routeToEpisodeDetailsScene()
}

protocol SerieDetailsDataPassing {
    var dataStore: SerieDetailsDataStore? { get set }
}

final class SerieDetailsRouter: SerieDetailsRoutingLogic, SerieDetailsDataPassing {
    
    // MARK: - Dependencies

    weak var viewController: UIViewController?
    private let episodeDetailsConfigurator: EpisodeDetailsConfigurator
    var dataStore: SerieDetailsDataStore?
    
    // MARK: - Initializer

    init(
        episodeDetailsConfigurator: EpisodeDetailsConfigurator,
        dataStore: SerieDetailsDataStore
    ) {
        self.episodeDetailsConfigurator = episodeDetailsConfigurator
        self.dataStore = dataStore
    }
    
    // MARK: - Public Methods
    
    func routeToEpisodeDetailsScene() {
        guard let selectedEpisode = dataStore?.selectedEpisode else { return }
        let parameters = EpisodeDetailsSceneParameters(selectedEpisode: selectedEpisode)
        let destinationViewController = episodeDetailsConfigurator.resolveViewController(using: parameters)
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
