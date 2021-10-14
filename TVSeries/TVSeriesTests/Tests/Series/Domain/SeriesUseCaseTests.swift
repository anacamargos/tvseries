//
//  SeriesUseCaseTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import XCTest
@testable import TVSeries

final class SeriesUseCaseTests: XCTestCase {
    
    func test_execute_whenServiceFails_shouldReturnCorrectError() {
        let serviceStub = SeriesServiceStub()
        serviceStub.getSeriesDataResultToBeReturned = .failure(.genericError)
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .failure(.genericError))
    }

    func test_execute_whenServiceSucceeds_shouldReturnCorrectModel() {
        let serviceStub = SeriesServiceStub()
        serviceStub.getSeriesDataResultToBeReturned = .success([.mock])
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .success(.mock))
    }
    
    func test_executeSearch_whenServiceFails_shouldReturnCorrectError() {
        let serviceStub = SeriesServiceStub()
        serviceStub.searchResultToBeReturned = .failure(.genericError)
        let sut = makeSUT(service: serviceStub)
        searchExpect(sut, toCompleteWith: .failure(.genericError))
    }

    func test_executeSearch_whenServiceSucceeds_shouldReturnCorrectModel() {
        let serviceStub = SeriesServiceStub()
        serviceStub.searchResultToBeReturned = .success([.mock])
        let sut = makeSUT(service: serviceStub)
        searchExpect(sut, toCompleteWith: .success(.mock))
    }
    
    // MARK: - Test Helpers

    func expect(
        _ sut: SeriesUseCase,
        toCompleteWith expectedResult: Result<SeriesUseCaseModel, SeriesUseCaseError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.execute(page: 1) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedResponse), .success(expectedResponse)):
                XCTAssertEqual(String(describing: receivedResponse), String(describing: expectedResponse), file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    func searchExpect(
        _ sut: SeriesUseCase,
        toCompleteWith expectedResult: Result<SeriesUseCaseModel, SeriesUseCaseError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.execute(serieName: "Test") { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedResponse), .success(expectedResponse)):
                XCTAssertEqual(String(describing: receivedResponse), String(describing: expectedResponse), file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }

    private func makeSUT(
        service: SeriesServiceProvider = SeriesServiceDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> SeriesUseCase {
        let sut = SeriesUseCase(service: service)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}

final class SeriesServiceStub: SeriesServiceProvider {
    
    var getSeriesDataResultToBeReturned: Result<[SeriesResponseEntity], SeriesServiceError> = .success([.mock])
    
    func getSeriesData(with page: Int, then handle: @escaping (Result<[SeriesResponseEntity], SeriesServiceError>) -> Void) {
        handle(getSeriesDataResultToBeReturned)
    }
    
    var getEpisodesDataResultToBeReturned: Result<[EpisodesResponseEntity], SeriesServiceError> = .success([.mock])
    
    func getEpisodesData(with serieID: Int, then handle: @escaping (Result<[EpisodesResponseEntity], SeriesServiceError>) -> Void) {
        handle(getEpisodesDataResultToBeReturned)
    }
    
    var searchResultToBeReturned: Result<[SearchResponseEntity], SeriesServiceError> = .success([.mock])
    
    func search(serieName: String, then handle: @escaping (Result<[SearchResponseEntity], SeriesServiceError>) -> Void) {
        handle(searchResultToBeReturned)
    }
}

final class SeriesServiceDummy: SeriesServiceProvider {
    func getSeriesData(with page: Int, then handle: @escaping (Result<[SeriesResponseEntity], SeriesServiceError>) -> Void) {}
    func getEpisodesData(with serieID: Int, then handle: @escaping (Result<[EpisodesResponseEntity], SeriesServiceError>) -> Void) {}
    func search(serieName: String, then handle: @escaping (Result<[SearchResponseEntity], SeriesServiceError>) -> Void) {}
}

extension SeriesUseCaseModel {
    static var mock: SeriesUseCaseModel {
        .init(data: [.mock])
    }
}

extension SeriesUseCaseModel.Serie {
    static var mock: SeriesUseCaseModel.Serie {
        .init(id: 1, name: "Once Upon a Time", genres: ["Drama"], schedule: .init(time: "", days: [.friday]), image: .init(medium: "", original: ""), summary: "Test 1 Test 2 Test 3")
    }
}
