//
//  MainViewDataSource.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 05.11.2024.
//

import UIKit

final class MainViewDataSource {

    private var tableView: UITableView

    /// Инициализатор.
    /// - Parameter tableView: Таблица, с которой будет работать источник данных.
    init(
        tableView: UITableView
    ) {
        self.tableView = tableView

        registerCell()
    }

    /// Подготавливает данные для отображения в таблице.
    /// - Parameter input: Входные данные, которые будут отображаться в таблице.
    func prepareData(_ input: MainViewDataSource.Input) {
        appendItems(input)
    }

    // Типы ячеек для таблицы.
    enum MainViewDataSourceeCellType: Hashable {
        case commonWeaterCell(GeneralWeatherCellInput)
        case hourlyWeaterCell(HourlyWeatherCellInput)
        case dailysWeaterCell(DailysWeatherCellInput)
    }

    // Разделы таблицы.
    enum Section {
        case general
        case hourly
        case daily
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, MainViewDataSourceeCellType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MainViewDataSourceeCellType>

    private lazy var dataSource = DataSource(
        tableView: tableView
    ) { [weak self] tableView, indexPath, itemIdentifier in
        guard let self else { return UITableViewCell() }

        switch itemIdentifier {
        case .commonWeaterCell(let input):
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: GeneralWeatherCell.self
            )
            cell.configure(with: input)
            return cell
        case .hourlyWeaterCell(let input):
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: HourlyWeatherCell.self
            )
            cell.configure(with: input)
            return cell
        case .dailysWeaterCell(let input):
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: DailysWeatherCell.self
            )
            cell.configure(with: input)
            return cell
        }
    }

    // Метод для добавления элементов в таблицу с обновлением через `diffable data source`.
    private func appendItems(_ input: MainViewDataSource.Input) {
        var snapshot = Snapshot()

        snapshot.appendSections([.general, .hourly, .daily])

        // Добавление элементов в раздел "general"
        snapshot.appendItems(
            [
                .commonWeaterCell(
                    .init(
                        isCurrentLocation: input.isCurrentLocation,
                        nameCity: input.cityName,
                        temparature: input.temperature,
                        stateWeather: input.stateWeather?.capitalizingFirstLetter(),
                        feelsLikeTemperature: input.feelsLikeTemperature,
                        minTempDay: input.minTempDay,
                        maxTempDay: input.maxTempDay
                    )
                )
            ],
            toSection: .general
        )

        // Добавление элементов в раздел "hourly"
        snapshot.appendItems(
            [
                .hourlyWeaterCell(.init(items: input.hourlyWeather))
            ],
            toSection: .hourly
        )

        // Добавление элементов в раздел "daily"
        snapshot.appendItems(
            [
                .dailysWeaterCell(
                    .init(
                        dataSource: .init(items: input.dailysWeather)
                    )
                )
            ],
            toSection: .daily
        )

        // Применение изменений с анимацией.
        dataSource.defaultRowAnimation = .automatic
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// Входные данные для источника данных.
typealias MainViewDataSourceInput = MainViewDataSource.Input
extension MainViewDataSource {
    struct Input {
        var isCurrentLocation: Bool
        var cityName: String?
        var temperature: String?
        var stateWeather: String?
        var feelsLikeTemperature: String?
        var minTempDay: String?
        var maxTempDay: String?
        var hourlyWeather = [HourlyWeatherCellItem]()
        var dailysWeather = [DailyWeatherCellInput]()
    }
}

// Приватные методы
private extension MainViewDataSource {
    // Регистрирует ячейки для таблицы.
    func registerCell() {
        [
            GeneralWeatherCell.self,
            HourlyWeatherCell.self,
            DailysWeatherCell.self
        ].forEach {
            tableView.register(cellClass: $0)
        }
    }
}
