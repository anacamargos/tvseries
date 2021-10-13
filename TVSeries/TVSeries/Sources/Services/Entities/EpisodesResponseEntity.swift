//
//  EpisodesResponseEntity.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

struct EpisodesResponseEntity: Codable {
    let id: Int
    let name: String
    let season, number: Int
    let image: CommonEntity.Image
    let summary: String
}
