//
//  SeriesContentViewTests.swift
//  TVSeriesTests
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import XCTest
import SnapshotTesting
@testable import TVSeries

final class SeriesContentViewTests: XCTestCase {
    
    func test_seriesContentView_contentState() {
        let view = makeView()
        view.setupSeriesViewState(.content(.mock))
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_seriesContentView_errorState() {
        let view = makeView()
        view.setupSeriesViewState(.error)
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_seriesContentView_loadingState() {
        let view = makeView()
        view.setupSeriesViewState(.loading)
        assertSnapshot(matching: view, as: .image)
    }
    
    func test_seriesContentView_emptyState() {
        let view = makeView()
        view.setupSeriesViewState(.empty)
        assertSnapshot(matching: view, as: .image)
    }
    
    // MARK: - Private Methods
    
    private func makeView() -> SeriesContentView {
        let view = SeriesContentView(onWillDisplayNewCells: { _ in }, onTappedSerieClosure: { _ in })
        view.frame = .init(origin: .zero, size: CGSize(width: 350, height: 600))
        return view
    }
}

extension Series.ViewData {
    static var mock: Series.ViewData {
        .init(series: [.underTheDomeMock, .personOfInterestMock])
    }
}

extension Series.Serie {
    static var underTheDomeMock: Series.Serie {
        .init(id: 1, name: "Under the Dome", imageURL: URL(string: ""), summary: "<p><b>Under the Dome</b> is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome. The town's inhabitants must deal with surviving the post-apocalyptic conditions while searching for answers about the dome, where it came from and if and when it will go away.</p>")
    }
    
    static var personOfInterestMock: Series.Serie {
        .init(id: 2, name: "Person of Interest", imageURL: URL(string: ""), summary: "<p>You are being watched. The government has a secret system, a machine that spies on you every hour of every day. I know because I built it. I designed the Machine to detect acts of terror but it sees everything. Violent crimes involving ordinary people. People like you. Crimes the government considered \"irrelevant\". They wouldn't act so I decided I would. But I needed a partner. Someone with the skills to intervene. Hunted by the authorities, we work in secret. You'll never find us. But victim or perpetrator, if your number is up, we'll find you.</p>")
    }
    
    static var mock: Series.Serie {
        .init(id: 1, name: "Once Upon a Time", imageURL: URL(string: ""), summary: "Test 1 Test 2 Test 3")
    }
}
