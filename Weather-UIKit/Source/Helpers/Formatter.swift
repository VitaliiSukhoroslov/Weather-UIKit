//
//  Formatter.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 06.11.2024.
//

import Foundation

/// `Formatter` - вспомогательная структура для форматирования дат и времени.
enum Formatter {

    /// Перечисление форматов даты и времени, используемых для преобразования.
    enum Format: String {
        /// Полный формат даты, пример: "yyyy-MM-dd".
        case yyyyMMdd = "yyyy-MM-dd"
        /// День недели, пример: "Mon".
        case EE = "EE"
        /// Час в формате 24 часов, пример: "14".
        case HH = "HH"
        /// Часы и минуты, пример: "14:30".
        case HHmm = "HH:mm"
    }

    /// Преобразует целочисленное значение времени (в формате Unix timestamp) в строку с заданным форматом.
    /// - Parameters:
    ///   - value: Целочисленное значение времени (Unix timestamp).
    ///   - convertFormat: Формат для преобразования.
    /// - Returns: Строка, представляющая отформатированное время.
    static func convertIntToString(
        _ value: Int,
        _ convertFormat: Format
    ) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(value))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = convertFormat.rawValue
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }

    /// Получает текущую дату и время в формате строки.
    /// - Parameter convertFormat: Формат для представления текущей даты и времени.
    /// - Returns: Строка, представляющая текущую дату или время в указанном формате.
    static func getCurrentDayString(format convertFormat: Format) -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = convertFormat.rawValue
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: today)
    }
}
