//
//  EpisodeDetailsContentView.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import UIKit

protocol EpisodeDetailsContentViewProtocol: AnyObject {
    func setupEpisodeViewData(_ viewData: EpisodeDetails.ViewData)
}

final class EpisodeDetailsContentView: CodedView {
    
    // MARK: - View Metrics
    
    private enum ViewMetrics {
        static let imageWidth: CGFloat = 200
        static let imageHeight: CGFloat = 200
    }
    
    // MARK: - Layout Components

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

    private let episodeSummaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    
    // MARK: - Initializers

    override init(
        frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods

    override func addSubviews() {
        addSubview(episodeImageView)
        addSubview(episodeNumberLabel)
        addSubview(episodeNameLabel)
        addSubview(episodeSummaryLabel)
    }

    override func constrainSubviews() {
        constrainEpisodeImageView()
        constrainEpisodeNumberLabel()
        constrainEpisodeNameLabel()
        constrainShowSummaryLabel()
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = .white
    }

    func constrainEpisodeImageView() {
        episodeImageView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            widthConstant: ViewMetrics.imageWidth,
            heightConstant: ViewMetrics.imageHeight
        )
    }

    func constrainEpisodeNumberLabel() {
        episodeNumberLabel.anchor(
            top: episodeImageView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }

    func constrainEpisodeNameLabel() {
        episodeNameLabel.anchor(
            top: episodeNumberLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.tiny,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }

    func constrainShowSummaryLabel() {
        episodeSummaryLabel.anchor(
            top: episodeNameLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.xSmall,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
}

// MARK: - EpisodeDetailsContentViewProtocol

extension EpisodeDetailsContentView: EpisodeDetailsContentViewProtocol {
    
    func setupEpisodeViewData(_ viewData: EpisodeDetails.ViewData) {
        episodeNameLabel.text = viewData.name
        episodeNumberLabel.text = viewData.number
        episodeSummaryLabel.text = viewData.summary.htmlToString
        if let imageURL = viewData.imageURL {
            episodeImageView.kf.indicatorType = .activity
            episodeImageView.kf.setImage(with: imageURL)
        } else {
            episodeImageView.image = .init()
        }
    }
}
