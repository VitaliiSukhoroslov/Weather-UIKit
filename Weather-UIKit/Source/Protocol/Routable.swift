//
//  Routable.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import Foundation

/// Протокол `Routable` определяет интерфейс для объектов, которые могут управлять навигацией и представлением модулей (контроллеров).
///
/// Этот протокол расширяет функциональность протокола `Presentable` и обеспечивает более детальный контроль
/// над тем, как модули представлены, в том числе возможность управления анимацией и завершением операций.
protocol Routable: Presentable {

    /// Представляет новый модуль (контроллер).
    /// - Parameter module: Контроллер, который нужно представить.
    func present(_ module: Presentable?)

    /// Представляет новый модуль (контроллер) с анимацией.
    /// - Parameters:
    ///   - module: Контроллер, который нужно представить.
    ///   - animated: Указывает, должна ли анимация быть включена.
    func present(_ module: Presentable?, animated: Bool)

    /// Представляет новый модуль (контроллер) с анимацией и завершающим блоком.
    /// - Parameters:
    ///   - module: Контроллер, который нужно представить.
    ///   - animated: Указывает, должна ли анимация быть включена.
    ///   - completion: Блок, который будет выполнен по завершении представления.
    func present(_ module: Presentable?, animated: Bool, completion: @escaping (() -> Void))

    /// Представляет модуль (контроллер) в полноэкранном режиме.
    /// - Parameter module: Контроллер, который нужно представить.
    /// - Parameter animated: Указывает, должна ли анимация быть включена.
    func presentOverfullscreen(_ module: Presentable?, animated: Bool)

    /// Переключает на новый модуль (контроллер) с помощью push.
    /// - Parameter module: Контроллер, который нужно добавить в стек.
    func push(_ module: Presentable?)

    /// Переключает на новый модуль (контроллер) с помощью push с анимацией.
    /// - Parameters:
    ///   - module: Контроллер, который нужно добавить в стек.
    ///   - animated: Указывает, должна ли анимация быть включена.
    func push(_ module: Presentable?, animated: Bool)

    /// Переключает на новый модуль (контроллер) с помощью push с анимацией и завершающим блоком.
    /// - Parameters:
    ///   - module: Контроллер, который нужно добавить в стек.
    ///   - animated: Указывает, должна ли анимация быть включена.
    ///   - completion: Блок, который будет выполнен по завершении перехода.
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)

    /// Убирает последний модуль (контроллер) из стека.
    func popModule()

    /// Убирает последний модуль (контроллер) из стека с анимацией.
    /// - Parameter animated: Указывает, должна ли анимация быть включена.
    func popModule(animated: Bool)

    /// Закрывает текущий модуль (контроллер).
    func dismissModule()

    /// Закрывает текущий модуль (контроллер) с анимацией и завершающим блоком.
    /// - Parameters:
    ///   - animated: Указывает, должна ли анимация быть включена.
    ///   - completion: Блок, который будет выполнен по завершении закрытия.
    func dismissModule(animated: Bool, completion: CompletionBlock?)

    /// Устанавливает новый корневой модуль (контроллер).
    /// - Parameters:
    ///   - module: Контроллер, который нужно установить в качестве корневого.
    ///   - rootAnimated: Указывает, должна ли анимация быть включена.
    func setRootModule(_ module: Presentable?, rootAnimated: Bool)

    /// Устанавливает новый корневой модуль (контроллер) с возможностью скрытия навигационной панели.
    /// - Parameters:
    ///   - module: Контроллер, который нужно установить в качестве корневого.
    ///   - hideNavigationBar: Указывает, должна ли навигационная панель быть скрыта.
    ///   - rootAnimated: Указывает, должна ли анимация быть включена.
    func setRootModule(_ module: Presentable?, hideNavigationBar: Bool, rootAnimated: Bool)

    /// Убирает все модули и возвращается к корневому контроллеру.
    /// - Parameter animated: Указывает, должна ли анимация быть включена.
    func popToRootModule(animated: Bool)
}
