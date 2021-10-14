//
//  SeriesUseCaseModels.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

enum SeriesUseCaseError: Error {
    case genericError
}

struct SeriesUseCaseModel {
    
    let data: [Serie]
    
    struct Serie {
        let id: Int
        let name: String
        let genres: [String]
        let schedule: Schedule
        let image: CommonUseCaseModel.Image?
        let summary: String
    }
    
    struct Schedule {
        let time: String
        let days: [Day]
    }
}

enum CommonUseCaseModel {
    struct Image {
        let medium, original: String
    }

    static func getImage(_ image: CommonEntity.Image?) -> CommonUseCaseModel.Image? {
        guard let image = image else { return nil }
        return CommonUseCaseModel.Image(medium: image.medium, original: image.original)
    }
}
