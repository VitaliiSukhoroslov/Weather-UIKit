//
//  BaseTableViewCell.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 05.11.2024.
//

import UIKit

/// Базовый класс ячейки таблицы с предустановками пользовательского интерфейса и удобной настройкой.
/// Предоставляет базовую структуру для инициализации UI-компонентов, добавления ограничений и прослушивателей событий.
class BaseTableViewCell: UITableViewCell {

    /// Инициализатор для создания ячейки программным способом.
    /// Выполняет инициализацию пользовательского интерфейса, добавляет ограничения и прослушиватели событий.
    /// - Parameters:
    ///   - style: Стиль ячейки.
    ///   - reuseIdentifier: Идентификатор для повторного использования ячейки.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
        initConstraints()
        initListeners()
        additionalSetup()
    }

    /// Инициализатор для инициализации ячейки из storyboard или xib.
    /// Генерирует ошибку, так как этот класс предназначен только для создания ячеек программным способом.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Метод для инициализации пользовательского интерфейса. Переопределяется в подклассах.
    func initUI() {
    }

    /// Метод для добавления ограничений интерфейса. Переопределяется в подклассах.
    func initConstraints() {
    }

    /// Метод для добавления прослушивателей событий (обработчиков). Переопределяется в подклассах.
    func initListeners() {
    }

    /// Дополнительные настройки ячейки. Устанавливает прозрачный фон для ячейки и её содержимого.
    func additionalSetup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}
