//
//  EpisodesUseCase.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import Foundation

struct EpisodesUseCaseModel {
    let data: [Episode]

    struct Episode {
        let id: Int
        let name: String
        let season, number: Int
        let image: CommonUseCaseModel.Image?
        let summary: String?
    }
}

protocol EpisodesUseCaseProvider {
    func execute(serieID: Int, then handle: @escaping (Result<EpisodesUseCaseModel, EpisodesUseCaseError>) -> Void)
}

enum EpisodesUseCaseError: Error {
    case genericError
}

final class EpisodesUseCase: EpisodesUseCaseProvider {
    
    // MARK: - Dependencies

    private let service: SeriesServiceProvider

    // MARK: - Initialization

    init(service: SeriesServiceProvider) {
        self.service = service
    }
    
    // MARK: - Public Methods
    
    func execute(serieID: Int, then handle: @escaping (Result<EpisodesUseCaseModel, EpisodesUseCaseError>) -> Void) {
        service.getEpisodesData(with: serieID) { [weak self] result in
            switch result {
            case let .success(entities):
                self?.handleSuccess(input: entities, then: handle)
            case .failure:
                handle(.failure(.genericError))
            }
        }
    }
    
    // MARK: - Private methods

    private func handleSuccess(
        input: [EpisodesResponseEntity],
        then: (Result<EpisodesUseCaseModel, EpisodesUseCaseError>) -> Void
    ) {
        let domainItems = input.map {
            EpisodesUseCaseModel.Episode(id: $0.id, name: $0.name, season: $0.season, number: $0.number, image: .init(medium: $0.image?.medium ?? "", original: $0.image?.original ?? ""), summary: $0.summary)
        }
        let domainData = EpisodesUseCaseModel(data: domainItems)
        then(.success(domainData))
    }
}
