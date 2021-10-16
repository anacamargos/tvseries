//
//  EpisodeCell.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 16/10/21.
//

import UIKit

final class EpisodeCell: CodedTableViewCell {
    
    // MARK: - Constants
    
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
        static let grayAlpha: CGFloat = 0.3
        static let imageWidth: CGFloat = 100
        static let imageHeight: CGFloat = 120
    }
    
    // MARK: - Layout Components

    private let contentBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = ViewMetrics.cornerRadius
        view.layer.borderWidth = ViewMetrics.borderWidth
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(ViewMetrics.grayAlpha).cgColor
        view.clipsToBounds = true
        return view
    }()

    private let episodeImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let episodeNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.subtitle.value, weight: .bold)
        label.numberOfLines = .zero
        return label
    }()

    private let episodeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = .zero
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
}
