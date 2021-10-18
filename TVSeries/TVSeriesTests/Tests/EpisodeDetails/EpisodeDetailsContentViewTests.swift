//
//  EpisodeDetailsContentViewTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 18/10/21.
//

import XCTest
import SnapshotTesting
@testable import TVSeries

final class EpisodeDetailsContentViewTests: XCTestCase {
    
    func test_episodeDetailsContentView() {
        let view = makeView()
        view.setupEpisodeViewData(.mock)
        assertSnapshot(matching: view, as: .image)
    }

    // MARK: - Private Methods
    
    private func makeView() -> EpisodeDetailsContentView {
        let view = EpisodeDetailsContentView()
        view.frame = .init(origin: .zero, size: CGSize(width: 350, height: 600))
        return view
    }

}

extension EpisodeDetails.ViewData {
    static var mock: EpisodeDetails.ViewData {
        .init(id: 1, name: "Under the Dome", number: "S01 | E01", summary: "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>", imageURL: nil)
    }
    
    static var testMock: EpisodeDetails.ViewData {
        .init(id: 1, name: "Test 1", number: "S01 | E01", summary: "Test 1 Test 2 Test 3", imageURL: nil)
    }
}
