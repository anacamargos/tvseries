//
//  SerieDetailsPresenterTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import XCTest
@testable import TVSeries

final class SerieDetailsPresenterTests: XCTestCase {
    
    func test_presentSerieDetails_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = SerieDetailsDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewData = SerieDetails.Serie.testMock

        // When
        sut.presentSerieDetails(.mock)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displaySerieDetailsViewDataPassedViewStates), String(describing: [expectedViewData]))
    }
    
    func test_presentEpisodesResponse_whenResponseIsLoading_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = SerieDetailsDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewData = SerieDetails.ViewState.loading

        // When
        sut.presentEpisodesResponse(.loading)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayEpisodesViewStatePassedViewStates), String(describing: [expectedViewData]))
    }
    
    func test_presentEpisodesResponse_whenResponseIsError_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = SerieDetailsDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewData = SerieDetails.ViewState.error

        // When
        sut.presentEpisodesResponse(.error)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayEpisodesViewStatePassedViewStates), String(describing: [expectedViewData]))
    }
    
    func test_presentEpisodesResponse_whenResponseIsContent_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = SerieDetailsDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewData = SerieDetails.ViewState.content([1: [.testMock]])
        // When
        sut.presentEpisodesResponse(.content(.mock))

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayEpisodesViewStatePassedViewStates), String(describing: [expectedViewData]))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        viewController: SerieDetailsDisplayLogic = SerieDetailsDisplayLogicDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SerieDetailsPresenter {
        let sut = SerieDetailsPresenter()
        sut.viewController = viewController
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(viewController, file: file, line: line)
        return sut
    }

}

final class SerieDetailsDisplayLogicDummy: SerieDetailsDisplayLogic {
    func displaySerieDetailsViewData(_ viewData: SerieDetails.Serie) {}
    func displayEpisodesViewState(_ viewState: SerieDetails.ViewState) {}
}

final class SerieDetailsDisplayLogicSpy: SerieDetailsDisplayLogic {
    
    private(set) var displaySerieDetailsViewDataPassedViewStates = [SerieDetails.Serie]()
    
    func displaySerieDetailsViewData(_ viewData: SerieDetails.Serie) {
        displaySerieDetailsViewDataPassedViewStates.append(viewData)
    }
    
    private(set) var displayEpisodesViewStatePassedViewStates = [SerieDetails.ViewState]()
    
    func displayEpisodesViewState(_ viewState: SerieDetails.ViewState) {
        displayEpisodesViewStatePassedViewStates.append(viewState)
    }
}

extension SerieDetails.Serie {
    static var testMock: SerieDetails.Serie {
        .init(name: "Once Upon a Time", summary: "Test 1 Test 2 Test 3", imageURL: nil, schedule: "Schedule: Fridays at 22:00", genres: "Genres: Drama")
    }
}
