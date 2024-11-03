//
//  MainPresenter.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//  
//

import UIKit
import CoreLocation

/// Протокол для основного представления, наследующий от базового протокола представления.
protocol MainViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}

/// Протокол для входящих методов презентера.
protocol MainPresenterInput: AnyObject {
    func onStart()
}

/// Протокол для выходящих методов презентера.
protocol MainPresenterOutput: AnyObject {
    var presenter: MainPresenterInput? { get set }

    func prepareData()
}

/// Презентер для модуля "Main".
final class MainPresenter: NSObject {

    // Dependency
    weak var output: MainPresenterOutput?
    var interactor: MainInteractor?

    // Storage property
    private var locationManager = CLLocationManager()
    let input: Input

    init(
        _ input: Input
    ) {
        self.input = input
    }

    // TODO: реализуйте методы взаимодействия с интерактором.
}

private extension MainPresenter {
    func requestGeolocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

// MARK: - MainPresenterInput

extension MainPresenter: MainPresenterInput {
    func onStart() {
        guard
            let cityId = input.cityId
        else {
            requestGeolocation()
            return
        }
        print(cityId)
        output?.prepareData()
    }
}

extension MainPresenter: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }

        print(location)
        fetchCity(for: location)
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Ошибка получения локации: \(error.localizedDescription)")
    }

    func fetchCity(for location: CLLocation) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
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

            print(city)
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
