//
//  DailyWeatherCell.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 07.11.2024.
//

import UIKit

/**
 Ячейка таблицы для отображения данных о прогнозе погоды на один день.

 Эта ячейка отображает информацию о дне недели, иконку погоды, описание состояния погоды,
 а также минимальную и максимальную температуру для дня. Она также включает разделительную линию
 между ячейками, которая скрывается для последней ячейки.
 */
final class DailyWeatherCell: BaseTableViewCell {

     /// Конфигурирует ячейку с данными о прогнозе погоды на один день.
     /// - Parameter input: Структура `DailyWeatherCellInput`, содержащая информацию о дне, иконке, описании погоды и температуре.
    func configure(with input: DailyWeatherCellInput) {
        nameDayLabel.text = input.nameDay
        iconView.kf.setImage(with: IconAPpi.configureURL(with: input.icon))
        descriptionWeatherLabel.text = input.description
        separatorView.isHidden = input.isLast
        temperatureLabel.text = input.minTemp + "-" + input.maxTemp
    }

    // MARK: - UI
    private let nameDayLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .white
        return label
    }()

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let descriptionWeatherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()

    private let separatorView = SeparatorLineView()

    // MARK: - UI Setup
    override func initUI() {
        contentView.addSubviews(
            nameDayLabel,
            iconView,
            descriptionWeatherLabel,
            separatorView,
            temperatureLabel
        )
    }

    // MARK: - Constraints
    override func initConstraints() {
        nameDayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(65)
        }
        iconView.snp.makeConstraints {
            $0.size.equalTo(35)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(nameDayLabel.snp.trailing).offset(16)
        }
        descriptionWeatherLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(iconView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-100)
        }
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        temperatureLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.leading.equalTo(descriptionWeatherLabel.snp.trailing).offset(16)
        }
    }

    // MARK: - Listeners
    override func initListeners() {
        selectionStyle = .none
    }
}

// MARK: - Input Model

typealias DailyWeatherCellInput = DailyWeatherCell.Input
extension DailyWeatherCell {
     /// Входная структура для конфигурации ячейки.
     /// Структура содержит все необходимые данные для отображения информации о дне.
    struct Input: Hashable {
        let nameDay: String
        let icon: String
        let description: String
        let minTemp: String
        let maxTemp: String
        let isLast: Bool
    }
}
