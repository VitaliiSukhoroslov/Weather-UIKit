//
//  Router.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

typealias RouterCompletions = [UIViewController: () -> Void]

/// Класс Router, отвечающий за навигацию между контроллерами.
final class Router: NSObject {

    private weak var rootController: UINavigationController?
    private var completions: RouterCompletions

    /// Инициализирует Router с корневым контроллером.
    /// - Parameter rootController: UINavigationController, который будет использоваться в качестве корневого.
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }

    /// Возвращает контроллер, который может быть представлен.
    var toPresent: UIViewController? {
        rootController
    }
}

private extension Router {
    /// Выполняет замыкание завершения для указанного контроллера.
    /// - Parameter controller: Контроллер, для которого нужно выполнить замыкание завершения.
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK: - Routable
extension Router: Routable {
    /// Презентует модуль (контроллер).
    /// - Parameter module: Модуль (контроллер) для презентации.
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    /// Презентует модуль с указанием анимации.
    /// - Parameters:
    ///   - module: Модуль (контроллер) для презентации.
    ///   - animated: Флаг, указывающий, следует ли анимировать презентацию.
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else {
            return
        }
        rootController?.present(controller, animated: animated, completion: nil)
    }

    /// Презентует модуль с указанием анимации и замыкания завершения.
    /// - Parameters:
    ///   - module: Модуль (контроллер) для презентации.
    ///   - animated: Флаг, указывающий, следует ли анимировать презентацию.
    ///   - completion: Замыкание, которое будет выполнено по завершении.
    func present(_ module: Presentable?, animated: Bool, completion: @escaping (() -> Void)) {
        guard let controller = module?.toPresent else {
            return
        }
        rootController?.present(controller, animated: animated, completion: completion)
    }

    /// Презентует модуль с полным экраном.
    /// - Parameters:
    ///   - module: Модуль (контроллер) для презентации.
    ///   - animated: Флаг, указывающий, следует ли анимировать презентацию.
    func presentOverfullscreen(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else {
            return
        }
        controller.modalPresentationStyle = .overFullScreen
        rootController?.present(controller, animated: animated, completion: nil)
    }

    /// Переходит к модулю.
    /// - Parameter module: Модуль (контроллер) для перехода.
    func push(_ module: Presentable?) {
        push(module, animated: true)
    }

    /// Переходит к модулю с указанием анимации.
    /// - Parameters:
    ///   - module: Модуль (контроллер) для перехода.
    ///   - animated: Флаг, указывающий, следует ли анимировать переход.
    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }

    /// Переходит к модулю с указанием анимации и замыкания завершения.
    /// - Parameters:
    ///   - module: Модуль (контроллер) для перехода.
    ///   - animated: Флаг, указывающий, следует ли анимировать переход.
    ///   - completion: Замыкание, которое будет выполнено по завершении.
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard
            let controller = module?.toPresent,
            !(controller is UINavigationController)
            else { assertionFailure("⚠️ Deprecated push UINavigationController."); return }

        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }

    /// Возвращается на предыдущий модуль.
    func popModule() {
        popModule(animated: true)
    }

    /// Возвращается на предыдущий модуль с указанием анимации.
    /// - Parameter animated: Флаг, указывающий, следует ли анимировать возврат.
    func popModule(animated: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    /// Закрывает текущий модуль.
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    /// Закрывает текущий модуль с указанием анимации и замыкания завершения.
    /// - Parameters:
    ///   - animated: Флаг, указывающий, следует ли анимировать закрытие.
    ///   - completion: Замыкание, которое будет выполнено по завершении.
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    /// Устанавливает модуль как корневой с указанием анимации.
    /// - Parameters:
    ///   - module: Модуль (контроллер) для установки.
    ///   - rootAnimated: Флаг, указывающий, следует ли анимировать установку.
    func setRootModule(_ module: Presentable?, rootAnimated: Bool) {
        setRootModule(module, hideNavigationBar: false, rootAnimated: rootAnimated)
    }

    /// Устанавливает модуль как корневой с указанием скрытия навигационной панели и анимации.
    /// - Parameters:
    ///   - module: Модуль (контроллер) для установки.
    ///   - hideNavigationBar: Флаг, указывающий, следует ли скрыть навигационную панель.
    ///   - rootAnimated: Флаг, указывающий, следует ли анимировать установку.
    func setRootModule(_ module: Presentable?, hideNavigationBar: Bool, rootAnimated: Bool) {
        guard let controller = module?.toPresent else {
            return
        }

        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate

        if rootAnimated,
           let snapshot: UIView = (
            sceneDelegate
                .window?
                .snapshotView(afterScreenUpdates: true)
           ) {
            let desiredViewController = controller
            desiredViewController.view.addSubview(snapshot)

            rootController?.setViewControllers([desiredViewController], animated: false)

            UIView.animate(
                withDuration: 0.3,
                animations: {
                    snapshot.layer.opacity = 0
                }, completion: { _ in
                    snapshot.removeFromSuperview()
                }
            )
        } else {
            rootController?.setViewControllers([controller], animated: false)
        }

        rootController?.isNavigationBarHidden = hideNavigationBar
    }

    /// Возвращается на корневой модуль.
    /// - Parameter animated: Флаг, указывающий, следует ли анимировать возврат.
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
}
