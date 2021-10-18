//
//  EpisodeDetailsInteractorTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 18/10/21.
//

import XCTest
@testable import TVSeries

final class EpisodeDetailsInteractorTests: XCTestCase {
    
    func test_onViewDidLoad_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let parameters: EpisodeDetailsSceneParameters = .init(selectedEpisode: .mock)
        let presenterSpy = EpisodeDetailsPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, parameters: parameters)
        let expectedResponse = EpisodesUseCaseModel.Episode.mock

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentEpisodesResponsePassedResponses), String(describing: [expectedResponse]))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        presenter: EpisodeDetailsPresentationLogic = EpisodeDetailsPresenterDummy(),
        parameters: EpisodeDetailsSceneParameters = .init(selectedEpisode: .mock),
        file: StaticString = #file,
        line: UInt = #line
    ) -> EpisodeDetailsInteractor {
        let sut = EpisodeDetailsInteractor(presenter: presenter, parameters: parameters)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}

final class EpisodeDetailsPresenterDummy: EpisodeDetailsPresentationLogic {
    func presentEpisodesResponse(_ response: EpisodesUseCaseModel.Episode) {}
}

final class EpisodeDetailsPresenterSpy: EpisodeDetailsPresentationLogic {
    
    private(set) var presentEpisodesResponsePassedResponses = [EpisodesUseCaseModel.Episode]()
    
    func presentEpisodesResponse(_ response: EpisodesUseCaseModel.Episode) {
        presentEpisodesResponsePassedResponses.append(response)
    }
}
