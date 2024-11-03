//
//  BaseNavigationController.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Основной класс навигационного контроллера, который настраивает навигационный бар.
class BaseNavigationController: UINavigationController {

    /// Вызывается при загрузке представления контроллера.
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.isTranslucent = false
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = nil

        self.interactivePopGestureRecognizer?.isEnabled = self.responds(
            to: #selector(getter: interactivePopGestureRecognizer)
        ) && self.viewControllers.count > 1

        performAdditionalSetup()
    }

    /// Выполняет дополнительную настройку внешнего вида навигационного бара.
    private func performAdditionalSetup() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance

        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black

        setNeedsStatusBarAppearanceUpdate()
    }
}

// Расширение для реализации делегатов UINavigationController и UIGestureRecognizer.
extension BaseNavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    /// Вызывается при показе нового контроллера.
    /// - Parameters:
    ///   - navigationController: Контроллер навигации.
    ///   - viewController: Новый контроллер представления.
    ///   - animated: Указывает, анимирован ли переход.
    func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {

        self.interactivePopGestureRecognizer?.isEnabled = self.responds(
            to: #selector(getter: interactivePopGestureRecognizer)
        ) && self.viewControllers.count > 1
    }
}
