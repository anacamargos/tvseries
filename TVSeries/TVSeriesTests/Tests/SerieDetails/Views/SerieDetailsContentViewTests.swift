//
//  SerieDetailsContentViewTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 16/10/21.
//

import XCTest
import SnapshotTesting
@testable import TVSeries

final class SerieDetailsContentViewTests: XCTestCase {
    
    func test_seriesContentView_contentState() {
        let view = makeView()
        view.setupSerieDetailsViewData(.mock)
        assertSnapshot(matching: view, as: .image)
    }

    // MARK: - Private Methods
    
    private func makeView() -> SerieDetailsContentView {
        let view = SerieDetailsContentView()
        view.frame = .init(origin: .zero, size: CGSize(width: 350, height: 600))
        return view
    }

}

extension SerieDetails.Serie {
    static var mock: SerieDetails.Serie {
        .init(name: "Under the Dome", summary: "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>", imageURL: nil, schedule: "Schedule: Thursdays at 22:00", genres: "Genres: Drama, Science-Fiction, Thriller")
    }
}
