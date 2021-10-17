//
//  SeriesRouter.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import UIKit

protocol SeriesRoutingLogic {
    func routeToSerieDetailsScene()
}

protocol SeriesDataPassing {
    var dataStore: SeriesDataStore? { get set }
}

final class SeriesRouter: SeriesRoutingLogic, SeriesDataPassing {
    
    // MARK: - Dependencies

    weak var viewController: UIViewController?
    private let serieDetailsConfigurator: SerieDetailsConfigurator
    var dataStore: SeriesDataStore?
    
    // MARK: - Initializer

    init(
        serieDetailsConfigurator: SerieDetailsConfigurator,
        dataStore: SeriesDataStore
    ) {
        self.serieDetailsConfigurator = serieDetailsConfigurator
        self.dataStore = dataStore
    }
    
    // MARK: - Public Methods
    
    func routeToSerieDetailsScene() {
        let destinationViewController = serieDetailsConfigurator.resolveViewController()
        viewController?.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
