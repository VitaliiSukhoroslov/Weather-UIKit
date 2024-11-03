//
//  AppCoordinatable.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import Foundation

/// Протокол для координации на уровне приложения.
protocol AppCoordinatable: Coordinatable {
    /// Метод для запуска координации.
    func start()
}
