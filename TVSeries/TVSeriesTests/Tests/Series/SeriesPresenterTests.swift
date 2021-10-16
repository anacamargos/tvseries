//
//  SeriesPresenterTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import XCTest
@testable import TVSeries

final class SeriesPresenterTests: XCTestCase {
    
    func test_presentSeries_whenResponseIsLoading_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = SeriesDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = Series.ViewState.loading

        // When
        sut.presentSeries(.loading)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displaySeriesViewStatePassedViewStates), String(describing: [expectedViewState]))
    }
    
    func test_presentSeries_whenResponseIsError_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = SeriesDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = Series.ViewState.error

        // When
        sut.presentSeries(.error)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displaySeriesViewStatePassedViewStates), String(describing: [expectedViewState]))
    }
    
    func test_presentSeries_whenResponseIsEmpty_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = SeriesDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = Series.ViewState.empty

        // When
        sut.presentSeries(.empty)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displaySeriesViewStatePassedViewStates), String(describing: [expectedViewState]))
    }
    
    func test_presentSeries_whenResponseIsContent_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = SeriesDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = Series.ViewState.content(.init(series: [.mock]))

        // When
        sut.presentSeries(.content(.mock))

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displaySeriesViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        viewController: SeriesDisplayLogic = SeriesDisplayLogicDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SeriesPresenter {
        let sut = SeriesPresenter()
        sut.viewController = viewController
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(viewController, file: file, line: line)
        return sut
    }

}

final class SeriesDisplayLogicDummy: SeriesDisplayLogic {
    func displaySeriesViewState(_ viewState: Series.ViewState) {}
}

final class SeriesDisplayLogicSpy: SeriesDisplayLogic {
    
    private(set) var displaySeriesViewStatePassedViewStates = [Series.ViewState]()
    
    func displaySeriesViewState(_ viewState: Series.ViewState) {
        displaySeriesViewStatePassedViewStates.append(viewState)
    }
}
