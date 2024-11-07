//
//  TableView+Ext.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 05.11.2024.
//

import UIKit

extension UITableView {

    /// Регистрирует ячейку `UITableViewCell` для повторного использования в таблице.
    /// - Parameter name: Класс ячейки, который необходимо зарегистрировать.
    func register<T: UITableViewCell>(cellClass name: T.Type) {
        register(name, forCellReuseIdentifier: String(describing: name))
    }

    /// Извлекает переиспользуемую ячейку `UITableViewCell` определённого типа.
    /// - Parameters:
    ///   - indexPath: Индекс пути для извлекаемой ячейки.
    ///   - cellType: Класс ячейки, который нужно извлечь. По умолчанию совпадает с типом `T`.
    /// - Returns: Ячейка, приведённая к указанному типу `T`.
    /// - Throws: Вызовет `fatalError`, если не удастся извлечь ячейку с правильным идентификатором или типом.
    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).")
        }
        return cell
    }
}
