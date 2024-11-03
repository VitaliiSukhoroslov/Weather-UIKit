//
//  MainAssembly.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//  
//

import UIKit

/// Протокол, который объединяет функционал для основного представления и выхода презентера.
protocol MainAssemblable: MainViewProtocol, MainPresenterOutput { }

/// Перечисление для сборки основных компонентов
enum MainAssembly {

    /// Создает и связывает экземпляры всех компонентов для модуля "Main".
    /// - Parameters:
    ///  - output: Объект, реализующий интерфейс `MainPresenterOutput`, который будет получать данные от презентера.
    ///  - input: Входящий параметр для презентора
    static func assembly(
        with output: MainPresenterOutput,
        input: MainPresenter.Input
    ) {
        let interactor = MainInteractor()
        let presenter = MainPresenter(input)

        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.output = output
        output.presenter = presenter
    }
}
