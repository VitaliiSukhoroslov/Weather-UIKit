//
//  SeparatorLineView.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 07.11.2024.
//

import UIKit

/**
 Представление для разделительной линии.
 Это представление отображает разделительную линию с полупрозрачным фоном.
 */
final class SeparatorLineView: BaseView {

    /// Метод для инициализации слушателей.
    override func initListeners() {
        backgroundColor = .white.withAlphaComponent(0.2)
    }
}
