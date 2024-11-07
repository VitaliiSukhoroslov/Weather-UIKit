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
    private lazy var dataSource = MainViewDataSource(tableView: tableView)

    /// Конфигурирует представление.
    func configure(_ input: MainViewDataSourceInput) {
        dataSource.prepareData(input)
    }

    // UI
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.backgroundColor = .clear
        view.contentInset = .init(top: 40, left: 0, bottom: 0, right: 0)
        return view
    }()

    /// Инициализация пользовательского интерфейса.
    override func initUI() {
        addSubviews(tableView)
    }

    /// Установка ограничений для пользовательского интерфейса.
    override func initConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    /// Инициализация слушателей событий.
    override func initListeners() {
        backgroundColor = .clear
    }
}
