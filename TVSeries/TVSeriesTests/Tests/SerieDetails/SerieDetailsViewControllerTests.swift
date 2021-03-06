//
//  SerieDetailsViewControllerTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import XCTest
import SnapshotTesting
@testable import TVSeries

final class SerieDetailsViewControllerTests: XCTestCase {
    
    func test_seriesViewController() {
        let viewController = makeSUT()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.viewDidLoad()
        viewController.loadView()
        viewController.displaySerieDetailsViewData(.mock)
        viewController.displayEpisodesViewState(.loading)
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone8))
        navigationController.viewControllers.removeAll()
    }
    
    func test_viewDidLoad_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = SerieDetailsInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)

        // When
        sut.viewDidLoad()

        // Then
        XCTAssertEqual(interactorSpy.onViewDidLoadNumberOfTimesCalled, 1)
    }
    
    func test_displaySerieDetailsViewData_shouldCallCorrectMethodInContentView() {
        // Given
        let contentViewSpy = SerieDetailsContentViewSpy()
        let sut = makeSUT()
        sut.contentView = contentViewSpy
        let expectedViewState = SerieDetails.Serie.mock

        // When
        sut.displaySerieDetailsViewData(.mock)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupSerieDetailsViewDataPassedViewDatas), String(describing: [expectedViewState]))
    }
    
    func test_displayEpisodesViewState_shouldCallCorrectMethodInContentView() {
        // Given
        let contentViewSpy = SerieDetailsContentViewSpy()
        let sut = makeSUT()
        sut.contentView = contentViewSpy
        let expectedViewState = SerieDetails.ViewState.loading

        // When
        sut.displayEpisodesViewState(.loading)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupEpisodesViewStatePassedViewStates), String(describing: [expectedViewState]))
    }
    
    func test_handleSerieSelection_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = SerieDetailsInteractorSpy()
        let routerSpy = SerieDetailsRouterSpy()
        let sut = makeSUT(interactor: interactorSpy, router: routerSpy)
        guard let contentView = sut.view as? SerieDetailsContentView else {
            XCTFail("Could not find content view")
            return
        }
        let onTappedEpisodeCellClosure = Mirror(reflecting: contentView).firstChild(of: ((Int) -> Void).self, in: "onTappedEpisodeCellClosure")
        
        // When
        onTappedEpisodeCellClosure?(1)
        
        // Then
        XCTAssertEqual(interactorSpy.handleEpisodeSelecionNumberOfTimesCalled, 1)
        XCTAssertEqual(routerSpy.routeToEpisodeDetailsSceneNumberOfTimesCalled, 1)
    }

    // MARK: - Private Methods

    private func makeSUT(
        interactor: SerieDetailsBusinessLogic = SerieDetailsInteractorDummy(),
        router: SerieDetailsRoutingLogic = SerieDetailsRouterDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SerieDetailsViewController {
        let sut = SerieDetailsViewController(interactor: interactor, router: router, mainDispatchQueue: DispatchQueueTypeMock())
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}

final class SerieDetailsInteractorDummy: SerieDetailsBusinessLogic {
    func onViewDidLoad() {}
    func handleEpisodeSelecion(_ selectedId: Int) {}
}

final class SerieDetailsInteractorSpy: SerieDetailsBusinessLogic {
    
    private(set) var onViewDidLoadNumberOfTimesCalled = 0
    
    func onViewDidLoad() {
        onViewDidLoadNumberOfTimesCalled += 1
    }
    
    private(set) var handleEpisodeSelecionNumberOfTimesCalled = 0
    
    func handleEpisodeSelecion(_ selectedId: Int) {
        handleEpisodeSelecionNumberOfTimesCalled += 1
    }
}

final class SerieDetailsContentViewSpy: SerieDetailsContentViewProtocol {
    
    private(set) var setupSerieDetailsViewDataPassedViewDatas = [SerieDetails.Serie]()
    
    func setupSerieDetailsViewData(_ viewData: SerieDetails.Serie) {
        setupSerieDetailsViewDataPassedViewDatas.append(viewData)
    }
    
    private(set) var setupEpisodesViewStatePassedViewStates = [SerieDetails.ViewState]()
    
    func setupEpisodesViewState(_ viewState: SerieDetails.ViewState) {
        setupEpisodesViewStatePassedViewStates.append(viewState)
    }
}

final class SerieDetailsRouterDummy: SerieDetailsRoutingLogic {
    func routeToEpisodeDetailsScene() {}
}

final class SerieDetailsRouterSpy: SerieDetailsRoutingLogic {
    
    private(set) var routeToEpisodeDetailsSceneNumberOfTimesCalled = 0
    
    func routeToEpisodeDetailsScene() {
        routeToEpisodeDetailsSceneNumberOfTimesCalled += 1
    }
}
