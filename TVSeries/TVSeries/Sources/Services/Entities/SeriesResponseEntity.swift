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
        let days: [Day]
    }
}

enum CommonEntity {
    struct Image: Codable {
        let medium, original: String
    }
}

enum Day: String, Codable {
    case friday = "Friday"
    case monday = "Monday"
    case saturday = "Saturday"
    case sunday = "Sunday"
    case thursday = "Thursday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
}
