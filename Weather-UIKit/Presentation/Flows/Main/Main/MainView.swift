//
//  MainView.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//  
//

import UIKit
import SnapKit

/// Основное представление для модуля "Main".
final class MainView: BaseView {

    // State
    var presenter: MainPresenterInput?

    /// Конфигурирует представление.
    func configure() {
        // Здесь можно обновить данные в представлении, используя информацию от презентера.
    }

    // UI
    private let testLabel: UILabel = {
        let label = UILabel()
        label.text = "Main Screen"
        label.textColor = .black
        return label
    }()

    /// Инициализация пользовательского интерфейса.
    override func initUI() {
        addSubviews(testLabel)
    }

    /// Установка ограничений для пользовательского интерфейса.
    override func initConstraints() {
        testLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    /// Инициализация слушателей событий.
    override func initListeners() {
        backgroundColor = .red
    }
}
