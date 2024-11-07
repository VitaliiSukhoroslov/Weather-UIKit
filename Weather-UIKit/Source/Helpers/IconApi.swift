//
//  IconApi.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 05.11.2024.
//

import UIKit

/// `IconAPpi` - вспомогательное перечисление для работы с URL-адресами иконок погоды.
enum IconAPpi {

    /// Базовый URL-адрес для иконок погоды. `%s` будет заменён на код иконки.
    static let baseURL = "https://openweathermap.org/img/wn/%s@2x.png"

    /// Конфигурирует полный URL для загрузки иконки погоды, заменяя `%s` на код иконки.
    /// - Parameter nameIconApi: Код иконки, полученный от API (например, "10d" для дождя).
    /// - Returns: URL, ведущий к изображению иконки.
    static func configureURL(with nameIconApi: String) -> URL {
        URL(string: baseURL.replacingOccurrences(of: "%s", with: nameIconApi))!
    }
}
