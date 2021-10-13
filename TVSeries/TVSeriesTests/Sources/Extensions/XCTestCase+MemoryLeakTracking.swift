//
//  XCTestCase+MemoryLeakTracking.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
