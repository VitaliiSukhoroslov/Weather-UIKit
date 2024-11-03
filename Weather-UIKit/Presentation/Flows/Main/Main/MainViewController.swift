//
//  MainViewController.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//  
//

import UIKit

/**
 Main прогноз погоды для города
 */
class MainViewController: ViewController<MainView>, MainAssemblable {

    // Navigation
    var onCompletion: CompletionBlock?

    // Dependency
    var presenter: MainPresenterInput?

    // MARK: - Жизненные циклы
    override func loadView() {
        super.loadView()

        mainView.presenter = presenter
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)

        presenter?.onStart()
    }

    deinit {
        print("MainViewController is deinit")
    }

    // MARK: - Приватные методы
}

// MARK: - MainPresenterOutput

extension MainViewController {
    /// Метод для подготовки данных в представлении.
    func prepareData() {
        mainView.configure()
    }
}
