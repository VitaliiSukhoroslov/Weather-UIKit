//
//  NoAccessPersonalDataAssembly.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 07.11.2024.
//  
//

import UIKit

/// Протокол, объединяющий требования для работы с представлением и выходными данными презентера
/// в модуле доступа к персональным данным.
protocol NoAccessPersonalDataAssemblable: NoAccessPersonalDataViewProtocol, NoAccessPersonalDataPresenterOutput {}

/// Сборщик для модуля доступа к персональным данным.
/// Создает и связывает компоненты `interactor`, `presenter`, и `output` для согласованной работы модуля.
enum NoAccessPersonalDataAssembly {

    /// Функция для инициализации и связи компонентов модуля.
    /// - Parameters:
    ///   - output: Выходной интерфейс для связи презентера с представлением.
    ///   - input: Входные данные для настройки презентера.
    static func assembly(
        with output: NoAccessPersonalDataPresenterOutput,
        input: NoAccessPersonalDataPresenter.Input
    ) {
        let interactor = NoAccessPersonalDataInteractor()
        let presenter = NoAccessPersonalDataPresenter(input: input)

        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.output = output
        output.presenter = presenter
    }
}
