//
//  CommonWeaterCell.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 06.11.2024.
//

import UIKit

/**
 Ячейка таблицы для отображения общей информации о погоде.
 Эта ячейка отображает текущую температуру, название города, описание состояния погоды, ощущаемую температуру и максимальные/минимальные температуры на день.
 */
final class GeneralWeatherCell: BaseTableViewCell {

    /// Метод для конфигурации ячейки с передачей входных данных.
    /// - Parameter input: Входные данные для ячейки.
    func configure(with input: Input) {

        currentLocationTitleLabel.text = input.isCurrentLocation
            ? "Current location".localized.uppercased() : ""

        nameCityLabel.text = input.nameCity
        temperatureLabel.text = input.temparature

        if let stateWeater = input.stateWeather {
            stateWeaterLabel.text = stateWeater
        }

        feelsLikeWeaterLabel.text = "Feels Like".localized.replacingOccurrences(
            of: "%s", with: input.feelsLikeTemperature ?? ""
        )

        if let maxTemp = input.maxTempDay, let minTemp = input.minTempDay {
            let maxTempDay = "Max Temperature".localized.replacingOccurrences(
                of: "%s", with: maxTemp
            ).capitalizingFirstLetter()
            let minTempDay = "Min Temperature".localized.replacingOccurrences(
                of: "%s", with: minTemp
            )

            minMaxTemperatureLabel.text = "\(maxTempDay), \(minTempDay)"
        }
    }

    // MARK: - UI
    private let currentLocationTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()

    private let nameCityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = .white
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 72, weight: .light)
        label.textColor = .white
        return label
    }()

    private let celsiusSymbolLabel: UILabel = {
        let label = UILabel()
        label.text = "Celsius symbol".localized
        label.font = .systemFont(ofSize: 72, weight: .regular)
        label.textColor = .white
        return label
    }()

    private let stateWeaterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.7)
        return label
    }()

    private let feelsLikeWeaterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.8)
        return label
    }()

    private let minMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        return label
    }()

    public override func initUI() {
        contentView.addSubviews(
            currentLocationTitleLabel,
            nameCityLabel,
            temperatureLabel,
            celsiusSymbolLabel,
            stateWeaterLabel,
            feelsLikeWeaterLabel,
            minMaxTemperatureLabel
        )
    }

    public override func initConstraints() {
        currentLocationTitleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        nameCityLabel.snp.makeConstraints {
            $0.top.equalTo(currentLocationTitleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(nameCityLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        celsiusSymbolLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(temperatureLabel)
            $0.leading.equalTo(temperatureLabel.snp.trailing)
        }
        stateWeaterLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        feelsLikeWeaterLabel.snp.makeConstraints {
            $0.top.equalTo(stateWeaterLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        minMaxTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(feelsLikeWeaterLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
        }
    }

    public override func initListeners() {
        selectionStyle = .none
    }
}

// MARK: - Входные данные

typealias GeneralWeatherCellInput = GeneralWeatherCell.Input

extension GeneralWeatherCell {
    /**
     Структура для входных данных, используемых ячейкой.

     - `isCurrentLocation`: Определяет, является ли локация текущей.
     - `nameCity`: Название города.
     - `temparature`: Температура.
     - `stateWeather`: Состояние погоды (например, "Clear", "Rain").
     - `feelsLikeTemperature`: Ощущаемая температура.
     - `minTempDay`: Минимальная температура на день.
     - `maxTempDay`: Максимальная температура на день.
     */
    struct Input: Hashable {
        let isCurrentLocation: Bool
        let nameCity: String?
        let temparature: String?
        let stateWeather: String?
        let feelsLikeTemperature: String?
        var minTempDay: String?
        var maxTempDay: String?
    }
}
