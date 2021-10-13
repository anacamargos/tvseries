//
//  URLParameters.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

/// Defines which kind of parameters are to be added to on the URL, as a QueryParameter.
enum URLParameters {
    /// - raw: means that the data can be added as is.
    case raw([String: String])
}
