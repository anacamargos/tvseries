//
//  EpisodeDetailsPresenterTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 18/10/21.
//

import XCTest
@testable import TVSeries

final class EpisodeDetailsPresenterTests: XCTestCase {
    
    func test_presentSerieDetails_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = EpisodeDetailsDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewData = EpisodeDetails.ViewData.testMock

        // When
        sut.presentEpisodesResponse(.mock)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayEpisodeViewDataPassedViewDatas), String(describing: [expectedViewData]))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        viewController: EpisodeDetailsDisplayLogic = EpisodeDetailsDisplayLogicDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> EpisodeDetailsPresenter {
        let sut = EpisodeDetailsPresenter()
        sut.viewController = viewController
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(viewController, file: file, line: line)
        return sut
    }

}

final class EpisodeDetailsDisplayLogicDummy: EpisodeDetailsDisplayLogic {
    func displayEpisodeViewData(_ viewData: EpisodeDetails.ViewData) {}
}

final class EpisodeDetailsDisplayLogicSpy: EpisodeDetailsDisplayLogic {
    
    private(set) var displayEpisodeViewDataPassedViewDatas = [EpisodeDetails.ViewData]()
    
    func displayEpisodeViewData(_ viewData: EpisodeDetails.ViewData) {
        displayEpisodeViewDataPassedViewDatas.append(viewData)
    }
}
