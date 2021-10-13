//
//  Constants.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 13/10/21.
//

import Foundation

enum Header {

    enum Key {
        static let contentType = "Content-Type"
    }

    enum ContentType {
        static let applicationJSON = "application/json"
        static let applicationJSONCharsetUTF8 = "application/json; charset=UTF-8"
        static let applicationFormURLEncoded = "application/x-www-form-urlencoded"
    }
}
