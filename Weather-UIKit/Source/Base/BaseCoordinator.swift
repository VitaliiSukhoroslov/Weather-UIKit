//
//  BaseCoordinator.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//

import Foundation

/// Базовый класс для координаторов, управляющий зависимостями подкоординаторов.
class BaseCoordinator: NSObject {

    private var childCoordinators = [Coordinatable]()

    /// Добавляет подкоординатор в зависимости.
    /// - Parameter coordinator: Подкоординатор для добавления.
    func addDependency(_ coordinator: Coordinatable) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    /// Удаляет подкоординатор из зависимостей.
    /// - Parameter coordinator: Подкоординатор для удаления.
    func removeDependency(_ coordinator: Coordinatable?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else {
            return
        }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    /// Удаляет все зависимости подкоординаторов.
    func removeAllDependencies() {
        childCoordinators.forEach {
            ($0 as? BaseCoordinator)?.removeAllDependencies()
        }
        childCoordinators.removeAll()
    }
}
