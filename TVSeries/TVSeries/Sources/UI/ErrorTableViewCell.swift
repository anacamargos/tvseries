//
//  ErrorTableViewCell.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

final class ErrorTableViewCell: CodedTableViewCell {

    // MARK: - View Components

    private let errorView: ErrorView = ErrorView()

    // MARK: - Override Methods

    override func addSubviews() {
        addSubview(errorView)
    }

    override func constrainSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        errorView.fillSuperview()
    }
}

final class ErrorView: CodedView {

    // MARK: - View Metrics

    private enum ViewMetrics {
        static let errorImageViewSize: CGFloat = 50
    }

    // MARK: - View Components

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .bold)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.text = "Não foi possível continuar a chamada"
        return label
    }()

    private let reloadButton: UIButton = {
        let button = UIButton()
        button.setImage(.reloadArrow, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()

    // MARK: - Override Methods

    override func addSubviews() {
        addSubview(errorLabel)
        addSubview(reloadButton)
    }

    override func constrainSubviews() {
        constrainErrorLabel()
        constrainReloadButton()
    }

    // MARK: - Private Methods

    private func constrainErrorLabel() {
        reloadButton.anchor(
            top: topAnchor,
            topConstant: Metrics.Spacing.xLarge,
            widthConstant: ViewMetrics.errorImageViewSize,
            heightConstant: ViewMetrics.errorImageViewSize
        )
        reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func constrainReloadButton() {
        errorLabel.anchor(
            top: reloadButton.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            bottomConstant: Metrics.Spacing.xLarge,
            trailingConstant: Metrics.Spacing.small
        )
    }
}
