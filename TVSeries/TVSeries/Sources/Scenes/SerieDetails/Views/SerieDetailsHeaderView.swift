//
//  SerieDetailsHeaderView.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

final class SerieDetailsHeaderView: CodedView {
    
    // MARK: - View Metrics
    
    private enum ViewMetrics {
        static let imageWidth: CGFloat = 150
        static let imageHeight: CGFloat = 220
    }
    
    // MARK: - Layout Components

    private let serieImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let serieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.subtitle.value, weight: .bold)
        label.numberOfLines = .zero
        return label
    }()

    private let serieSummaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()

    private let scheduleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        return label
    }()

    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = .zero
        return label
    }()
    
    // MARK: - Private Methods

    override func addSubviews() {
        addSubview(serieImageView)
        addSubview(serieNameLabel)
        addSubview(serieSummaryLabel)
        addSubview(scheduleLabel)
        addSubview(genresLabel)
    }

    override func constrainSubviews() {
        constrainSerieImageView()
        constrainSerieNameLabel()
        constrainSerieSummaryLabel()
        constrainScheduleLabel()
        constrainGenresLabel()
    }

    private func constrainSerieImageView() {
        serieImageView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            leadingConstant: Metrics.Spacing.xSmall,
            widthConstant: ViewMetrics.imageWidth,
            heightConstant: ViewMetrics.imageHeight
        )
    }

    private func constrainSerieNameLabel() {
        serieNameLabel.anchor(
            top: serieImageView.topAnchor,
            leading: serieImageView.trailingAnchor,
            trailing: trailingAnchor,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
        serieNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    private func constrainSerieSummaryLabel() {
        serieSummaryLabel.anchor(
            top: serieNameLabel.bottomAnchor,
            leading: serieImageView.trailingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.tiny,
            leadingConstant: Metrics.Spacing.small,
            bottomConstant: Metrics.Spacing.xSmall,
            trailingConstant: Metrics.Spacing.small
        )
    }

    private func constrainScheduleLabel() {
        scheduleLabel.anchor(
            top: serieImageView.bottomAnchor,
            leading: serieImageView.leadingAnchor,
            trailing: serieImageView.trailingAnchor,
            topConstant: Metrics.Spacing.xSmall
        )
    }

    private func constrainGenresLabel() {
        genresLabel.anchor(
            top: scheduleLabel.bottomAnchor,
            leading: serieImageView.leadingAnchor,
            bottom: bottomAnchor,
            trailing: serieImageView.trailingAnchor,
            topConstant: Metrics.Spacing.tiny,
            bottomConstant: Metrics.Spacing.xSmall
        )
    }
    
    // MARK: - Public Methods
    
    func setupViewData(_ viewData: SerieDetails.Serie) {
        serieNameLabel.text = viewData.name
        serieSummaryLabel.text = viewData.summary.htmlToString
        genresLabel.text = viewData.genres
        scheduleLabel.text = viewData.genres
        if let imageURL = viewData.imageURL {
            serieImageView.kf.indicatorType = .activity
            serieImageView.kf.setImage(with: imageURL)
        } else {
            serieImageView.image = .init()
        }
    }

}
