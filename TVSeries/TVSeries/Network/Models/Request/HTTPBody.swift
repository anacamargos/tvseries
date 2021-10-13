//
//  HTTPBody.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

/// Defines what can be added to the HTTPBody parameter of the request.
enum HTTPBody {
    case data(Data)
    case dictionary([String: Any])
    case json(Any)
}
