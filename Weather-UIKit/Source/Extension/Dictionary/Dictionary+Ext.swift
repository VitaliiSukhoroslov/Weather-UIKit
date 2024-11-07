//
//  Dictionary+Ext.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//

import Foundation

extension Dictionary where Key == String, Value == Any? {

    /// Возвращает новый словарь, в котором удалены все элементы с `nil` значениями.
    /// - Returns: Новый словарь `[String: Any]`, не содержащий `nil` значений.
    func removeNilValues() -> [String: Any] {
        self.filter { $0.value != nil }.mapValues { $0! }
    }

    /// Возвращает новый словарь, в котором удалены элементы с `nil` значениями и пустые строки.
    /// - Returns: Новый словарь `[String: Any]`, не содержащий `nil` значений и пустых строк.
    func removeNilAndEmptyValues() -> [String: Any] {
        filter {
            if let value = $0.value as? String {
                return !value.isEmpty
            } else {
                return $0.value != nil
            }
        }
        .compactMapValues { $0 }
    }
}
