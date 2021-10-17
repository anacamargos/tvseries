//
//  SerieDetailsViewController.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

protocol SerieDetailsDisplayLogic: AnyObject {
    func displaySerieDetailsViewData(_ viewData: SerieDetails.Serie)
    func displayEpisodesViewState(_ viewState: SerieDetails.ViewState)
}

final class SerieDetailsViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let interactor: SerieDetailsBusinessLogic
    
    // MARK: - View Components

    weak var contentView: SerieDetailsContentViewProtocol?
    
    // MARK: - Initializers

    init(
        interactor: SerieDetailsBusinessLogic
    ) {
        self.interactor = interactor
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
        view = SerieDetailsContentView()
        contentView = view as? SerieDetailsContentViewProtocol
    }
    
    // MARK: - Private Methods

    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - SerieDetailsDisplayLogic

extension SerieDetailsViewController: SerieDetailsDisplayLogic {
    
    func displaySerieDetailsViewData(_ viewData: SerieDetails.Serie) {
        title = viewData.name
        contentView?.setupSerieDetailsViewData(viewData)
    }
    
    func displayEpisodesViewState(_ viewState: SerieDetails.ViewState) {
        contentView?.setupEpisodesViewState(viewState)
    }
}
