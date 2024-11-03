//
//  Presentable.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Протокол `Presentable` определяет интерфейс для объектов, которые могут быть представлены как `UIViewController`.
///
/// Этот протокол предназначен для унификации представления контроллеров в приложении и упрощает
/// процесс навигации, предоставляя единый способ получения контроллера, который можно представить.
protocol Presentable {
    /// Возвращает контроллер, который можно представить.
    var toPresent: UIViewController? { get }
}

/// Расширение для `UIViewController`, которое реализует протокол `Presentable`.
extension UIViewController: Presentable {
    /// Возвращает сам экземпляр `UIViewController`, который может быть представлен.
    var toPresent: UIViewController? {
        self
    }
}
