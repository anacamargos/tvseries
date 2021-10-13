//
//  DefaultURLProviderTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import XCTest
@testable import TVSeries

final class DefaultURLProviderTests: XCTestCase {

    func test_getBaseURL_shouldReturnCorrectURL() {
        // Given
        let sut = makeSUT()
        let expectedURL = "https://api.tvmaze.com"

        // When
        let receivedURL = sut.getBaseURL(forServiceGroup: .tvmaze)

        // Then
        XCTAssertEqual(expectedURL, receivedURL)
    }

    // MARK: - Test Helpers

    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> DefaultURLProvider {
        let sut = DefaultURLProvider()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}
