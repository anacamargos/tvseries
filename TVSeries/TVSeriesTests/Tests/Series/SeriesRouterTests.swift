//
//  SeriesRouterTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import XCTest
@testable import TVSeries

final class SeriesRouterTests: XCTestCase {
    
    func test_routeToSerieDetailsScene_shouldPushViewController() {
        // Given
        let sut = makeSUT()
        let navigationControllerSpy = makeNavigationViewController(sut)
        
        // When
        sut.routeToSerieDetailsScene()
        
        // Then
        XCTAssertEqual(navigationControllerSpy.pushViewControllerAnimatedFlagPassed, [false, true])
        XCTAssertTrue(navigationControllerSpy.viewControllerToPresentPassed[1] is SerieDetailsViewController)
    }
    
    func test_routeToSerieDetailsScene_whenDatStoreIsNil_shouldNotPushViewController() {
        // Given
        let dataStore = SeriesDataStoreDummy()
        dataStore.selectedSerie = nil
        let sut = makeSUT(dataStore: dataStore)
        let navigationControllerSpy = makeNavigationViewController(sut)
        
        // When
        sut.routeToSerieDetailsScene()
        
        // Then
        XCTAssertEqual(navigationControllerSpy.pushViewControllerAnimatedFlagPassed, [false])
    }

    // MARK: - Test Helpers

    private func makeSUT(
        dataStore: SeriesDataStore = SeriesDataStoreDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SeriesRouter {
        let sut = SeriesRouter(serieDetailsConfigurator: .init(networkDispatcher: NetworkDispatcherDummy()), dataStore: dataStore)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func makeNavigationViewController(_ sut: SeriesRouter) -> UINavigationControllerSpy {
        let viewController = UIViewController()
        let navigationControllerSpy = UINavigationControllerSpy(rootViewController: viewController)
        sut.viewController = viewController
        return navigationControllerSpy
    }
    
    private func makeViewController(_ sut: SeriesRouter) -> UIViewControllerSpy {
        let viewController = UIViewControllerSpy()
        sut.viewController = viewController
        return viewController
    }

}

final class SeriesDataStoreDummy: SeriesDataStore {
    var selectedSerie: SeriesUseCaseModel.Serie? = .mock
}

final class UINavigationControllerSpy: UINavigationController {
    private(set) var viewControllerToPresentPassed = [UIViewController]()
    private(set) var pushViewControllerAnimatedFlagPassed = [Bool]()
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewControllerToPresentPassed.append(viewController)
        pushViewControllerAnimatedFlagPassed.append(animated)
        super.pushViewController(viewController, animated: animated)
    }
    
    private(set) var popViewControllerAnimatedFlagPassed = [Bool]()
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popViewControllerAnimatedFlagPassed.append(animated)
        return super.popViewController(animated: animated)
    }
    
    private(set) var popToViewControllerAnimatedFlagPassed = [Bool]()
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        popToViewControllerAnimatedFlagPassed.append(animated)
        return super.popToViewController(viewController, animated: animated)
    }

    private(set) var popToRootViewControllerAnimatedFlagPassed = [Bool]()

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popToRootViewControllerAnimatedFlagPassed.append(animated)
        return super.popToRootViewController(animated: animated)
    }

}

final class UIViewControllerSpy: UIViewController {
    
    private(set) var viewControllerToPresentPassed = [UIViewController]()
    private(set) var presentAnimatedFlagPassed = [Bool]()
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresentPassed.append(viewControllerToPresent)
        presentAnimatedFlagPassed.append(flag)
    }
    
    private(set) var dismissAnimatedFlagPassed = [Bool]()
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissAnimatedFlagPassed.append(flag)
    }
}
