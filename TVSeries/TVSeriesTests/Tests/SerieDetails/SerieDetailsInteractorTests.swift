//
//  SerieDetailsInteractorTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import XCTest
@testable import TVSeries

final class SerieDetailsInteractorTests: XCTestCase {
    
    func test_onViewDidLoad_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = EpisodesUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success(.mock)
        let presenterSpy = SerieDetailsPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, episodesUseCase: useCaseStub)
        let expectedResponse = SeriesUseCaseModel.Serie.mock
        let expectedResponseState = SerieDetails.Response.content(.mock)

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSerieDetailsPassedResponses), String(describing: [expectedResponse]))
        XCTAssertEqual(String(describing: presenterSpy.presentEpisodesResponsePassedResponses), String(describing: [.loading, expectedResponseState]))
    }
    
    func test_onViewDidLoad_whenUseCaseFails_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = EpisodesUseCaseStub()
        useCaseStub.executeResultToBeReturned = .failure(.genericError)
        let presenterSpy = SerieDetailsPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, episodesUseCase: useCaseStub)
        let expectedResponse = SeriesUseCaseModel.Serie.mock
        let expectedResponseState = SerieDetails.Response.error

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSerieDetailsPassedResponses), String(describing: [expectedResponse]))
        XCTAssertEqual(String(describing: presenterSpy.presentEpisodesResponsePassedResponses), String(describing: [.loading, expectedResponseState]))
    }
    
    func test_handleEpisodeSelecion_shouldReturnCorrectSelectedEpisode() {
        // Given
        let useCaseStub = EpisodesUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success(.mock)
        let presenterSpy = SerieDetailsPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, episodesUseCase: useCaseStub)
        let expectedResponse = SeriesUseCaseModel.Serie.mock
        let expectedResponseState = SerieDetails.Response.content(.mock)

        // When
        sut.onViewDidLoad()
        sut.handleEpisodeSelecion(1)

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSerieDetailsPassedResponses), String(describing: [expectedResponse]))
        XCTAssertEqual(String(describing: presenterSpy.presentEpisodesResponsePassedResponses), String(describing: [.loading, expectedResponseState]))
        guard let selectedEpisode = sut.selectedEpisode else {
            XCTFail("Could not find selectedEpisode")
            return
        }
        XCTAssertEqual(String(describing: selectedEpisode), String(describing: EpisodesUseCaseModel.Episode.mock))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        presenter: SerieDetailsPresentationLogic = SerieDetailsPresenterDummy(),
        episodesUseCase: EpisodesUseCaseProvider = EpisodesUseCaseDummy(),
        parameters: SerieDetailsSceneParameters = .init(selectedSerie: .mock),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SerieDetailsInteractor {
        let sut = SerieDetailsInteractor(presenter: presenter, episodesUseCase: episodesUseCase, parameters: parameters)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}

final class SerieDetailsPresenterDummy: SerieDetailsPresentationLogic {
    func presentSerieDetails(_ response: SeriesUseCaseModel.Serie) {}
    func presentEpisodesResponse(_ response: SerieDetails.Response) {}
}

final class EpisodesUseCaseDummy: EpisodesUseCaseProvider {
    func execute(serieID: Int, then handle: @escaping (Result<EpisodesUseCaseModel, EpisodesUseCaseError>) -> Void) {}
}

final class SerieDetailsPresenterSpy: SerieDetailsPresentationLogic {
    
    private(set) var presentSerieDetailsPassedResponses = [SeriesUseCaseModel.Serie]()
    
    func presentSerieDetails(_ response: SeriesUseCaseModel.Serie) {
        presentSerieDetailsPassedResponses.append(response)
    }
    
    private(set) var presentEpisodesResponsePassedResponses = [SerieDetails.Response]()
    
    func presentEpisodesResponse(_ response: SerieDetails.Response) {
        presentEpisodesResponsePassedResponses.append(response)
    }
}

final class EpisodesUseCaseStub: EpisodesUseCaseProvider {
    var executeResultToBeReturned: Result<EpisodesUseCaseModel, EpisodesUseCaseError> = .success(.mock)
    
    func execute(serieID: Int, then handle: @escaping (Result<EpisodesUseCaseModel, EpisodesUseCaseError>) -> Void) {
        handle(executeResultToBeReturned)
    }
}

extension EpisodesUseCaseModel {
    static var mock: EpisodesUseCaseModel {
        .init(data: [.mock])
    }
}

extension EpisodesUseCaseModel.Episode {
    static var mock: EpisodesUseCaseModel.Episode {
        .init(id: 1, name: "Test 1", season: 1, number: 1, image: .init(medium: "", original: ""), summary: "Test 1 Test 2 Test 3")
    }
}
