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
        case iconDown = "icon-down"
        case iconUp = "icon-up"
    }

    class var reloadArrow: UIImage { UIImage(.reloadArrow)! }
    class var iconDown: UIImage { UIImage(.iconDown)! }
    class var iconUp: UIImage { UIImage(.iconUp)! }

    convenience init?(_ resource: Resource) {
        self.init(
            named: resource.rawValue
        )
    }
}
