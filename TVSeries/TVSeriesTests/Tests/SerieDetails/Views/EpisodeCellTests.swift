//
//  EpisodeCellTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import XCTest
import SnapshotTesting
@testable import TVSeries

final class EpisodeCellTests: XCTestCase {
    
    func test_episodeCell() {
        let view = makeView()
        view.setupViewData(.firstEpisodeMock)
        assertSnapshot(matching: view, as: .image)
    }
    
    // MARK: - Private Methods
    
    private func makeView() -> EpisodeCell {
        let view = EpisodeCell()
        view.frame = .init(origin: .zero, size: CGSize(width: 350, height: 90))
        return view
    }
}
