//
//  SeriesInteractor.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import Foundation

protocol SeriesBusinessLogic {
    func onViewDidLoad()
    func checkPagination(lastDisplayedRow: Int)
    func search(for serieName: String)
    func handleSerieSelection(_ selectedId: Int)
}

protocol SeriesDataStore {
    var selectedSerie: SeriesUseCaseModel.Serie? { get }
}

final class SeriesInteractor: SeriesDataStore {
    
    // MARK: - Dependencies

    private let presenter: SeriesPresentationLogic
    private let seriesUseCase: SeriesUseCaseProvider
    
    // MARK: - Private Properties

    private var page: Int = 0
    private var nextPageCalled: Bool = false
    private var series: SeriesUseCaseModel = .init(data: [])
    var selectedSerie: SeriesUseCaseModel.Serie?
    
    // MARK: - Initialization

    init(
        presenter: SeriesPresentationLogic,
        seriesUseCase: SeriesUseCaseProvider
    ) {
        self.presenter = presenter
        self.seriesUseCase = seriesUseCase
    }
    
    // MARK: - Private Methods

    private func loadSeriesData() {
        presenter.presentSeries(.loading)
        seriesUseCase.execute(page: page) { [weak self] result in
            switch result {
            case let .success(response):
                self?.series = response
                if response.data.isEmpty {
                    self?.presenter.presentSeries(.empty)
                } else {
                    self?.presenter.presentSeries(.content(response))
                }
            case .failure:
                self?.presenter.presentSeries(.error)
            }
        }
    }
    
    private func loadNexSeriesPage() {
        seriesUseCase.execute(page: page) { [weak self] result in
            guard let self = self else { return }
            self.nextPageCalled = false
            switch result {
            case let .success(response):
                self.series.data.append(contentsOf: response.data)
                self.presenter.presentSeries(.content(self.series))
            case .failure:
                self.presenter.presentSeries(.error)
            }
        }
    }
    
    private func searchSeries(with serieName: String) {
        presenter.presentSeries(.loading)
        seriesUseCase.execute(serieName: serieName) { [weak self] result in
            switch result {
            case let .success(response):
                self?.series = response
                if response.data.isEmpty {
                    self?.presenter.presentSeries(.empty)
                } else {
                    self?.presenter.presentSeries(.content(response))
                }
            case .failure:
                self?.presenter.presentSeries(.error)
            }
        }
    }
}

// MARK: - Business Logic

extension SeriesInteractor: SeriesBusinessLogic {
    func onViewDidLoad() {
        page = 0
        loadSeriesData()
    }

    func checkPagination(lastDisplayedRow: Int) {
        guard !series.data.isEmpty else { return }
        if lastDisplayedRow + 20 >= series.data.count && nextPageCalled == false {
            page += 1
            nextPageCalled = true
            loadNexSeriesPage()
        }
    }

    func search(for seriesName: String) {
        searchSeries(with: seriesName)
    }
    
    func handleSerieSelection(_ selectedId: Int) {
        let selectedSerie = series.data.first(where: { $0.id == selectedId })
        self.selectedSerie = selectedSerie
    }
}
