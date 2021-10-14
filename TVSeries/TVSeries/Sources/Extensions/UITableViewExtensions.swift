//
//  UITableViewExtensions.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import UIKit

extension UITableView {

    func reusableCell<T: UITableViewCell>(for identifier: String, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
            return cell
        }

        return T()
    }
}
