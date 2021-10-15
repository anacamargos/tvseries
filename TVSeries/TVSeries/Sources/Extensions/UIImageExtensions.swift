//
//  UIImageExtensions.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//
// swiftlint:disable force_unwrapping

import UIKit

extension UIImage {

    enum Resource: String {
        case reloadArrow = "reload-arrow"
    }

    class var reloadArrow: UIImage { UIImage(.reloadArrow)! }

    convenience init?(_ resource: Resource) {
        self.init(
            named: resource.rawValue
        )
    }
}
