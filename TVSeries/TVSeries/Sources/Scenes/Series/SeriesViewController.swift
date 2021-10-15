//
//  SeriesViewController.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import UIKit
 
protocol SeriesDisplayLogic: AnyObject {
    func displaySeriesViewState(_ viewState: Series.ViewState)
}

final class SeriesViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let interactor: SeriesBusinessLogic
    private let mainDispatchQueue: DispatchQueueType
    
    // MARK: - View Components

    weak var contentView: SeriesContentViewProtocol?
    
    // MARK: - Initializers

    init(
        interactor: SeriesBusinessLogic,
        mainDispatchQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.interactor = interactor
        self.mainDispatchQueue = mainDispatchQueue
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.onViewDidLoad()
        configureNavigationBar()
    }

    override func loadView() {
        view = SeriesContentView(onWillDisplayNewCells: { [weak self] row in self?.onWillDisplayNewCells(lasDisplayedRow: row) } )
        contentView = view as? SeriesContentViewProtocol
    }
    
    // MARK: - Private Methods

    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = "Series"
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
    }
    
    private func onWillDisplayNewCells(lasDisplayedRow: Int) {
        interactor.checkPagination(lastDisplayedRow: lasDisplayedRow)
    }
}

// MARK: - SeriesDisplayLogic

extension SeriesViewController: SeriesDisplayLogic {
    
    func displaySeriesViewState(_ viewState: Series.ViewState) {
        mainDispatchQueue.async {
            self.contentView?.setupSeriesViewState(viewState)
        }
    }
}

extension SeriesViewController: UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

protocol DispatchQueueType {
    func async(execute work: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
