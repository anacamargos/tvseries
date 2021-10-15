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
        
        let presenter = SeriesPresenter()
        let interactor = SeriesInteractor(presenter: presenter, seriesUseCase: useCase)
        let viewController = SeriesViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
