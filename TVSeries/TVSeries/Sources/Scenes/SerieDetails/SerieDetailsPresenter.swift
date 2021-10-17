//
//  SerieDetailsPresenter.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import Foundation

protocol SerieDetailsPresentationLogic {
    func presentSerieDetails(_ response: SeriesUseCaseModel.Serie)
}

final class SerieDetailsPresenter {
    
    // MARK: - Dependecies

    weak var viewController: SerieDetailsDisplayLogic?
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
}
