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
        static let imageWidth: CGFloat = 110
        static let imageHeight: CGFloat = 90
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
        contentBackgroundView.addSubview(episodeImageView)
        contentBackgroundView.addSubview(episodeNumberLabel)
        contentBackgroundView.addSubview(episodeNameLabel)
    }

    override func constrainSubviews() {
        constrainContentBackgroundView()
        constrainEpisodeImageView()
        constrainEpisodeNumberLabel()
        constrainEpisodeNameLabel()
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

    private func constrainEpisodeImageView() {
        episodeImageView.anchor(
            top: contentBackgroundView.topAnchor,
            leading: contentBackgroundView.leadingAnchor,
            bottom: contentBackgroundView.bottomAnchor,
            widthConstant: ViewMetrics.imageWidth,
            heightConstant: ViewMetrics.imageHeight
        )
    }

    private func constrainEpisodeNumberLabel() {
        episodeNumberLabel.anchor(
            leading: episodeImageView.trailingAnchor,
            trailing: contentBackgroundView.trailingAnchor,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.xSmall
        )
        episodeNumberLabel.centerYAnchor.constraint(
            equalTo: episodeImageView.centerYAnchor
        ).isActive = true
    }

    private func constrainEpisodeNameLabel() {
        episodeNameLabel.anchor(
            top: episodeNumberLabel.bottomAnchor,
            leading: episodeImageView.trailingAnchor,
            trailing: contentBackgroundView.trailingAnchor,
            topConstant: Metrics.Spacing.tiny,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.xSmall
        )
    }
    
    // MARK: - Public Methods
    
    func setupViewData(_ viewData: SerieDetails.Episode.ViewData) {
        episodeNameLabel.text = viewData.name
        episodeNumberLabel.text = viewData.number
        if let imageURL = viewData.imageURL {
            episodeImageView.kf.indicatorType = .activity
            episodeImageView.kf.setImage(with: imageURL)
        } else {
            episodeImageView.image = .init()
        }
    }
    
    func cancelDownload() {
        episodeImageView.kf.cancelDownloadTask()
    }
}
