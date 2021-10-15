//
//  SeriesConfiguratorTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import XCTest
@testable import TVSeries

final class SeriesConfiguratorTests: XCTestCase {
    
    func test_configurator_shouldReturnCorrectlyConfiguredInstance() {
        // Given
        let sut = SeriesConfigurator()
        trackForMemoryLeaks(sut)
        
        // When
        let viewController = sut.resolveViewController()
        
        // Then
        guard let interactor = Mirror(reflecting: viewController).firstChild(of: SeriesInteractor.self) else {
            XCTFail("Could not find HomeInteractor.")
            return
        }
        guard let presenter = Mirror(reflecting: interactor).firstChild(of: SeriesPresenter.self) else {
            XCTFail("Could not find HomePresenter.")
            return
        }
        
        XCTAssertNotNil(presenter.viewController)
        XCTAssertTrue(presenter.viewController is SeriesViewController)
    }
}

extension Mirror {
    func firstChild<T>(of type: T.Type, in label: String? = nil) -> T? {
        children.lazy.compactMap {
            guard let value = $0.value as? T else { return nil }
            guard let label = label else { return value }
            return $0.label == label ? value : nil
        }.first
    }
}
