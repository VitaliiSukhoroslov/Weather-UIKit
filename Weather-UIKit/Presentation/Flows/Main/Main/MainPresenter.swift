//
//  MainPresenter.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//  
//

import UIKit
import CoreLocation
import Combine

/// Протокол для основного представления, наследующий от базового протокола представления.
protocol MainViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
    var onNotAccessPersonalData: CompletionResult<(
        input: NoAccessPersonalDataPresenter.Input,
        completion: CompletionBlock?
    )>? { get set }
}

/// Протокол для входящих методов презентера.
protocol MainPresenterInput: AnyObject {
    func onStart()
}

/// Протокол для выходящих методов презентера.
protocol MainPresenterOutput: BasePresenterOutput, MainViewProtocol {
    var presenter: MainPresenterInput? { get set }

    func prepareData(_ input: MainViewDataSourceInput)
}

/// Презентер для модуля "Main".
final class MainPresenter: NSObject {

    // Зависимости
    weak var output: MainPresenterOutput?
    var interactor: MainInteractor?

    private var locationManager = CLLocationManager()
    private var cancellables = Set<AnyCancellable>()

    // Свойства для хранения
    private var location = PassthroughSubject<CLLocation, Never>()
    private var dataSourceInput = MainViewDataSourceInput(isCurrentLocation: true)

    let input: Input

    init(_ input: Input) {
        self.input = input
    }

    // Метод для успешного получения данных о погоде
    func onSuccess(weater: CommonWeather) {
        output?.onAnimating(isStart: false)
        configDataSource(with: weater)
    }

    // Метод для обработки ошибки
    func onFailure() {
        output?.onAnimating(isStart: false)
    }
}

private extension MainPresenter {
    // MARK: - Common
    // Запрос геолокации
    func requestGeolocation() {
        output?.onAnimating(isStart: true)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    // MARK: - Config Data Source
    // Настройка данных источника для общих сведений о погоде
    func configDataSource(with weather: CommonWeather) {
        configCommonDataSource(with: weather)
        configHourlyDataSource(with: weather)
        configDailysDataSource(with: weather)

        output?.prepareData(dataSourceInput)
    }

    // Настройка данных для общей погоды
    func configCommonDataSource(with weather: CommonWeather) {
        dataSourceInput.temperature = "\(Int(weather.current.temp))"
        dataSourceInput.stateWeather = weather.current.weather.last?.description
        dataSourceInput.feelsLikeTemperature = "\(Int(weather.current.feelsLike))"

        // Находим данные для текущего дня
        if let currentDay = weather.daily.first(where: {
            Formatter.convertIntToString($0.dt, .yyyyMMdd)
            == Formatter.getCurrentDayString(format: .yyyyMMdd)
        }) {
            dataSourceInput.maxTempDay = "\(Int(currentDay.temp.max))"
            dataSourceInput.minTempDay = "\(Int(currentDay.temp.min))"
        }
    }

    // Настройка данных для почасового прогноза
    func configHourlyDataSource(with weather: CommonWeather) {
        let hourlyOneDay = Array(weather.hourly.prefix(24))
        var itemsHourly: [HourlyWeatherCellItem] = hourlyOneDay.map {
            .init(
                hour: $0.dt == weather.hourly.first?.dt
                ? "Now".localized  // Текущее время
                : Formatter.convertIntToString($0.dt, .HH),
                icon: $0.weather.last?.icon ?? "",
                temp: "Temperature Celsius".localized.replacingOccurrences(
                    of: "%s", with: "\(Int($0.temp))"
                )
            )
        }

        // Функция для нахождения индекса вставки для события (восход или закат)
        func findInsertionIndex(for eventTime: Int) -> Int? {
            for i in 0..<hourlyOneDay.count - 1 {
                if eventTime >= hourlyOneDay[i].dt && eventTime < hourlyOneDay[i + 1].dt {
                    return i + 1
                }
            }
            return nil
        }

        // Вставляем восход и закат в список почасовых данных
        Array(weather.daily.prefix(2)).forEach { day in
            if let sunriseIndex = findInsertionIndex(for: day.sunrise) {
                itemsHourly.insert(
                    .init(
                        hour: Formatter.convertIntToString(day.sunrise, .HHmm),
                        icon: "01d",
                        temp: "Sunrise".localized
                    ),
                    at: sunriseIndex
                )
            }
            if let sunsetIndex = findInsertionIndex(for: day.sunset) {
                itemsHourly.insert(
                    .init(
                        hour: Formatter.convertIntToString(day.sunset, .HHmm),
                        icon: "01n",
                        temp: "Sunset".localized
                    ),
                    at: sunsetIndex
                )
            }
        }

        dataSourceInput.hourlyWeather = itemsHourly
    }

    // Настройка данных для ежедневного прогноза
    func configDailysDataSource(with weather: CommonWeather) {
        dataSourceInput.dailysWeather = weather.daily.map {
            .init(
                nameDay: $0.dt == weather.daily.first?.dt
                ? "Now".localized
                : Formatter.convertIntToString($0.dt, .EE),
                icon: $0.weather.last?.icon ?? "",
                description: $0.weather.last?.description ?? "",
                minTemp: "Temperature Celsius".localized.replacingOccurrences(
                    of: "%s", with: "\(Int($0.temp.min))"
                ),
                maxTemp: "Temperature Celsius".localized.replacingOccurrences(
                    of: "%s", with: "\(Int($0.temp.max))"
                ),
                isLast: $0.dt == weather.daily.last?.dt
            )
        }
    }
}

// MARK: - MainPresenterInput

extension MainPresenter: MainPresenterInput {
    func onStart() {
        guard
            let cityId = input.cityId
        else {
            binding()
            requestGeolocation()
            return
        }
        dataSourceInput.isCurrentLocation = false
        print(cityId)
    }

    func binding() {
        location
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .sink { [weak self] location in
                guard let self else { return }
                fetchCity(for: location)
            }.store(in: &cancellables)
    }
}

// MARK: - CLLocationManagerDelegate

extension MainPresenter: CLLocationManagerDelegate {
    // Метод, вызываемый при обновлении местоположения
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }

        self.location.send(location)
    }

    // Метод, вызываемый при ошибке геолокации
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        output?.onAnimating(isStart: false)
        output?.onNotAccessPersonalData?((
            input: .init(typeAccessData: .geoData),
            completion: { [weak self] in
                self?.onStart()
            }
        ))
    }

    // Метод для получения города по геолокации
    func fetchCity(for location: CLLocation) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self else { return }

            if let error {
                print("Ошибка геокодирования: \(error.localizedDescription)")
                return
            }

            guard
                let placemark = placemarks?.first,
                let city = placemark.locality
            else {
                print("Не удалось получить название города")
                return
            }

            dataSourceInput.cityName = city
            interactor?.getWeatherCurrentLocation(
                request: .init(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
            )
        }
    }
}

// MARK: - Input

extension MainPresenter {
    struct Input {
        let cityId: Int?

        init(
            cityId: Int? = nil
        ) {
            self.cityId = cityId
        }
    }
}
