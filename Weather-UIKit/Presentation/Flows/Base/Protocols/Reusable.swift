//
//  Reusable.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 05.11.2024.
//

import UIKit

/// Протокол для объектов, которые могут быть использованы повторно, например, ячейки таблицы или коллекции.
protocol Reusable: AnyObject {

    /// Статическое свойство, которое возвращает строку, представляющую идентификатор для повторного использования.
    static var reuseIdentifier: String { get }
}

extension Reusable {

    /// Значение по умолчанию для `reuseIdentifier`, которое возвращает строку с именем типа.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: Reusable { }
