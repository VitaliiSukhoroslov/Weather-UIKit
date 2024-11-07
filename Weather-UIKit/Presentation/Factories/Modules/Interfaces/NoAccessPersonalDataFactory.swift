//
//  NoAccessPersonalDataFactory.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 07.11.2024.
//  
//

import Foundation

protocol NoAccessPersonalDataFactory {
    /// Создает и возвращает основное представление `NoAccessPersonalData`
    /// - Parameter input: Входящий параметр для презентора
    /// - Returns: Объект, реализующий `NoAccessPersonalDataViewProtocol`
    func makeNoAccessPersonalDataView(
        input: NoAccessPersonalDataPresenter.Input
    ) -> NoAccessPersonalDataViewProtocol
}
