//
//  HourlyWeatherCell.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 06.11.2024.
//

import UIKit
import Kingfisher

/**
 Ячейка таблицы для отображения прогноза погоды на конкретные часы.
 Эта ячейка отображает информацию о погоде для нескольких часов в виде горизонтального скролл-списка.
 */
final class HourlyWeatherCell: BaseTableViewCell {

    private var input: Input?


    /// Метод для настройки ячейки с передачей входных данных.
    /// - Parameter input: Входящие данные для настройки ячейки.
    func configure(with input: Input) {
        self.input = input

        scrollStackView.configure(
            scrollOrientation: .horizontal,
            spacing: 38,
            with: input.items.map { configView(with: $0) }
        )

        layoutIfNeeded()
    }

    override func layoutIfNeeded() {
        super.layoutIfNeeded()

        scrollStackView.snp.updateConstraints {
            $0.height.equalTo(scrollStackView.stackView.frame.size.height)
        }
    }

    // MARK: - UI
    private let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .black.withAlphaComponent(0.5)
        return view
    }()

    private let scrollStackView = ScrollStackView()

    override func initUI() {
        contentView.addSubviews(mainView)
        mainView.addSubview(scrollStackView)
    }

    override func initConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        scrollStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(0)
        }
    }

    override func initListeners() {
        selectionStyle = .none
    }
}

// MARK: - Дополнительные функции

private extension HourlyWeatherCell {
    /// Метод для создания вида для отображения информации о погоде в конкретный час.
    /// - Parameter item: Информация для одного часа.
    /// - Returns: UIView, содержащий информацию о часе, иконке и температуре.
    func configView(with item: Item) -> UIView {
        let view = UIView()

        let hourLabel: UILabel = {
            let label = UILabel()
            label.text = item.hour
            label.textColor = .white
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.textAlignment = .center
            return label
        }()

        let icon: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            return view
        }()

        icon.kf.setImage(with: IconAPpi.configureURL(with: item.icon))

        let tempLabel: UILabel = {
            let label = UILabel()
            label.text = item.temp
            label.textColor = .white
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.textAlignment = .center
            return label
        }()

        view.addSubviews(hourLabel, icon, tempLabel)

        hourLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        icon.snp.makeConstraints {
            $0.top.equalTo(hourLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(44)
        }
        tempLabel.snp.makeConstraints {
            $0.top.equalTo(icon.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        return view
    }
}

// MARK: - Входные и выходные данные

typealias HourlyWeatherCellInput = HourlyWeatherCell.Input
typealias HourlyWeatherCellItem = HourlyWeatherCell.Item

extension HourlyWeatherCell {
    /// Структура, представляющая элемент для отображения прогноза погоды на конкретный час.
    /// - `hour`: Час (например, "12:00").
    /// - `icon`: Иконка, которая будет отображать состояние погоды.
    /// - `temp`: Температура на этот час.
    struct Item: Hashable {
        let hour: String
        let icon: String
        let temp: String

        init(hour: String, icon: String, temp: String) {
            self.hour = hour
            self.icon = icon
            self.temp = temp
        }
    }

    /// Структура для входных данных ячейки, содержащая массив объектов `Item`.
    /// - `items`: Список элементов, представляющих прогноз погоды на несколько часов.
    struct Input: Hashable {
        let items: [Item]
    }
}
