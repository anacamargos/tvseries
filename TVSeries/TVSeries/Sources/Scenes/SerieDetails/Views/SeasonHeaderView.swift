//
//  SeasonHeaderView.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import UIKit

final class SeasonHeaderView: CodedView {
    
    // MARK: - Properties
    
    private let onTappedExapandViewClosure: (Int) -> Void
    private var viewData: SerieDetails.Season.ViewData?
    
    // MARK: - Constants
    
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
        static let grayAlpha: CGFloat = 0.3
        static let imageWidth: CGFloat = 16
        static let imageHeight: CGFloat = 16
    }
    
    // MARK: - Layout Components

    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = ViewMetrics.cornerRadius
        view.layer.borderWidth = ViewMetrics.borderWidth
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(ViewMetrics.grayAlpha).cgColor
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapContentView)))
        return view
    }()

    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .regular)
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private let episodesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .regular)
        return label
    }()
    
    // MARK: - Initialization

    init(
        onTappedExapandViewClosure: @escaping (Int) -> Void
    ) {
        self.onTappedExapandViewClosure = onTappedExapandViewClosure
        super.init(frame: .zero)
        backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods

    override func addSubviews() {
        addSubview(contentView)
        contentView.addSubview(seasonLabel)
        contentView.addSubview(episodesLabel)
        contentView.addSubview(arrowImageView)
    }

    override func constrainSubviews() {
        constrainContentView()
        constrainSeasonLabel()
        constrainEpisodesLabel()
        constrainArrowImageView()
    }

    private func constrainContentView() {
        contentView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.xSmall,
            leadingConstant: Metrics.Spacing.xSmall,
            bottomConstant: Metrics.Spacing.xSmall,
            trailingConstant: Metrics.Spacing.xSmall
        )
    }

    private func constrainSeasonLabel() {
        seasonLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.xSmall,
            bottomConstant: Metrics.Spacing.small
        )
    }

    private func constrainEpisodesLabel() {
        episodesLabel.anchor(
            trailing: contentView.trailingAnchor,
            trailingConstant: Metrics.Spacing.xSmall
        )
        episodesLabel.centerYAnchor.constraint(equalTo: seasonLabel.centerYAnchor).isActive = true
    }

    private func constrainArrowImageView() {
        arrowImageView.anchor(
            trailing: episodesLabel.leadingAnchor,
            trailingConstant: Metrics.Spacing.small,
            widthConstant: ViewMetrics.imageWidth,
            heightConstant: ViewMetrics.imageHeight
        )
        arrowImageView.centerYAnchor.constraint(equalTo: episodesLabel.centerYAnchor).isActive = true
    }
    
    @objc private func didTapContentView() {
        guard let viewData = viewData else { return }
        onTappedExapandViewClosure(viewData.season)
    }
    
    // MARK: - Public Methods
    
    func setupViewData(_ viewData: SerieDetails.Season.ViewData, isExpanded: Bool) {
        self.viewData = viewData
        seasonLabel.text = L10n.Series.season(viewData.season)
        episodesLabel.text = L10n.Series.episodes(viewData.episodeCount)
        if isExpanded {
            arrowImageView.image = .iconUp
        } else {
            arrowImageView.image = .iconDown
        }
    }
}
