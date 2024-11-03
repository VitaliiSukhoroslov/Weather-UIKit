//
//  BaseView.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// `BaseView` — это базовый класс для пользовательских представлений, который упрощает процесс создания и настройки пользовательского интерфейса.
/// Этот класс устанавливает общие методы для инициализации UI, установки ограничений и добавления слушателей.
class BaseView: UIView {

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Инициализация UI, ограничений и слушателей
        initUI()
        initConstraints()
        initListeners()
    }

    // Обозначаем, что инициализация из интерфейсного файла недоступна
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // Вызывается, когда вид загружается из NIB
    override func awakeFromNib() {
        super.awakeFromNib()

        // Инициализация UI, ограничений и слушателей
        initUI()
        initConstraints()
        initListeners()
    }

    // MARK: - Setup Methods

    /// Настройка пользовательского интерфейса.
    /// Этот метод можно переопределить в подклассах для настройки элементов UI.
    func initUI() {
    }

    /// Настройка ограничений для подвидов.
    /// Этот метод можно переопределить в подклассах для установки ограничений.
    func initConstraints() {
    }

    /// Добавление слушателей для обработки событий или уведомлений.
    /// Этот метод можно переопределить в подклассах для добавления слушателей.
    func initListeners() {
    }
}
