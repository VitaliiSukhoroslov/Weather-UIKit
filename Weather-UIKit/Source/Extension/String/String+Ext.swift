//
//  String+Ext.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 05.11.2024.
//

import Foundation

extension String {

    /// Возвращает локализованную версию строки.
    /// - Returns: Локализованная версия строки, если ключ существует; в противном случае возвращается сам ключ.
    var localized: String {
        String(localized: LocalizationValue(self))
    }
}

extension String {

    /// Возвращает строку, где первый символ заглавный, а остальные — строчные.
    /// - Returns: Строка с заглавным первым символом и строчными остальными символами.
    func capitalizingFirstLetter() -> String {
        guard let first = self.first else { return "" }
        return first.uppercased() + self.dropFirst().lowercased()
    }
}
