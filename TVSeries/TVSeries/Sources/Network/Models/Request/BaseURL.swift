//
//  BaseURL.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

/// Defines a Base URL, which can come from a String or a Service Group
enum BaseURL {
    /// Represents a BaseURL that comes form a string
    case string(String)
    /// Represents a BaseURL that comes from a Service Group
    case serviceGroup(ServiceGroup)
}
