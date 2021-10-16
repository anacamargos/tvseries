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
    
    func layoutTableHeaderView(animated: Bool = false) {
        
        guard let headerView = self.tableHeaderView else { return }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerWidth = headerView.bounds.size.width
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                frame.size.height = height
                headerView.frame = frame
                self.tableHeaderView = headerView
            }
        } else {
            frame.size.height = height
            headerView.frame = frame
            self.tableHeaderView = headerView
        }
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }
}
