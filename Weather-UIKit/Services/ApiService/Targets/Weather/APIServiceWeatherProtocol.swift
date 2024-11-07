//
//  APIServiceWeatherProtocol.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 03.11.2024.
//  
//

protocol APIServiceWeatherProtocol {
    var isReachable: Bool { get }

    /// Получение погоды по координатам
    func getWeatherLocationCoordinate(
        request: LocationCoordinateRequest,
        completion: ((Result<CommonWeather, Error>) -> Void)?
    )
}
