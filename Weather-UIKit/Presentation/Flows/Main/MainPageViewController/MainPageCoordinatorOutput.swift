//
//  MainAssembly.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import Foundation

/// Протокол для координаторов модуля "MainPage".
protocol MainPageCoordinatorOutput: AnyObject {

    /// Блок завершения, который вызывается при завершении потока.
    var finishFlow: CompletionBlock? { get set }
}
