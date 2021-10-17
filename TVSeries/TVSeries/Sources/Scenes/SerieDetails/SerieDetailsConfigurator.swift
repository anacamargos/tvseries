//
//  SerieDetailsConfigurator.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import UIKit

struct SerieDetailsSceneParameters {
    let selectedSerie: SeriesUseCaseModel.Serie
}

final class SerieDetailsConfigurator {
    
    // MARK: - Dependencies
    
    private let networkDispatcher: NetworkDispatcher
    
    // MARK: - Initializer
    
    init(
        networkDispatcher: NetworkDispatcher
    ) {
        self.networkDispatcher = networkDispatcher
    }
    
    // MARK: - Public Methods
    
    func resolveViewController(using parameters: SerieDetailsSceneParameters) -> UIViewController {
        let presenter = SerieDetailsPresenter()
        let interactor = SerieDetailsInteractor(presenter: presenter, parameters: parameters)
        let viewController = SerieDetailsViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
