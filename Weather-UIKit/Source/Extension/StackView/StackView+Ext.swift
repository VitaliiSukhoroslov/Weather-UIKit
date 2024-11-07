//
//  StackView+Ext.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 06.11.2024.
//

import UIKit

public extension UIStackView {

    /// Удаляет указанный `UIView` из массива `arrangedSubviews` и также полностью удаляет его из иерархии представлений.
    /// - Parameter subview: Представление `UIView`, которое нужно полностью удалить из `UIStackView`.
    private func removeArrangedSubviewCompletely(_ subview: UIView) {
        removeArrangedSubview(subview)
        subview.removeFromSuperview()
    }

    /// Удаляет все представления из массива `arrangedSubviews` и полностью удаляет их из иерархии представлений.
    /// Используется, когда нужно удалить все дочерние представления `UIStackView`, включая те, которые находятся в `arrangedSubviews`.
    func removeAllArrangedSubviewsCompletely() {
        for subview in arrangedSubviews.reversed() {
            removeArrangedSubviewCompletely(subview)
        }
    }
}

public extension UIStackView {

    /// Добавляет массив `UIView` в качестве дочерних элементов UIStackView.
    /// - Parameter subviews: Массив представлений `UIView`, которые нужно добавить в `arrangedSubviews`.
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            addArrangedSubview($0)
        }
    }
}
