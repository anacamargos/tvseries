//
//  SeriesViewController.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 14/10/21.
//

import UIKit
 
protocol SeriesDisplayLogic {
    
}

final class SeriesViewController: UIViewController {
    
    // MARK: - View Components

    weak var contentView: SeriesContentViewProtocol?
    
    // MARK: - Initializers

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }

    override func loadView() {
        view = SeriesContentView()
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
}

// MARK: - SeriesDisplayLogic

extension SeriesViewController: SeriesDisplayLogic {
    
    
}

extension SeriesViewController: UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
