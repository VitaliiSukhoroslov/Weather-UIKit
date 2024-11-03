//
//  CoordinatorFactory.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Фабрика координаторов, отвечающая за создание различных координаторов приложения.
final class CoordinatorFactory {
    private let modulesFactory = ModulesFactory()
}

// MARK: - CoordinatorFactoryProtocol

extension CoordinatorFactory: CoordinatorFactoryProtocol {
    /// Метод для создания координатора главной страницы.
    /// - Parameters:
    ///   - router: Объект, реализующий протокол `Routable`, используемый для навигации.
    ///   - coordinatorFactory: Объект, реализующий протокол `CoordinatorFactoryProtocol`, который может создавать другие координаторы.
    /// - Returns: Объект типа `MainPageCoordinator`, который соответствует протоколам `MainPageCoordinator` и `MainPageCoordinatorOutput`.
    func makeMainPageCoordinator(
        router: Routable,
        coordinatorFactory: CoordinatorFactoryProtocol
    ) -> MainPageCoordinator & MainPageCoordinatorOutput {
        MainPageCoordinator(
            coordinatorFactory: coordinatorFactory,
            factory: modulesFactory,
            router: router
        )
    }
}

// MARK: - Private Methods

private extension CoordinatorFactory {

    /// Возвращает объект, реализующий протокол `Routable`, с указанным `UINavigationController` или создает новый экземпляр.
    /// - Parameter navController: Опциональный навигационный контроллер, который будет использоваться для маршрутизации.
    /// - Returns: Объект `Router`, использующий переданный или новый экземпляр `UINavigationController`.
    func router(_ navController: UINavigationController?) -> Routable {
        Router(rootController: navController ?? UINavigationController())
    }
}
