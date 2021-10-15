//
//  SerieDetailsHeaderView.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

final class SerieDetailsHeaderView: CodedView {
    
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
            leadingConstant: 10,
            widthConstant: 150,
            heightConstant: 220)
    }

    private func constrainSerieNameLabel() {
        serieNameLabel.anchor(
            top: serieImageView.topAnchor,
            leading: serieImageView.trailingAnchor,
            trailing: rightAnchor,
            leadingConstant: 12,
            trailingConstant: 12
        )
        serieNameLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    private func constrainSerieSummaryLabel() {
        serieSummaryLabel.anchor(
            top: serieNameLabel.bottomAnchor,
            leading: serieImageView.trailingAnchor,
            bottom: bottomAnchor,
            trailing: rightAnchor,
            topConstant: 2,
            leadingConstant: 12,
            bottomConstant: 10,
            trailingConstant: 12
        )
    }

    private func constrainScheduleLabel() {
        scheduleLabel.anchor(
            top: serieImageView.bottomAnchor,
            leading: serieImageView.leadingAnchor,
            trailing: serieImageView.trailingAnchor,
            topConstant: 10
        )
    }

    private func constrainGenresLabel() {
        genresLabel.anchor(top: scheduleLabel.bottomAnchor,
                           left: serieImageView.leftAnchor,
                           bottom: bottomAnchor,
                           right: serieImageView.rightAnchor,
                           topConstant: 4,
                           bottomConstant: 10)
    }

}
