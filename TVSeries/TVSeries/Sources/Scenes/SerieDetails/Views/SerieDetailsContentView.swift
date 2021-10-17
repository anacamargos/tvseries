//
//  SerieDetailsContentView.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

protocol SerieDetailsContentViewProtocol: AnyObject {
    func setupSerieDetailsViewData(_ viewData: SerieDetails.Serie)
    func setupEpisodesViewState(_ viewState: SerieDetails.ViewState)
}

final class SerieDetailsContentView: CodedView {
    
    // MARK: - Dependencies
    
    private let onTappedEpisodeCellClosure: (Int) -> Void
    
    // MARK: - Properties
    
    private var episodesViewState: SerieDetails.ViewState = .loading
    private var hiddenSections = Set<Int>()
    
    // MARK: - View Components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: .zero, left: .zero, bottom: Metrics.Spacing.small, right: .zero)
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.className)
        tableView.register(CustomLoadingTableViewCell.self, forCellReuseIdentifier: CustomLoadingTableViewCell.className)
        tableView.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.className)
        return tableView
    }()
    
    // MARK: - Initializers

    init(
        frame: CGRect = .zero,
        onTappedEpisodeCellClosure: @escaping (Int) -> Void
    ) {
        self.onTappedEpisodeCellClosure = onTappedEpisodeCellClosure
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
    
    private func onTappedExapandableView(season: Int) {
        if hiddenSections.contains(season) {
            hiddenSections.remove(season)
        } else {
            hiddenSections.insert(season)
        }
        tableView.reloadData()
    }
    
    private func getLoadingCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomLoadingTableViewCell = tableView.reusableCell(for: CustomLoadingTableViewCell.className, for: indexPath)
        cell.startLoading()
        return cell
    }

    private func getErrorCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell: ErrorTableViewCell = tableView.reusableCell(for: ErrorTableViewCell.className, for: indexPath)
        return cell
    }
    
    private func getEpisodeCell(for indexPath: IndexPath, viewData: [Int: [SerieDetails.Episode.ViewData]]) -> UITableViewCell {
        let season = indexPath.section + 1
        guard let currentEpisode = viewData[season]?[indexPath.row] else { return .init() }
        let cell: EpisodeCell = tableView.reusableCell(for: EpisodeCell.className, for: indexPath)
        cell.setupViewData(currentEpisode)
        return cell
    }
}

// MARK: - SerieDetailsContentViewProtocol

extension SerieDetailsContentView: SerieDetailsContentViewProtocol {
    
    func setupSerieDetailsViewData(_ viewData: SerieDetails.Serie) {
        let headerView = SerieDetailsHeaderView()
        headerView.setupViewData(viewData)
        tableView.tableHeaderView = headerView
        tableView.layoutTableHeaderView(animated: true)
    }
    
    func setupEpisodesViewState(_ viewState: SerieDetails.ViewState) {
        self.episodesViewState = viewState
        if case let .content(viewData) = viewState {
            viewData.keys.forEach { hiddenSections.insert($0) }
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension SerieDetailsContentView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch episodesViewState {
        case .loading, .error:
            return 1
        case let .content(viewData):
            return viewData.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch episodesViewState {
        case .loading, .error:
            return 1
        case let .content(viewData):
            let season = section + 1
            if let episodes = viewData[season], !hiddenSections.contains(season) {
                return episodes.count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch episodesViewState {
        case let .content(viewData):
            return getEpisodeCell(for: indexPath, viewData: viewData)
        case .loading:
            return getLoadingCell(for: indexPath)
        case .error:
            return getErrorCell(for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? EpisodeCell
        cell?.cancelDownload()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if case let .content(viewData) = episodesViewState {
            guard let episodesSeasons = viewData[section + 1] else { return nil }
            let season = section + 1
            let viewData = SerieDetails.Season.ViewData(season: season, episodeCount: episodesSeasons.count)
            let headerView = SeasonHeaderView(onTappedExapandViewClosure: onTappedExapandableView(season:))
            headerView.setupViewData(viewData, isExpanded: !hiddenSections.contains(season))
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = indexPath.section + 1
        if case let .content(viewData) = episodesViewState,
            let currentEpisode = viewData[season]?[indexPath.row] {
            onTappedEpisodeCellClosure(currentEpisode.id)
        }
    }
}
