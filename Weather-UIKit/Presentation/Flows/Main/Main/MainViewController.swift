//
//  MainViewController.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//  
//

import UIKit

/**
 Основное представление, отображающее прогноз погоды для города.
 */
class MainViewController: ViewController<MainView>, MainAssemblable {

    // MARK: - Properties

    // Блоки для обработки завершения работы и отсутствия доступа к данным
    var onCompletion: CompletionBlock?
    var onNotAccessPersonalData: CompletionResult<(
        input: NoAccessPersonalDataPresenter.Input,
        completion: CompletionBlock?
    )>?

    // Зависимость от презентера
    var presenter: MainPresenterInput?

    // MARK: - LifeCycles
    override func loadView() {
        super.loadView()

        mainView.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onStart()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    deinit {
        print("MainViewController is deinit")
    }
}

// MARK: - MainPresenterOutput

extension MainViewController {

     /// Метод для подготовки данных для отображения на представлении.
     /// - parameter input: Входные данные для представления.
    func prepareData(_ input: MainViewDataSourceInput) {
        mainView.configure(input)
    }
}
