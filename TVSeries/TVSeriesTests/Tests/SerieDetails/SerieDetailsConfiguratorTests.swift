//
//  SerieDetailsConfiguratorTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import XCTest
@testable import TVSeries

final class SerieDetailsConfiguratorTests: XCTestCase {

    func test_configurator_shouldReturnCorrectlyConfiguredInstance() {
        // Given
        let sut = SerieDetailsConfigurator(networkDispatcher: NetworkDispatcherDummy())
        trackForMemoryLeaks(sut)
        
        // When
        let viewController = sut.resolveViewController(using: .init(selectedSerie: .mock))
        
        // Then
        guard let interactor = Mirror(reflecting: viewController).firstChild(of: SerieDetailsInteractor.self) else {
            XCTFail("Could not find HomeInteractor.")
            return
        }
        guard let presenter = Mirror(reflecting: interactor).firstChild(of: SerieDetailsPresenter.self) else {
            XCTFail("Could not find HomePresenter.")
            return
        }
        
        XCTAssertNotNil(presenter.viewController)
        XCTAssertTrue(presenter.viewController is SerieDetailsViewController)
    }

}

final class NetworkDispatcherDummy: NetworkDispatcher {
    func dispatch(_ request: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {}
    func requestCodable<T>(ofType type: T.Type, for request: NetworkRequest, then handle: @escaping (Result<T?, NetworkError>) -> Void) where T: Decodable, T: Encodable {}
}
