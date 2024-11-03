//
//  ModulesFactory.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import Foundation

/// Фабрика модулей, реализующая протокол `ModulesFactoryProtocol`.
final class ModulesFactory: ModulesFactoryProtocol {}

// MARK: - ModulesFactory Extension

extension ModulesFactory {

    /// Создает и настраивает представление `MainPageView`.
    /// - Parameter input: Входные данные для `MainPagePresenter`, используемого в представлении.
    /// - Returns: Объект, реализующий протокол `MainPageViewProtocol`, настроенный для использования с данным `input`.
    func makeMainPageView(input: MainPagePresenter.Input) -> MainPageViewProtocol {
        let view = MainPageViewController() // Создаем новый экземпляр MainPageViewController.
        MainPageAssembly.assembly(with: view, input: input) // Настраиваем представление с помощью MainPageAssembly.
        return view // Возвращаем настроенное представление.
    }

    /// Создает и настраивает главное представление `MainView`.
    /// - Returns: Объект, реализующий протокол `MainViewProtocol`, настроенный для использования в приложении.
    func makeMainView() -> MainViewProtocol {
        let view = MainViewController() // Создаем новый экземпляр MainViewController.
        MainAssembly.assembly(with: view) // Настраиваем представление с помощью MainAssembly.
        return view // Возвращаем настроенное представление.
    }
}
