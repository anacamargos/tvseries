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
    private let parameters: SerieDetailsSceneParameters
    
    // MARK: - Initialization

    init(
        presenter: SerieDetailsPresentationLogic,
        parameters: SerieDetailsSceneParameters
    ) {
        self.presenter = presenter
        self.parameters = parameters
    }
}

// MARK: - SerieDetailsBusinessLogic

extension SerieDetailsInteractor: SerieDetailsBusinessLogic {
    
    func onViewDidLoad() {
        presenter.presentSerieDetails(parameters.selectedSerie)
    }
}
