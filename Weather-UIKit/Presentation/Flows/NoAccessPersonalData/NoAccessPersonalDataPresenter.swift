//
//  NoAccessPersonalDataPresenter.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 07.11.2024.
//  
//

import UIKit

/// Протокол для представления (View) экрана "доступа к персональным данным".
protocol NoAccessPersonalDataViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}

/// Протокол для ввода в презентер (Presenter) экрана "Нет доступа к персональным данным".
protocol NoAccessPersonalDataPresenterInput: AnyObject {
    func onStart()
    func onSettingsApp()
}

/// Протокол для вывода из презентера (Presenter) экрана "доступа к персональным данным".
protocol NoAccessPersonalDataPresenterOutput: AnyObject {
    var presenter: NoAccessPersonalDataPresenterInput? { get set }
    func prepareData(_ input: NoAccessPersonalDataViewInput)
}

/// Презентер для экрана "доступа к персональным данным".
final class NoAccessPersonalDataPresenter {

    weak var output: NoAccessPersonalDataPresenterOutput?
    var interactor: NoAccessPersonalDataInteractor?

    private let input: Input

    /// Инициализатор презентера.
    /// - Parameter input: Входные данные для конфигурации презентера.
    init(input: Input) {
        self.input = input
    }

    // TODO: implement interactor methods
}

// MARK: - NoAccessPersonalDataPresenterInput

extension NoAccessPersonalDataPresenter: NoAccessPersonalDataPresenterInput {
    /// Метод, который вызывается при старте экрана. В зависимости от типа доступа, подготавливаются данные для отображения.
    func onStart() {
        switch input.typeAccessData {
        case .geoData:
            output?.prepareData(
                .init(
                    title: "Setup Access".localized,
                    subtitle: "Your location unavailable enable access geolocation your settings".localized
                )
            )
        }
    }

    /// Метод для открытия настроек приложения.
    func onSettingsApp() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension NoAccessPersonalDataPresenter {
    /// Типы данных, к которым может быть ограничен доступ.
    enum TypeAccessData {
        case geoData
    }

    /// Структура, представляющая входные данные для конфигурации презентера.
    struct Input {
        let typeAccessData: TypeAccessData
    }
}
