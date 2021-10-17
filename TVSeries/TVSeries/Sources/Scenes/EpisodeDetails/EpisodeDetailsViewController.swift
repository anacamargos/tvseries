//
//  EpisodeDetailsViewController.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 17/10/21.
//

import Foundation
import UIKit

protocol EpisodeDetailsDisplayLogic: AnyObject {
    func displayEpisodeViewData(_ viewData: EpisodeDetails.ViewData)
}

final class EpisodeDetailsViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let interactor: EpisodeDetailsBusinessLogic
    
    // MARK: - View Components

    weak var contentView: EpisodeDetailsContentViewProtocol?
    
    // MARK: - Initializers

    init(
        interactor: EpisodeDetailsBusinessLogic
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
        view = EpisodeDetailsContentView()
        contentView = view as? EpisodeDetailsContentViewProtocol
    }
    
    // MARK: - Private Methods

    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - EpisodeDetailsDisplayLogic

extension EpisodeDetailsViewController: EpisodeDetailsDisplayLogic {
    
    func displayEpisodeViewData(_ viewData: EpisodeDetails.ViewData) {
        title = viewData.name
        contentView?.setupEpisodeViewData(viewData)
    }
}
