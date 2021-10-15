//
//  SerieDetailsViewController.swift
//  TVSeries
//
//  Created by Ana Leticia Camargos on 15/10/21.
//

import UIKit

protocol SerieDetailsDisplayLogic: AnyObject {
    
}

final class SerieDetailsViewController: UIViewController {
    
    // MARK: - View Components

    weak var contentView: SerieDetailsContentViewProtocol?
    
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
        view = SerieDetailsContentView()
        contentView = view as? SerieDetailsContentViewProtocol
    }
    
    // MARK: - Private Methods

    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = L10n.Series.title
    }
}

// MARK: - SerieDetailsDisplayLogic

extension SerieDetailsViewController: SerieDetailsDisplayLogic {}
