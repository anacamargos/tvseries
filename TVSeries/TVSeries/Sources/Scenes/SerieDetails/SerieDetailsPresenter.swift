//
//  SerieDetailsPresenter.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import Foundation

protocol SerieDetailsPresentationLogic {
    func presentSerieDetails(_ response: SeriesUseCaseModel.Serie)
    func presentEpisodesResponse(_ response: SerieDetails.Response)
}

final class SerieDetailsPresenter {
    
    // MARK: - Dependecies

    weak var viewController: SerieDetailsDisplayLogic?
    
    // MARK: - Private Methods
    
    private func mapResponseDataToViewData(_ response: EpisodesUseCaseModel) -> [Int: [SerieDetails.Episode.ViewData]] {
        let dictionary = Dictionary(grouping: response.data) { $0.season }
        var formattedDictionary: [Int: [SerieDetails.Episode.ViewData]] = [:]
        dictionary.keys.forEach { key in
            guard let dictionaryValue = dictionary[key] else { return }
            let viewData = dictionaryValue.map { currentEpisode -> SerieDetails.Episode.ViewData in
                let season = String(format: "%02d", currentEpisode.season)
                let number = String(format: "%02d", currentEpisode.number)
                return SerieDetails.Episode.ViewData(id: currentEpisode.id, name: currentEpisode.name, number: "S\(season) | E\(number)", imageURL: URL(string: currentEpisode.image?.medium ?? ""))
            }
            formattedDictionary[key] = viewData
        }
        return formattedDictionary
    }
}

// MARK: - SerieDetailsPresentationLogic

extension SerieDetailsPresenter: SerieDetailsPresentationLogic {
    
    func presentSerieDetails(_ response: SeriesUseCaseModel.Serie) {
        var scheduleText = L10n.Series.schedule
        for day in response.schedule.days {
            scheduleText.append(day.rawValue + "s,")
        }

        scheduleText.removeLast()

        if !response.schedule.time.isEmpty {
            scheduleText.append(L10n.Series.at(response.schedule.time))
        }
        
        var genresText = L10n.Series.genres
        genresText.append(response.genres.joined(separator: ", "))

        let viewData = SerieDetails.Serie(name: response.name, summary: response.summary, imageURL: URL(string: response.image?.medium ?? ""), schedule: scheduleText, genres: genresText)
        viewController?.displaySerieDetailsViewData(viewData)
    }
    
    func presentEpisodesResponse(_ response: SerieDetails.Response) {
        let viewState: SerieDetails.ViewState
        switch response {
        case .error:
            viewState = .error
        case .loading:
            viewState = .loading
        case let .content(responseData):
            let viewData = mapResponseDataToViewData(responseData)
            viewState = .content(viewData)
        }
        viewController?.displayEpisodesViewState(viewState)
    }
}
