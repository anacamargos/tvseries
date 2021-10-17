//
//  SeriesConfigurator.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

final class SeriesConfigurator {
    
    func resolveViewController() -> UIViewController {
        let urlProvider = DefaultURLProvider()
        let networkConfiguration = NetworkConfiguration(urlProvider: urlProvider)
        let responseDecoder = DefaultResponseDecoder()
        let httpClient = URLSessionHTTPClient(session: URLSession.shared, configuration: networkConfiguration)
        let networkDispatcher = DefaultNetworkDispatcher(httpClient: httpClient, responseDecoder: responseDecoder)
        let service = SeriesService(networkDispatcher: networkDispatcher)
        let useCase = SeriesUseCase(service: service)
        
        let configurator = SerieDetailsConfigurator()
        let presenter = SeriesPresenter()
        let interactor = SeriesInteractor(presenter: presenter, seriesUseCase: useCase)
        let router = SeriesRouter(serieDetailsConfigurator: configurator, dataStore: interactor)
        let viewController = SeriesViewController(interactor: interactor, router: router)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
