//
//  BasePresenter.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

/// Протокол, который должен реализовывать объект, отвечающий за вывод информации для презентера.
protocol BasePresenterOutput: AnyObject {

    /// Метод для управления состоянием анимации.
    /// - Parameter isStart: Булевый флаг, который указывает, началась ли анимация (если `true`), или она должна быть завершена (если `false`).
    func onAnimating(isStart: Bool)
}
