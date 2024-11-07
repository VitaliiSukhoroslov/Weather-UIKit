//
//  CoordinatorFactoryProtocol.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Протокол для создания координаторов в приложении
protocol CoordinatorFactoryProtocol {
    /// Создает и возвращает координатор для `MainPageViewController`
    /// - Parameters:
    ///   - router: Объект для навигации, отвечающий за маршрутизацию.
    ///   - coordinatorFactory: Фабрика координаторов для создания вложенных координаторов.
    /// - Returns: Возвращает экземпляр `MainPageCoordinator`, который также поддерживает `MainPageCoordinatorOutput`.
    func makeMainPageCoordinator(
        router: Routable,
        coordinatorFactory: CoordinatorFactoryProtocol
    ) -> MainPageCoordinator & MainPageCoordinatorOutput

    /// Создает и возвращает координатор для `NoAccessPersonalDataViewController`
    /// - Parameters:
    ///   - router: Объект для навигации, отвечающий за маршрутизацию.
    ///   - coordinatorFactory: Фабрика координаторов для создания вложенных координаторов.
    /// - Returns: Возвращает экземпляр `NoAccessPersonalDataCoordinator`, который также поддерживает `NoAccessPersonalDataCoordinatorOutput`.
    func makeNoAccessPersonalDataCoordinator(
        router: Routable
    ) -> NoAccessPersonalDataCoordinator & NoAccessPersonalDataCoordinatorOutput
}
