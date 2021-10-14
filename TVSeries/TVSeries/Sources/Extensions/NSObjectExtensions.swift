//
//  NSObjectExtensions.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import Foundation

extension NSObject {

    static var className: String {
        return String(describing: self)
    }
}
