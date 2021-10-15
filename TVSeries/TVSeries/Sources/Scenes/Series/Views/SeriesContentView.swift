//
//  SeriesContentView.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import UIKit

protocol SeriesContentViewProtocol: AnyObject {
    func setupSeriesViewState(_ viewState: Series.ViewState)
}

final class SeriesContentView: CodedView {
    
    // MARK: - Dependencies
    
    private let onWillDisplayNewCells: (Int) -> Void
    
    // MARK: - Properties
    
    private var viewState: Series.ViewState = .loading
    
    // MARK: - View Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: .zero, left: .zero, bottom: Metrics.Spacing.small, right: .zero)
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SeriesCell.self, forCellReuseIdentifier: SeriesCell.className)
        tableView.register(CustomLoadingTableViewCell.self, forCellReuseIdentifier: CustomLoadingTableViewCell.className)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.className)
        tableView.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.className)
        return tableView
    }()
    
    // MARK: - Initializers

    init(
        frame: CGRect = .zero,
        onWillDisplayNewCells: @escaping (Int) -> Void
    ) {
        self.onWillDisplayNewCells = onWillDisplayNewCells
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
    
    private func getSerieCell(for indexPath: IndexPath, with viewData: Series.Serie) -> UITableViewCell {
        let cell: SeriesCell = tableView.reusableCell(for: SeriesCell.className, for: indexPath)
        cell.setupViewData(viewData)
        return cell
    }
    
    private func getLoadingCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomLoadingTableViewCell = tableView.reusableCell(for: CustomLoadingTableViewCell.className, for: indexPath)
        cell.startLoading()
        return cell
    }

    private func getEmptyCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell: EmptyTableViewCell = tableView.reusableCell(for: EmptyTableViewCell.className, for: indexPath)
        cell.setupLabelText("Vazio...")
        return cell
    }

    private func getErrorCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell: ErrorTableViewCell = tableView.reusableCell(for: ErrorTableViewCell.className, for: indexPath)
        return cell
    }
}

// MARK: - SeriesContentViewProtocol

extension SeriesContentView: SeriesContentViewProtocol {
    
    func setupSeriesViewState(_ viewState: Series.ViewState) {
        self.viewState = viewState
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension SeriesContentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewState {
        case .loading, .error, .empty:
            return 1
        case let .content(viewData):
            return viewData.series.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewState {
        case let .content(viewData):
            let currentSerie = viewData.series[indexPath.row]
            return getSerieCell(for: indexPath, with: currentSerie)
        case .loading:
            return getLoadingCell(for: indexPath)
        case .empty:
            return getEmptyCell(for: indexPath)
        case .error:
            return getErrorCell(for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? SeriesCell
        cell?.cancelDownload()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        onWillDisplayNewCells(indexPath.row)
    }
}
