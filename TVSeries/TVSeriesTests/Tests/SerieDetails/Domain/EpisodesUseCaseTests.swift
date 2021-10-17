//
//  EpisodesUseCaseTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import XCTest
@testable import TVSeries

final class EpisodesUseCaseTests: XCTestCase {
    
    func test_execute_whenServiceFails_shouldReturnCorrectError() {
        let serviceStub = SeriesServiceStub()
        serviceStub.getEpisodesDataResultToBeReturned = .failure(.genericError)
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .failure(.genericError))
    }

    func test_execute_whenServiceSucceeds_shouldReturnCorrectModel() {
        let serviceStub = SeriesServiceStub()
        serviceStub.getEpisodesDataResultToBeReturned = .success([.mock])
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .success(.mock))
    }

    // MARK: - Test Helpers

    func expect(
        _ sut: EpisodesUseCase,
        toCompleteWith expectedResult: Result<EpisodesUseCaseModel, EpisodesUseCaseError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.execute(serieID: 1) { receivedResult in
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
    ) -> EpisodesUseCase {
        let sut = EpisodesUseCase(service: service)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}
