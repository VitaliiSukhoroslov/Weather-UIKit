//
//  MainPageFactory.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//

import Foundation

/// Фабрика для создания основных экранов страницы
protocol MainPageFactory {
    /// Создает и возвращает представление `MainPageView`
    /// - Parameter input: Входные данные для инициализации `MainPagePresenter`
    /// - Returns: Объект, реализующий `MainPageViewProtocol`
    func makeMainPageView(input: MainPagePresenter.Input) -> MainPageViewProtocol

    /// Создает и возвращает основное представление `MainView`
    /// - Returns: Объект, реализующий `MainViewProtocol`
    func makeMainView() -> MainViewProtocol
}
