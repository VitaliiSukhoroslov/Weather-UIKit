//
//  DailysWeatherDataSource.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 07.11.2024.
//

import UIKit

/**
 Данный класс управляет данными для отображения прогноза погоды на несколько дней в таблице.
 Он отвечает за подготовку и обновление данных с использованием дифференциального источника данных (`UITableViewDiffableDataSource`),
 что позволяет эффективно обновлять содержимое таблицы с анимацией изменений.
 */
final class DailysWeatherDataSource {

    private var tableView: UITableView

     /// Инициализатор для создания объекта с таблицей.
     /// - Parameter tableView: Таблица, в которой будет отображаться список дней с прогнозом погоды.
    init(tableView: UITableView) {
        self.tableView = tableView

        registerCell()
    }

     /// Метод для подготовки данных в источнике данных.
     /// - Parameter input: Структура `DailysWeatherDataSourceInput`, которая содержит список данных для ячеек.
    func prepareData(_ input: DailysWeatherDataSourceInput) {
        appendItems(input)
    }

    // MARK: - Cells


     /// Перечисление всех типов ячеек, которые могут быть отображены в таблице.
     /// - `daily`: Тип ячейки для отображения прогноза погоды на один день.
    enum Cells: Hashable {
        case daily(DailyWeatherCellInput)
    }

    // MARK: - Section

     /// Перечисление секций в таблице.
    enum Section {
        case main
    }

    // MARK: - DataSource

    typealias DataSource = UITableViewDiffableDataSource<Section, Cells>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cells>

    // MARK: - Private

    private lazy var dataSource = DataSource(
        tableView: tableView
    ) { [weak self] tableView, indexPath, itemIdentifier in
        guard let self else { return UITableViewCell() }

        switch itemIdentifier {
        case .daily(let input):
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: DailyWeatherCell.self
            )
            cell.configure(with: input)

            return cell
        }
    }

     /// Метод для добавления данных в источника данных с использованием дифференциального снимка.
     /// Этот метод обновляет таблицу с использованием новых данных прогноза погоды.
     /// - Parameter input: Структура `DailysWeatherDataSourceInput`, содержащая список ячеек с данными.
    private func appendItems(_ input: DailysWeatherDataSourceInput) {
        var snapshot = Snapshot()

        snapshot.appendSections([.main])
        snapshot.appendItems(
            input.items.map { .daily($0) },
            toSection: .main
        )

        print(snapshot.numberOfItems)

        dataSource.defaultRowAnimation = .automatic
        dataSource.apply(snapshot, animatingDifferences: true)
    }


}

private extension DailysWeatherDataSource {
    /// Метод для регистрации ячеек в таблице.
    func registerCell() {
        [
            DailyWeatherCell.self
        ].forEach {
            tableView.register(cellClass: $0)
        }
    }
}

// MARK: - Input Model

typealias DailysWeatherDataSourceInput = DailysWeatherDataSource.Input
extension DailysWeatherDataSource {
    /// Структура для передачи данных в источник данных.
    struct Input: Hashable {
        let items: [DailyWeatherCellInput]

         /// Инициализатор для создания структуры с данными для ячеек.
         /// - Parameter items: Массив объектов `DailyWeatherCellInput`, который содержит информацию для каждой ячейки.
        init(items: [DailyWeatherCellInput]) {
            self.items = items
        }
    }
}
