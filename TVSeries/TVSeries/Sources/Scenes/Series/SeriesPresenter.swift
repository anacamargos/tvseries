//
//  SeriesPresenter.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import Foundation

protocol SeriesPresentationLogic {
    func presentSeries(_ response: Series.Response)
}

final class SeriesPresenter {
    
    // MARK: - Dependecies

    weak var viewController: SeriesDisplayLogic?
    
    // MARK: - Private Methods
    
    private func mapResponseToViewData(_ response: SeriesUseCaseModel) -> Series.ViewData {
        let viewItems = response.data.map {
            Series.Serie(id: $0.id, name: $0.name, imageURL: URL(string: $0.image?.medium ?? ""), summary: $0.summary)
        }
        let viewData = Series.ViewData(series: viewItems)
        return viewData
    }
}

// MARK: - Presentation Logic

extension SeriesPresenter: SeriesPresentationLogic {
    
    func presentSeries(_ response: Series.Response) {
        let viewState: Series.ViewState
        switch response {
        case .empty:
            viewState = .empty
        case .error:
            viewState = .error
        case .loading:
            viewState = .loading
        case let .content(responseData):
            let viewData = mapResponseToViewData(responseData)
            viewState = .content(viewData)
        }
        viewController?.displaySeriesViewState(viewState)
    }
}
