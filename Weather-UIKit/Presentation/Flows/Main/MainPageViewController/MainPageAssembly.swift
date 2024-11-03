//
//  MainAssembly.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Протокол для сборки модуля "MainPage".
protocol MainPageAssemblable: MainPageViewProtocol, MainPagePresenterOutput {}

/// Структура для сборки модуля "MainPage".
enum MainPageAssembly {

    /// Метод для создания и связывания компонентов модуля.
    /// - Parameters:
    ///   - output: Объект, реализующий протокол MainPagePresenterOutput для получения данных от презентера.
    ///   - input: Входные данные для презентера.
    static func assembly(
        with output: MainPagePresenterOutput,
        input: MainPagePresenter.Input
    ) {
        let presenter = MainPagePresenter(input: input)

        presenter.output = output
        output.presenter = presenter
    }
}
