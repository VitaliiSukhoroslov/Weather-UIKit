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
                    performCurrentFlow(.init())
                ].compactMap { $0 }
            )
        )

        router.setRootModule(view, hideNavigationBar: false, rootAnimated: true)
    }

    /// Создает модул `NoAccessPersonalData` для отображения.
    /// - Parameter input: Входящий параметр для `MainPresenter`
    func performCurrentFlow(_ input: MainPresenter.Input) -> UIViewController? {
        let view = factory.makeMainView(input)

        view.onNotAccessPersonalData = { [weak self] in
            self?.performNoAccessPersonalDataCoordinator($0.input, $0.completion)
        }
        return view.toPresent
    }

    /// Создает текущий модуль для отображения.
    /// - Parameters:
    ///  - input: Входящий параметр для `NoAccessPersonalDataCoordinator`
    ///  - completion: Обратная связь после закрытия экрана
    func performNoAccessPersonalDataCoordinator(
        _ input: NoAccessPersonalDataPresenter.Input,
        _ completion: CompletionBlock?
    ) {
        let coordinator = coordinatorFactory.makeNoAccessPersonalDataCoordinator(
            router: router
        )

        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self else { return }

            removeDependency(coordinator)
            completion?()
        }

        coordinator.start(input)
        addDependency(coordinator)
    }
}
