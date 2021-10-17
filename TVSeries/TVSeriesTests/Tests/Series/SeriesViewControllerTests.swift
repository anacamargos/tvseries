//
//  SeriesViewControllerTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import XCTest
import SnapshotTesting
@testable import TVSeries

final class SeriesViewControllerTests: XCTestCase {
    
    func test_seriesViewController() {
        let viewController = makeSUT()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.viewDidLoad()
        viewController.loadView()
        viewController.displaySeriesViewState(.content(.mock))
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone8))
        navigationController.viewControllers.removeAll()
    }
    
    func test_viewDidLoad_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = SeriesInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(interactorSpy.onViewDidLoadNumberOfTimesCalled, 1)
    }
    
    func test_displayUsefulToolsViewState_shouldCallCorrectMethodInContentView() {
        // Given
        let contentViewSpy = SeriesContentViewSpy()
        let sut = makeSUT()
        sut.contentView = contentViewSpy
        let expectedViewState = Series.ViewState.loading

        // When
        sut.displaySeriesViewState(.loading)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupSeriesViewStatePassedViewStates), String(describing: [expectedViewState]))
    }
    
    func test_handleSerieSelection_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = SeriesInteractorSpy()
        let routerSpy = SeriesRouterSpy()
        let sut = makeSUT(interactor: interactorSpy, router: routerSpy)
        guard let contentView = sut.view as? SeriesContentView else {
            XCTFail("Could not find content view")
            return
        }
        let onTappedSerieClosure = Mirror(reflecting: contentView).firstChild(of: ((Int) -> Void).self, in: "onTappedSerieClosure")
        
        // When
        onTappedSerieClosure?(1)
        
        // Then
        XCTAssertEqual(interactorSpy.handleSerieSelectionNumberOfTimesCalled, 1)
        XCTAssertEqual(routerSpy.routeToSerieDetailsSceneNumberOfTimesCalled, 1)
    }

    // MARK: - Private Methods

    private func makeSUT(
        interactor: SeriesBusinessLogic = SeriesInteractorDummy(),
        router: SeriesRoutingLogic = SeriesRouterDummy(),
        mainDispatchQueue: DispatchQueueType = DispatchQueueTypeMock(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SeriesViewController {
        let sut = SeriesViewController(interactor: interactor, router: router, mainDispatchQueue: mainDispatchQueue)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}

final class SeriesInteractorDummy: SeriesBusinessLogic {
    func onViewDidLoad() {}
    func checkPagination(lastDisplayedRow: Int) {}
    func search(for serieName: String) {}
    func handleSerieSelection(_ selectedId: Int) {}
}

final class SeriesInteractorSpy: SeriesBusinessLogic {
    
    private(set) var onViewDidLoadNumberOfTimesCalled = 0
    
    func onViewDidLoad() {
        onViewDidLoadNumberOfTimesCalled += 1
    }
    
    private(set) var checkPaginationNumberOfTimesCalled = 0
    
    func checkPagination(lastDisplayedRow: Int) {
        checkPaginationNumberOfTimesCalled += 1
    }
    
    private(set) var searchNumberOfTimesCalled = 0
    
    func search(for serieName: String) {
        searchNumberOfTimesCalled += 1
    }
    
    private(set) var handleSerieSelectionNumberOfTimesCalled = 0
    
    func handleSerieSelection(_ selectedId: Int) {
        handleSerieSelectionNumberOfTimesCalled += 1
    }
}

final class SeriesContentViewSpy: SeriesContentViewProtocol {
    
    private(set) var setupSeriesViewStatePassedViewStates = [Series.ViewState]()
    
    func setupSeriesViewState(_ viewState: Series.ViewState) {
        setupSeriesViewStatePassedViewStates.append(viewState)
    }
}

final class DispatchQueueTypeMock: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        work()
    }
}

final class SeriesRouterDummy: SeriesRoutingLogic {
    func routeToSerieDetailsScene() {}    
}

final class SeriesRouterSpy: SeriesRoutingLogic {
    
    private(set) var routeToSerieDetailsSceneNumberOfTimesCalled = 0
    
    func routeToSerieDetailsScene() {
        routeToSerieDetailsSceneNumberOfTimesCalled += 1
    }
}
