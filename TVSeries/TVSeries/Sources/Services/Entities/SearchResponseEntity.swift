//
//  SearchResponseEntity.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

struct SearchResponseEntity: Codable {
    let score: Double
    let show: SeriesResponseEntity
}
