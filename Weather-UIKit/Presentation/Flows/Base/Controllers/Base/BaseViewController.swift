//
//  BaseViewController.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit
import NVActivityIndicatorView

/// Протокол для контроллеров представления с пользовательским представлением.
public protocol ViewLoadable {
    associatedtype MainView: UIView
}

extension ViewLoadable where Self: UIViewController {
    /// Основное представление контроллера.
    public var mainView: MainView {
        guard let customView = view as? MainView else {
            fatalError("Expected view to be of type \(MainView.self) but got \(type(of: view)) instead")
        }
        return customView
    }
}

/// Контроллер представления, который использует пользовательское представление.
class ViewController<ViewType: UIView>: BaseViewController, ViewLoadable {
    public typealias MainView = ViewType

    /// Загружает пользовательское представление.
    override func loadView() {
        view = MainView()
    }

    /// Предпочитаемый стиль статус-бара.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

/// Базовый контроллер представления с дополнительными функциональными возможностями.
class BaseViewController: UIViewController, UIGestureRecognizerDelegate, BaseViewProtocol {

    var onCompletionByGesture: CompletionBlock?

    /// Инициализирует контроллер.
    init() {
        super.init(nibName: nil, bundle: nil)
        navigationItem.hidesBackButton = true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        onCompletionByGesture?()
    }

    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NVActivityIndicatorView.DEFAULT_TYPE = .circleStrokeSpin

        initUI()
        initConstraints()
        initListeners()
    }

    /// Метод для инициализации пользовательского интерфейса.
    func initUI() {
        // Настройка пользовательского интерфейса (переопределяется в подклассах).
    }

    /// Метод для инициализации ограничений.
    func initConstraints() {
        // Установка ограничений для пользовательского интерфейса (переопределяется в подклассах).
    }

    /// Метод для инициализации слушателей.
    func initListeners() {
        // Настройка слушателей событий (переопределяется в подклассах).
    }
}

// MARK: - Приватные методы для анимации

private extension BaseViewController {
    /// Запускает анимацию индикатора загрузки.
    func startAnimating() {
        UIWindow.key?.startAnimating()
    }

    /// Останавливает анимацию индикатора загрузки.
    func stopAnimating() {
        UIWindow.key?.stopAnimating()
    }
}

// MARK: - Методы для управления анимацией

extension BaseViewController {
    /// Управляет началом и остановкой анимации.
    /// - Parameter isStart: Указывает, следует ли начать или остановить анимацию.
    func onAnimating(isStart: Bool) {
        isStart ? startAnimating() : stopAnimating()
    }
}
