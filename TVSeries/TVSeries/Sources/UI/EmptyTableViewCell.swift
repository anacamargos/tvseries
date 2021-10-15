//
//  EmptyTableViewCell.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

final class EmptyTableViewCell: CodedTableViewCell {

    // MARK: - View Components

    private let emptyView: EmptyView = EmptyView()

    // MARK: - Override Methods

    override func addSubviews() {
        addSubview(emptyView)
    }

    override func constrainSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        emptyView.fillSuperview()
    }

    // MARK: - Public Methods

    func setupLabelText(_ text: String) {
        emptyView.setupLabelText(text)
    }
}

final class EmptyView: CodedView {
    
    // MARK: - View Components

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Metrics.FontSize.body.value, weight: .bold)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.text = "Não achamos nenhuma série"
        return label
    }()

    // MARK: - Override Methods

    override func addSubviews() {
        addSubview(emptyLabel)
    }

    override func constrainSubviews() {
        emptyLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.xLarge,
            leadingConstant: Metrics.Spacing.small,
            bottomConstant: Metrics.Spacing.xLarge,
            trailingConstant: Metrics.Spacing.small
        )
    }

    // MARK: - Public Methods

    func setupLabelText(_ text: String) {
        emptyLabel.text = text
    }
}
