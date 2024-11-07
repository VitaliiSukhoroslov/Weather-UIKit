//
//  NoAccessPersonalDataCoordinator.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 07.11.2024.
//  
//

import UIKit

/// Координатор для управления потоком экрана доступа к персональным данным.
/// Отвечает за создание представления, настройку обработчиков завершения, и управление навигацией.
final class NoAccessPersonalDataCoordinator: BaseCoordinator, NoAccessPersonalDataCoordinatorOutput {

    var finishFlow: CompletionBlock?

    private let factory: ModulesFactory
    private let router: Routable

    /// Инициализатор для создания координатора с фабрикой и маршрутизатором.
    /// - Parameters:
    ///   - factory: Фабрика для создания экранов.
    ///   - router: Маршрутизатор для управления навигацией.
    init(
        with factory: ModulesFactory,
        router: Routable
    ) {
        self.factory = factory
        self.router = router
    }
}

// MARK: - Coordinatable

extension NoAccessPersonalDataCoordinator: Coordinatable {

    /// Запуск потока без входных данных. Переопределяется для соответствия протоколу `Coordinatable`.
    func start() {}

    /// Запуск потока с заданными входными данными.
    /// - Parameter input: Входные данные для настройки экрана.
    func start(_ input: NoAccessPersonalDataPresenter.Input) {
        performFlow(input: input)
    }
}

// MARK: - Private methods

private extension NoAccessPersonalDataCoordinator {

    /// Выполняет настройку и отображение экрана, используя фабрику для создания представления.
    /// - Parameter input: Входные данные для настройки представления.
    func performFlow(input: NoAccessPersonalDataPresenter.Input) {
        let view = factory.makeNoAccessPersonalDataView(input: input)

        view.onCompletion = { [weak self] in
            self?.router.dismissModule()
        }

        view.onCompletionByGesture = finishFlow

        router.presentOverfullscreen(view, animated: true)
    }
}
