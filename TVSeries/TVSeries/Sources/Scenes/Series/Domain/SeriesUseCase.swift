//
//  SeriesUseCase.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

protocol SeriesUseCaseProvider {
    func execute(page: Int, then handle: @escaping (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void)
    func execute(serieName: String, then handle: @escaping (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void)
}

final class SeriesUseCase: SeriesUseCaseProvider {
    
    // MARK: - Dependencies

    private let service: SeriesServiceProvider

    // MARK: - Initialization

    init(service: SeriesServiceProvider) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func execute(page: Int, then handle: @escaping (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void) {
        service.getSeriesData(with: page) { [weak self] result in
            switch result {
            case let .success(entities):
                self?.handleSeriesSuccess(input: entities, then: handle)
            case .failure:
                handle(.failure(.genericError))
            }
        }
    }
    
    func execute(serieName: String, then handle: @escaping (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void) {
        service.search(serieName: serieName) { [weak self] result in
            switch result {
            case let .success(entities):
                debugPrint()
                self?.handleSearchSuccess(input: entities, then: handle)
            case .failure:
                handle(.failure(.genericError))
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSeriesSuccess(
        input: [SeriesResponseEntity],
        then: (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void
    ) {
        let domainItems = input.map {
            SeriesUseCaseModel.Serie(id: $0.id, name: $0.name, genres: $0.genres, schedule: .init(time: $0.schedule.time, days: $0.schedule.days), image: CommonUseCaseModel.getImage($0.image), summary: $0.summary)
        }
        let domainData = SeriesUseCaseModel(data: domainItems)
        then(.success(domainData))
    }
    
    private func handleSearchSuccess(
        input: [SearchResponseEntity],
        then: (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void
    ) {
        let domainItems = input.map {
            SeriesUseCaseModel.Serie(id: $0.serie.id, name: $0.serie.name, genres: $0.serie.genres, schedule: .init(time: $0.serie.schedule.time, days: $0.serie.schedule.days), image: CommonUseCaseModel.getImage($0.serie.image), summary: $0.serie.summary)
        }
        let domainData = SeriesUseCaseModel(data: domainItems)
        then(.success(domainData))
    }
}
