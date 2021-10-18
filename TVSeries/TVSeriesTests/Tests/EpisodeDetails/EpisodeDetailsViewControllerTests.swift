//
//  EpisodeDetailsViewControllerTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 18/10/21.
//

import XCTest
import SnapshotTesting
@testable import TVSeries

final class EpisodeDetailsViewControllerTests: XCTestCase {
    
    func test_episodeDetailsViewController() {
        let viewController = makeSUT()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.viewDidLoad()
        viewController.loadView()
        viewController.displayEpisodeViewData(.mock)
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone8))
        navigationController.viewControllers.removeAll()
    }
    
    func test_viewDidLoad_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = EpisodeDetailsInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(interactorSpy.onViewDidLoadNumberOfTimesCalled, 1)
    }

    // MARK: - Private Methods

    private func makeSUT(
        interactor: EpisodeDetailsBusinessLogic = EpisodeDetailsInteractorDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> EpisodeDetailsViewController {
        let sut = EpisodeDetailsViewController(interactor: interactor)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}

final class EpisodeDetailsInteractorDummy: EpisodeDetailsBusinessLogic {
    func onViewDidLoad() {}
}

final class EpisodeDetailsInteractorSpy: EpisodeDetailsBusinessLogic {
    
    private(set) var onViewDidLoadNumberOfTimesCalled = 0
    
    func onViewDidLoad() {
        onViewDidLoadNumberOfTimesCalled += 1
    }
}
