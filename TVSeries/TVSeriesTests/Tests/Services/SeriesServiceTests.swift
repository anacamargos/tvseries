//
//  SeriesServiceTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import XCTest
@testable import TVSeries

final class SeriesServiceTests: XCTestCase {
    
    func test_getSeriesData_whenRequestFails_shouldReturnCorrectError() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[SeriesResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        let errorMock = NetworkError(.internal(.noInternetConnection))
        dispatcherMock.requestCodableResultToBeReturned = .failure(errorMock)
        let expectedError = SeriesServiceError.genericError

        // When
        getSeriesDataExpect(sut, toCompleteWith: .failure(expectedError))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [SeriesRequest.series(page: 1)]))
    }

    func test_getSeriesData_whenRequestSucceeds_butResponseIsInvalid_shouldReturnCorrectError() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[SeriesResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        dispatcherMock.requestCodableResultToBeReturned = .success(nil)
        let expectedError = SeriesServiceError.responseParse

        // When
        getSeriesDataExpect(sut, toCompleteWith: .failure(expectedError))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [SeriesRequest.series(page: 1)]))
    }

    func test_getSeriesData_whenRequestSucceedsWithValidResponse_shouldReturnCorrectData() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[SeriesResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        dispatcherMock.requestCodableResultToBeReturned = .success([.mock])
        let expectedResponse = [SeriesResponseEntity.mock]

        // When
        getSeriesDataExpect(sut, toCompleteWith: .success(expectedResponse))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [SeriesRequest.series(page: 1)]))
    }
    
    func test_getEpisodesData_whenRequestFails_shouldReturnCorrectError() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[EpisodesResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        let errorMock = NetworkError(.internal(.noInternetConnection))
        dispatcherMock.requestCodableResultToBeReturned = .failure(errorMock)
        let expectedError = SeriesServiceError.genericError

        // When
        getEpisodesDataExpect(sut, toCompleteWith: .failure(expectedError))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [SeriesRequest.episodes(serieID: 1)]))
    }

    func test_getEpisodesData_whenRequestSucceeds_butResponseIsInvalid_shouldReturnCorrectError() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[EpisodesResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        dispatcherMock.requestCodableResultToBeReturned = .success(nil)
        let expectedError = SeriesServiceError.responseParse

        // When
        getEpisodesDataExpect(sut, toCompleteWith: .failure(expectedError))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [SeriesRequest.episodes(serieID: 1)]))
    }

    func test_getEpisodesData_whenRequestSucceedsWithValidResponse_shouldReturnCorrectData() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[EpisodesResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        dispatcherMock.requestCodableResultToBeReturned = .success([.mock])
        let expectedResponse = [EpisodesResponseEntity.mock]

        // When
        getEpisodesDataExpect(sut, toCompleteWith: .success(expectedResponse))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [SeriesRequest.episodes(serieID: 1)]))
    }
    
    func test_search_whenRequestFails_shouldReturnCorrectError() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[SearchResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        let errorMock = NetworkError(.internal(.noInternetConnection))
        dispatcherMock.requestCodableResultToBeReturned = .failure(errorMock)
        let expectedError = SeriesServiceError.genericError

        // When
        searchExpect(sut, toCompleteWith: .failure(expectedError))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [SeriesRequest.search(serieName: "Test")]))
    }

    func test_search_whenRequestSucceeds_butResponseIsInvalid_shouldReturnCorrectError() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[SearchResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        dispatcherMock.requestCodableResultToBeReturned = .success(nil)
        let expectedError = SeriesServiceError.responseParse

        // When
        searchExpect(sut, toCompleteWith: .failure(expectedError))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [SeriesRequest.search(serieName: "Test")]))
    }

    func test_search_whenRequestSucceedsWithValidResponse_shouldReturnCorrectData() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[SearchResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        dispatcherMock.requestCodableResultToBeReturned = .success([.mock])
        let expectedResponse = [SearchResponseEntity.mock]

        // When
        searchExpect(sut, toCompleteWith: .success(expectedResponse))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [SeriesRequest.search(serieName: "Test")]))
    }

    // MARK: - Test Helpers

    private func makeSUT(networkDispatcher: NetworkDispatcher) -> SeriesService {
        let sut = SeriesService(networkDispatcher: networkDispatcher)
        return sut
    }

    private func getSeriesDataExpect(
        _ sut: SeriesService,
        toCompleteWith expectedResult: Result<[SeriesResponseEntity], SeriesServiceError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.getSeriesData(with: 1) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(String(describing: receivedItems), String(describing: expectedItems), file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    private func getEpisodesDataExpect(
        _ sut: SeriesService,
        toCompleteWith expectedResult: Result<[EpisodesResponseEntity], SeriesServiceError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.getEpisodesData(with: 1) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(String(describing: receivedItems), String(describing: expectedItems), file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    private func searchExpect(
        _ sut: SeriesService,
        toCompleteWith expectedResult: Result<[SearchResponseEntity], SeriesServiceError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.search(serieName: "Test") { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(String(describing: receivedItems), String(describing: expectedItems), file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }

}

final class NetworkDispatcherMock<T: Codable>: NetworkDispatcher {

    var dispatchResultToBeReturned: Result<NetworkResponse, NetworkError> = .success(.init(status: .http(200), data: nil))
    private(set) var dispatchPassedRequests = [NetworkRequest]()

    func dispatch(_ request: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        dispatchPassedRequests.append(request)
        handle(dispatchResultToBeReturned)
    }

    var requestCodableResultToBeReturned: Result<T?, NetworkError> = .success(nil)
    private(set) var requestCodablePassedRequests = [NetworkRequest]()

    func requestCodable<T>(ofType type: T.Type, for request: NetworkRequest, then handle: @escaping (Result<T?, NetworkError>) -> Void) where T: Decodable, T: Encodable {
        requestCodablePassedRequests.append(request)
        switch requestCodableResultToBeReturned {
        case let .failure(error):
            handle(.failure(error))
        case let .success(anyValue):
            var valueToReturn: T?
            if let anyValue = anyValue, let castedValue = anyValue as? T {
                valueToReturn = castedValue
            }
            handle(.success(valueToReturn))
        }
    }
}

extension SeriesResponseEntity {
    static var mock: SeriesResponseEntity {
        .init(id: 1, name: "Once Upon a Time", genres: ["Drama"], schedule: .init(time: "22:00", days: [.friday]), image: .init(medium: "", original: ""), summary: "Test 1 Test 2 Test 3")
    }
}

extension EpisodesResponseEntity {
    static var mock: EpisodesResponseEntity {
        .init(id: 1, name: "Test 1", season: 1, number: 1, image: .init(medium: "", original: ""), summary: "Test 1 Test 2 Test 3")
    }
}

extension SearchResponseEntity {
    static var mock: SearchResponseEntity {
        .init(score: 1, show: .mock)
    }
}
