//
//  AuthorizationCoordinatorOutput.swift
//  Worker Dashy
//
//  Created by Umbrella tech on 17.08.17.
//  Copyright © 2017 Umbrella. All rights reserved.
//

import Foundation

/// Протокол для вывода координации экрана доступа к персональным данным.
/// Определяет обязательные свойства и методы для управления завершением потока и запуском экрана.
protocol NoAccessPersonalDataCoordinatorOutput: AnyObject {

    /// Блок, который вызывается при завершении потока.
    var finishFlow: CompletionBlock? { get set }

    /// Запускает экран с переданными входными данными.
    /// - Parameter input: Входные данные для настройки экрана.
    func start(_ input: NoAccessPersonalDataPresenter.Input)
}
