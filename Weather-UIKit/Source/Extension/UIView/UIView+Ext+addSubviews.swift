//
//  UIView+Ext+addSubviews.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//

import UIKit

/// Расширение для класса UIView с удобным методом для добавления нескольких подвидов.
public extension UIView {

    /// Добавляет несколько подвидов к текущему представлению.
    /// - Parameter views: Массив подвидов, которые необходимо добавить.
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
