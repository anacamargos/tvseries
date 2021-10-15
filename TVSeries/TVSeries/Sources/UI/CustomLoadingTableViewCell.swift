//
//  CustomLoadingTableViewCell.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

final class CustomLoadingTableViewCell: CodedTableViewCell {

    // MARK: - View Components

    private let loadingView: CustomLoadingView = CustomLoadingView()

    // MARK: - Override Methods

    override func addSubviews() {
        addSubview(loadingView)
    }

    override func constrainSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        loadingView.fillSuperview()
    }

    // MARK: - Public Methods

    func startLoading() {
        loadingView.startLoading()
    }
}

final class CustomLoadingView: CodedView {

    // MARK: - View Components

    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        return view
    }()

    deinit {
        activityIndicator.stopAnimating()
    }

    // MARK: - Override Methods

    override func addSubviews() {
        addSubview(activityIndicator)
    }

    override func constrainSubviews() {
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            topConstant: Metrics.Spacing.xSmall,
            bottomConstant: Metrics.Spacing.xSmall
        )
    }

    // MARK: - Public Methods

    func startLoading() {
        activityIndicator.startAnimating()
    }
}
