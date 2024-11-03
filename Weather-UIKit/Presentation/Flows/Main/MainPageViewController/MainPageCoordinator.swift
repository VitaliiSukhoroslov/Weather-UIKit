//
//  MainAssembly.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Координатор для модуля "MainPage".
final class MainPageCoordinator: BaseCoordinator, MainPageCoordinatorOutput {

    var finishFlow: CompletionBlock?

    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let factory: ModulesFactoryProtocol
    private let router: Routable

    init(
        coordinatorFactory: CoordinatorFactoryProtocol,
        factory: ModulesFactoryProtocol,
        router: Routable
    ) {
        self.coordinatorFactory = coordinatorFactory
        self.factory = factory
        self.router = router
    }
}

// MARK: - Coordinatable

extension MainPageCoordinator: Coordinatable {
    /// Запускает поток навигации.
    func start() {
        performFlow()
    }
}

// MARK: - Приватные методы

private extension MainPageCoordinator {

    /// Выполняет основной поток модулей.
    func performFlow() {
        let view = factory.makeMainPageView(
            input: .init(
                views: [
                    performCurrentFlow(),
                    performCurrentFlow()
                ].compactMap { $0 }
            )
        )

        router.setRootModule(view, hideNavigationBar: false, rootAnimated: true)
    }

    /// Создает текущий модуль для отображения.
    func performCurrentFlow() -> UIViewController? {
        let view = factory.makeMainView()
        return view.toPresent
    }
}
