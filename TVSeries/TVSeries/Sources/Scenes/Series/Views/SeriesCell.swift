//
//  SeriesCell.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import UIKit
import Kingfisher

final class SeriesCell: CodedTableViewCell {
    
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

    private let seriesImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let seriesNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.subtitle.value, weight: .bold)
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()

    private let seriesSummaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .regular)
        label.textColor = .black
        label.numberOfLines = .zero
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup

    override func addSubviews() {
        addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(seriesImageView)
        contentBackgroundView.addSubview(seriesNameLabel)
        contentBackgroundView.addSubview(seriesSummaryLabel)
    }

    override func constrainSubviews() {
        constrainContentBackgroundView()
        constrainSeriesImageView()
        constrainSeriesNameLabel()
        constrainSeriesSummaryLabel()
    }

    private func constrainContentBackgroundView() {
        contentBackgroundView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.xSmall,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }

    private func constrainSeriesImageView() {
        seriesImageView.anchor(
            top: contentBackgroundView.topAnchor,
            leading: contentBackgroundView.leadingAnchor,
            bottom: contentBackgroundView.bottomAnchor,
            widthConstant: ViewMetrics.imageWidth,
            heightConstant: ViewMetrics.imageHeight
        )
    }

    private func constrainSeriesNameLabel() {
        seriesNameLabel.anchor(
            top: seriesImageView.topAnchor,
            leading: seriesImageView.trailingAnchor,
            trailing: contentBackgroundView.trailingAnchor,
            topConstant: Metrics.Spacing.xSmall,
            leadingConstant: Metrics.Spacing.xSmall,
            trailingConstant: Metrics.Spacing.xSmall
        )
    }

    private func constrainSeriesSummaryLabel() {
        seriesSummaryLabel.anchor(
            top: seriesNameLabel.bottomAnchor,
            leading: seriesImageView.trailingAnchor,
            bottom: contentBackgroundView.bottomAnchor,
            trailing: contentBackgroundView.trailingAnchor,
            topConstant: Metrics.Spacing.tiny,
            leadingConstant: Metrics.Spacing.xSmall,
            bottomConstant: Metrics.Spacing.xSmall,
            trailingConstant: Metrics.Spacing.xSmall
        )
    }
    
    // MARK: - Public Methods
    
    func setupViewData(_ viewData: Series.Serie) {
        seriesNameLabel.text = viewData.name
        seriesSummaryLabel.text = viewData.summary.htmlToString
        if let imageURL = viewData.imageURL {
            seriesImageView.kf.indicatorType = .activity
            seriesImageView.kf.setImage(with: imageURL)
        } else {
            seriesImageView.image = .init()
        }
    }
    
    func cancelDownload() {
        seriesImageView.kf.cancelDownloadTask()
    }
}
