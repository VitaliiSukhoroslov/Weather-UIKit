//
//  DailysWeatherCell.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 07.11.2024.
//

import UIKit

/**
 Ячейка таблицы для отображения прогноза погоды на несколько дней.
 Эта ячейка включает в себя заголовок и таблицу, в которой отображаются прогнозы погоды на разные дни.
 */
final class DailysWeatherCell: BaseTableViewCell {

    private lazy var dataSource = DailysWeatherDataSource(tableView: tableView)
    private let rowHeight: CGFloat = 44
    private var input: Input?

    /// Метод для настройки ячейки с передачей входных данных.
    /// - Parameter input: Входные данные, которые содержат источник данных для таблицы.
    func configure(with input: Input) {
        self.input = input

        headerLabel.text = "Forecast for days".localized.replacingOccurrences(
            of: "%s", with: "\(input.dataSource.items.count)"
        )

        dataSource.prepareData(input.dataSource)

        layoutIfNeeded()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()

        tableView.snp.updateConstraints {
            $0.height.equalTo((input?.dataSource.items.count ?? 0) * Int(rowHeight))
        }
    }

    // MARK: - UI
    private let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white.withAlphaComponent(0.5)
        return label
    }()

    private let separatorLine = SeparatorLineView()

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .none
        view.rowHeight = rowHeight
        view.backgroundColor = .clear
        view.isScrollEnabled = false
        return view
    }()

    override func initUI() {
        contentView.addSubview(mainView)
        mainView.addSubviews(headerLabel, separatorLine, tableView)
    }

    override func initListeners() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(separatorLine.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-5)
            $0.height.equalTo(0)
        }
    }
}

// MARK: - Input Model

typealias DailysWeatherCellInput = DailysWeatherCell.Input
extension DailysWeatherCell {
    /// Структура для передачи входных данных в ячейку.
    /// Включает в себя источник данных для отображения прогноза погоды на несколько дней.
    struct Input: Hashable {
        let dataSource: DailysWeatherDataSourceInput

        /// Инициализатор для создания структуры с входными данными.
        /// - Parameter dataSource: Источник данных, содержащий информацию для таблицы.
        init(dataSource: DailysWeatherDataSourceInput) {
            self.dataSource = dataSource
        }
    }
}
