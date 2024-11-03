//
//  MainPresenter.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//  
//

import UIKit

/// Протокол для основного представления, наследующий от базового протокола представления.
protocol MainViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}

/// Протокол для входящих методов презентера.
protocol MainPresenterInput: AnyObject {
    func onStart()
}

/// Протокол для выходящих методов презентера.
protocol MainPresenterOutput: AnyObject {
    var presenter: MainPresenterInput? { get set }

    func prepareData()
}

/// Презентер для модуля "Main".
final class MainPresenter {

    weak var output: MainPresenterOutput?

    var interactor: MainInteractor?

    // TODO: реализуйте методы взаимодействия с интерактором.
}

// MARK: - MainPresenterInput

extension MainPresenter: MainPresenterInput {
    /// Метод, вызываемый при запуске модуля.
    func onStart() {
        output?.prepareData()
    }
}
