//
//  EpisodeDetailsConfiguratorTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 18/10/21.
//

import XCTest
@testable import TVSeries

final class EpisodeDetailsConfiguratorTests: XCTestCase {

    func test_configurator_shouldReturnCorrectlyConfiguredInstance() {
        // Given
        let sut = EpisodeDetailsConfigurator()
        trackForMemoryLeaks(sut)
        
        // When
        let viewController = sut.resolveViewController(using: .init(selectedEpisode: .mock))
        
        // Then
        guard let interactor = Mirror(reflecting: viewController).firstChild(of: EpisodeDetailsInteractor.self) else {
            XCTFail("Could not find HomeInteractor.")
            return
        }
        guard let presenter = Mirror(reflecting: interactor).firstChild(of: EpisodeDetailsPresenter.self) else {
            XCTFail("Could not find HomePresenter.")
            return
        }
        
        XCTAssertNotNil(presenter.viewController)
        XCTAssertTrue(presenter.viewController is EpisodeDetailsViewController)
    }

}
