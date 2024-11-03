//
//  MainAssembly.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Протокол для представления модуля "MainPage".
protocol MainPageViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}

/// Протокол для входных методов презентера модуля "MainPage".
protocol MainPagePresenterInput: AnyObject {
    func onStart()
}

/// Протокол для выходных методов презентера модуля "MainPage".
protocol MainPagePresenterOutput: AnyObject {
    var presenter: MainPagePresenterInput? { get set }

    func prepareData(vcs: [UIViewController])
}

final class MainPagePresenter {

    weak var output: MainPagePresenterOutput?
    private let input: Input

    init(input: Input) {
        self.input = input
    }
}

// MARK: - MainPagePresenterInput

extension MainPagePresenter: MainPagePresenterInput {
    /// Метод, вызываемый при старте модуля.
    func onStart() {
        output?.prepareData(vcs: input.views)
    }
}

extension MainPagePresenter {
    /// Структура для входных данных презентера.
    struct Input {
        let views: [UIViewController]
    }
}
