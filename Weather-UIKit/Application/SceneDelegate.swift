//
//  SceneDelegate.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var coordinator: Coordinatable = self.makeCoordinator()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        coordinator.start()

        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

private extension SceneDelegate {
    func makeCoordinator() -> AppCoordinatable {
        let navController = BaseNavigationController()

        window?.rootViewController = navController

        return AppCoordinator(
            router: Router(rootController: navController),
            factory: CoordinatorFactory(),
            modulFactory: ModulesFactory()
        )
    }
}

