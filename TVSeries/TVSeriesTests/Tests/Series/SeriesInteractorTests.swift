//
//  SeriesInteractorTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import XCTest
@testable import TVSeries

final class SeriesInteractorTests: XCTestCase {
    
    func test_onViewDidLoad_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SeriesUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success(.mock)
        let presenterSpy = SeriesPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, seriesUseCase: useCaseStub)
        let expectedResponse = Series.Response.content(.mock)

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSeriesPassedResponses), String(describing: [.loading, expectedResponse]))
    }
    
    func test_onViewDidLoad_whenUseCaseSucceedsWithEmptyResponse_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SeriesUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success(.init(data: []))
        let presenterSpy = SeriesPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, seriesUseCase: useCaseStub)
        let expectedResponse = Series.Response.empty

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSeriesPassedResponses), String(describing: [.loading, expectedResponse]))
    }
    
    func test_onViewDidLoad_whenUseCaseSucceedsWithErrorResponse_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SeriesUseCaseStub()
        useCaseStub.executeResultToBeReturned = .failure(.genericError)
        let presenterSpy = SeriesPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, seriesUseCase: useCaseStub)
        let expectedResponse = Series.Response.error

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSeriesPassedResponses), String(describing: [.loading, expectedResponse]))
    }
    
    func test_checkPagination_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SeriesUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success(.mock)
        let presenterSpy = SeriesPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, seriesUseCase: useCaseStub)
        let expectedResponse = Series.Response.content(.mock)

        // When
        sut.onViewDidLoad()
        sut.checkPagination(lastDisplayedRow: 1)

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSeriesPassedResponses), String(describing: [.loading, expectedResponse, .content(.init(data: [.mock, .mock]))]))
    }
    
    func test_checkPagination_whenUseCaseFails_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SeriesUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success(.mock)
        let presenterSpy = SeriesPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, seriesUseCase: useCaseStub)
        let expectedResponse = Series.Response.error

        // When
        sut.onViewDidLoad()
        useCaseStub.executeResultToBeReturned = .failure(.genericError)
        sut.checkPagination(lastDisplayedRow: 1)

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSeriesPassedResponses), String(describing: [.loading, .content(.mock), expectedResponse]))
    }
    
    func test_search_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SeriesUseCaseStub()
        useCaseStub.executeSerieNameResultToBeReturned = .success(.mock)
        let presenterSpy = SeriesPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, seriesUseCase: useCaseStub)
        let expectedResponse = Series.Response.content(.mock)

        // When
        sut.search(for: "")

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSeriesPassedResponses), String(describing: [.loading, expectedResponse]))
    }
    
    func test_search_whenUseCaseSucceedsWithEmptyResponse_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SeriesUseCaseStub()
        useCaseStub.executeSerieNameResultToBeReturned = .success(.init(data: []))
        let presenterSpy = SeriesPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, seriesUseCase: useCaseStub)
        let expectedResponse = Series.Response.empty

        // When
        sut.search(for: "")

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSeriesPassedResponses), String(describing: [.loading, expectedResponse]))
    }
    
    func test_search_whenUseCaseFails_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SeriesUseCaseStub()
        useCaseStub.executeSerieNameResultToBeReturned = .failure(.genericError)
        let presenterSpy = SeriesPresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, seriesUseCase: useCaseStub)
        let expectedResponse = Series.Response.error

        // When
        sut.search(for: "")

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentSeriesPassedResponses), String(describing: [.loading, expectedResponse]))
    }
    
    func test_handleSerieSelection_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SeriesUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success(.mock)
        let sut = makeSUT(seriesUseCase: useCaseStub)

        // When
        sut.onViewDidLoad()
        sut.handleSerieSelection(1)

        // Then
        guard let selectedSerie = sut.selectedSerie else {
            XCTFail("Could not find selectedSerie")
            return
        }
        XCTAssertEqual(String(describing: selectedSerie), String(describing: SeriesUseCaseModel.Serie.mock))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        presenter: SeriesPresentationLogic = SeriesPresenterDummy(),
        seriesUseCase: SeriesUseCaseProvider = SeriesUseCaseDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SeriesInteractor {
        let sut = SeriesInteractor(presenter: presenter, seriesUseCase: seriesUseCase)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}

final class SeriesPresenterDummy: SeriesPresentationLogic {
    func presentSeries(_ response: Series.Response) {}
}

final class SeriesUseCaseDummy: SeriesUseCaseProvider {
    func execute(page: Int, then handle: @escaping (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void) {}
    func execute(serieName: String, then handle: @escaping (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void) {}
}

final class SeriesUseCaseStub: SeriesUseCaseProvider {
    
    var executeResultToBeReturned: Result<SeriesUseCaseModel, SeriesUseCaseError> = .success(.mock)
    
    func execute(page: Int, then handle: @escaping (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void) {
        handle(executeResultToBeReturned)
    }
    
    var executeSerieNameResultToBeReturned: Result<SeriesUseCaseModel, SeriesUseCaseError> = .success(.mock)
    
    func execute(serieName: String, then handle: @escaping (Result<SeriesUseCaseModel, SeriesUseCaseError>) -> Void) {
        handle(executeSerieNameResultToBeReturned)
    }
}

final class SeriesPresenterSpy: SeriesPresentationLogic {
    
    private(set) var presentSeriesPassedResponses = [Series.Response]()
    
    func presentSeries(_ response: Series.Response) {
        presentSeriesPassedResponses.append(response)
    }
}
