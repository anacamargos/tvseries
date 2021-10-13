//
//  SeriesResponseEntity.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

struct SeriesResponseEntity: Codable {
    let id: Int
    let name: String
    let genres: [String]
    let schedule: Schedule
    let image: CommonEntity.Image
    let summary: String
    
    struct Schedule: Codable {
        let time: String
        let days: [String]
    }
}

enum CommonEntity {
    struct Image: Codable {
        let medium, original: String
    }
}
