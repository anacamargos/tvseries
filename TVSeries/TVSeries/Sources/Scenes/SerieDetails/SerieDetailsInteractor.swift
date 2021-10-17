//
//  SerieDetailsInteractor.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import Foundation

protocol SerieDetailsBusinessLogic {
    func onViewDidLoad()
}

final class SerieDetailsInteractor {
    
    // MARK: - Dependencies

    private let presenter: SerieDetailsPresentationLogic
    private let episodesUseCase: EpisodesUseCaseProvider
    private let parameters: SerieDetailsSceneParameters
    
    // MARK: - Initialization

    init(
        presenter: SerieDetailsPresentationLogic,
        episodesUseCase: EpisodesUseCaseProvider,
        parameters: SerieDetailsSceneParameters
    ) {
        self.presenter = presenter
        self.episodesUseCase = episodesUseCase
        self.parameters = parameters
    }
    
    // MARK: - Private Methods

    private func loadEpisodesData(for serieID: Int) {
        presenter.presentEpisodesResponse(.loading)
        episodesUseCase.execute(serieID: serieID) { [weak self] result in
            switch result {
            case let .success(response):
                self?.presenter.presentEpisodesResponse(.content(response))
            case .failure:
                self?.presenter.presentEpisodesResponse(.error)
            }
        }
    }
}

// MARK: - SerieDetailsBusinessLogic

extension SerieDetailsInteractor: SerieDetailsBusinessLogic {
    
    func onViewDidLoad() {
        presenter.presentSerieDetails(parameters.selectedSerie)
        loadEpisodesData(for: parameters.selectedSerie.id)
    }
}
