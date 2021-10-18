//
//  SerieDetailsRouterTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 18/10/21.
//

import XCTest
@testable import TVSeries

final class SerieDetailsRouterTests: XCTestCase {
    
    func test_routeToSerieDetailsScene_shouldPushViewController() {
        // Given
        let sut = makeSUT()
        let navigationControllerSpy = makeNavigationViewController(sut)
        
        // When
        sut.routeToEpisodeDetailsScene()
        
        // Then
        XCTAssertEqual(navigationControllerSpy.pushViewControllerAnimatedFlagPassed, [false, true])
        XCTAssertTrue(navigationControllerSpy.viewControllerToPresentPassed[1] is EpisodeDetailsViewController)
    }
    
    func test_routeToSerieDetailsScene_whenDatStoreIsNil_shouldNotPushViewController() {
        // Given
        let dataStore = SerieDetailsDataStoreDummy()
        dataStore.selectedEpisode = nil
        let sut = makeSUT(dataStore: dataStore)
        let navigationControllerSpy = makeNavigationViewController(sut)
        
        // When
        sut.routeToEpisodeDetailsScene()
        
        // Then
        XCTAssertEqual(navigationControllerSpy.pushViewControllerAnimatedFlagPassed, [false])
    }

    // MARK: - Test Helpers

    private func makeSUT(
        dataStore: SerieDetailsDataStore = SerieDetailsDataStoreDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SerieDetailsRouter {
        let sut = SerieDetailsRouter(episodeDetailsConfigurator: .init(), dataStore: dataStore)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func makeNavigationViewController(_ sut: SerieDetailsRouter) -> UINavigationControllerSpy {
        let viewController = UIViewController()
        let navigationControllerSpy = UINavigationControllerSpy(rootViewController: viewController)
        sut.viewController = viewController
        return navigationControllerSpy
    }
    
    private func makeViewController(_ sut: SerieDetailsRouter) -> UIViewControllerSpy {
        let viewController = UIViewControllerSpy()
        sut.viewController = viewController
        return viewController
    }

}

final class SerieDetailsDataStoreDummy: SerieDetailsDataStore {
    var selectedEpisode: EpisodesUseCaseModel.Episode? = .mock
}
