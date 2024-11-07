//
//  MainInteractor.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//  
//

import UIKit

/// Основной интерактор для модуля "Main".
final class MainInteractor {

    unowned var presenter: MainPresenter?

    private let apiServiceWeather: APIServiceWeatherProtocol = APIServiceWeather()

    // TODO: Реализуйте методы использования
}

// MARK: - Интерфейс интерактора
extension MainInteractor {
    func getWeatherCurrentLocation(request: LocationCoordinateRequest) {
        apiServiceWeather.getWeatherLocationCoordinate(
            request: request
        ) { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let response):
                presenter?.onSuccess(weater: response)
            case .failure:
                presenter?.onFailure()
            }
        }
    }
}
