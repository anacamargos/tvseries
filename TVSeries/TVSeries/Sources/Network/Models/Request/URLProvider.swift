//
//  URLProvider.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

/// Defines a service group to provide URLs
/// A ServiceGroup is a sum of endpoints that exist on the applications context.
enum ServiceGroup {
    case tvmaze
}

/// Defines a  provider of URLs
protocol URLProvider {
    /// Returns a baseURL string acording to the  ServiceGroup
    /// - Parameters:
    ///   - group: a service group that defines the URL
    func getBaseURL(
        forServiceGroup group: ServiceGroup
    ) -> String
}

final class DefaultURLProvider: URLProvider {

    // MARK: - Constants

    private let https = "https://"
    private let http = "http://"

    // MARK: - Initialization

    init() {}

    // MARK: - Public Functions

    func getBaseURL(
        forServiceGroup group: ServiceGroup
    ) -> String {
        var url: String

        switch group {
        case .tvmaze:
            url = getTvmazeURL()
        }
        return https + url
    }

    // MARK: - Private Methods

    private func getTvmazeURL() -> String {
        return "api.tvmaze.com"
    }
}
