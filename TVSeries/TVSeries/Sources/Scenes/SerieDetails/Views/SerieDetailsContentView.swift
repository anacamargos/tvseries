//
//  SerieDetailsContentView.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

protocol SerieDetailsContentViewProtocol: AnyObject {}

final class SerieDetailsContentView: CodedView {
    
    // MARK: - View Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: .zero, left: .zero, bottom: Metrics.Spacing.small, right: .zero)
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
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
        addSubview(tableView)
    }

    override func constrainSubviews() {
        constrainTableView()
    }

    // MARK: - Private Methods
    
    private func constrainTableView() {
        tableView.fillSuperview()
    }
    
    private func configureView() {
        backgroundColor = .white
    }
}

// MARK: - SerieDetailsContentViewProtocol

extension SerieDetailsContentView: SerieDetailsContentViewProtocol {
    
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension SerieDetailsContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return .init()
    }
}
