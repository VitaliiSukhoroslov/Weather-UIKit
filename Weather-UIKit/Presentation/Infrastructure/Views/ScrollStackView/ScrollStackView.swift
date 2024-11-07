//
//  ScrollStackView.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 06.11.2024.
//

import UIKit

/// Класс `ScrollStackView` представляет `UIView`, содержащий вертикально или горизонтально прокручиваемую `UIStackView`.
/// Позволяет добавлять элементы в стек и настраивать его ориентацию.
class ScrollStackView: BaseView {

    /// Конфигурирует `stackView` с заданной ориентацией и набором представлений.
    /// - Parameters:
    ///   - scrollOrientation: Ориентация прокрутки для `stackView` (вертикальная или горизонтальная).
    ///   - spacing: Отступы между елементами `stackView`
    ///   - items: Массив представлений `UIView`, которые будут добавлены в `stackView`.
    func configure(
        scrollOrientation: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0,
        with items: [UIView]
    ) {
        stackView.axis = scrollOrientation
        stackView.spacing = spacing
        stackView.removeAllArrangedSubviewsCompletely()
        stackView.addArrangedSubviews(items)
    }

    // MARK: - UI Elements

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()

    private(set) var stackView: UIStackView = {
        let view = UIStackView()
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
        return view
    }()

    // MARK: - Initialization Methods

    override func initUI() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }

    override func initConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
