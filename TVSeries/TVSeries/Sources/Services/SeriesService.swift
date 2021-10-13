//
//  SeriesService.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

enum SeriesServiceError: Error {
    case responseParse
    case genericError
}

protocol SeriesServiceProvider {
    func getSeriesData(
        with page: Int,
        then handle: @escaping (Result<[Int], SeriesServiceError>) -> Void
    )
    func getEpisodesData(
        with serieID: Int,
        then handle: @escaping (Result<[Int], SeriesServiceError>) -> Void
    )
    func search(
        showName: String,
        then handle: @escaping (Result<[Int], SeriesServiceError>) -> Void
    )
}

final class SeriesService: SeriesServiceProvider {
    
    // MARK: - Dependencies

    private let networkDispatcher: NetworkDispatcher

    // MARK: - Initializers

    init(networkDispatcher: NetworkDispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    // MARK: - SeriesServiceProvider
    
    func getSeriesData(
        with page: Int,
        then handle: @escaping (Result<[Int], SeriesServiceError>) -> Void
    ) {
        let request = SeriesRequest.index(page: page)
        execute(request: request, then: handle)
    }
    
    func getEpisodesData(
        with serieID: Int,
        then handle: @escaping (Result<[Int], SeriesServiceError>) -> Void
    ) {
        let request = SeriesRequest.episodes(serieID: serieID)
        execute(request: request, then: handle)
    }
    
    func search(
        showName: String,
        then handle: @escaping (Result<[Int], SeriesServiceError>) -> Void
    ) {
        let request = SeriesRequest.search(showName: showName)
        execute(request: request, then: handle)
    }
    
    // MARK: - Private Methods

    private func execute<T: Codable>(
        request: SeriesRequest,
        then handle: @escaping (Result<T, SeriesServiceError>) -> Void
    ) {
        networkDispatcher.requestCodable(ofType: T.self, for: request) { result in
            do {
                guard let data = try result.get() else {
                    handle(.failure(.responseParse))
                    return
                }
                handle(.success(data))
            } catch {
                handle(.failure(.genericError))
            }
        }
    }
}
