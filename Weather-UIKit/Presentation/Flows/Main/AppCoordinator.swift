//
//  AppCoordinator.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//

import UIKit

/// Главный координатор приложения, отвечающий за настройку и управление потоками навигации.
final class AppCoordinator: BaseCoordinator {

    private let factory: CoordinatorFactoryProtocol
    private let modulFactory: ModulesFactoryProtocol
    private let router: Routable

    // Перечисление для определения начального экрана приложения.
    private enum LaunchInstructor {
        case main

        static func setup() -> LaunchInstructor {
            return .main
        }
    }

    // Свойство для хранения текущего инстуктора.
    private var instructor: LaunchInstructor {
        LaunchInstructor.setup()
    }

    // Инициализация координатора с необходимыми зависимостями.
    init(
        router: Routable,
        factory: CoordinatorFactoryProtocol,
        modulFactory: ModulesFactoryProtocol
    ) {
        self.router = router
        self.factory = factory
        self.modulFactory = modulFactory
    }
}

// MARK: - Coordinatable

extension AppCoordinator: AppCoordinatable {
    /// Запускает процесс координации.
    func start() {
        switch instructor {
        case .main:
            performMainCoordinator()
        }
    }
}

// MARK: - Private methods
private extension AppCoordinator {
    /// Настраивает главный координатор и управляет потоком навигации.
    func performMainCoordinator() {
        let coordinator = factory.makeMainPageCoordinator(
            router: router,
            coordinatorFactory: factory
        )

        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self else { return }
            removeDependency(coordinator)
        }

        coordinator.start()
        addDependency(coordinator)
    }
}
