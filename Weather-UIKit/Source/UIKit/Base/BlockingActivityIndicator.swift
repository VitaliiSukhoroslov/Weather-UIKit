//
//  BlockingActivityIndicator.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import NVActivityIndicatorView
import UIKit

/// Класс `BlockingActivityIndicator` представляет собой блокирующий индикатор загрузки.
/// Он отображает индикатор активности поверх всего экрана с затемненным фоном.
final class BlockingActivityIndicator: UIView {
    private let activityIndicator: NVActivityIndicatorView

    override init(frame: CGRect) {
        self.activityIndicator = NVActivityIndicatorView(
            frame: CGRect(
                origin: .zero,
                size: CGSize(width: 30, height: 30)
            )
        )

        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        super.init(frame: frame)

        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Расширение для UIWindow

extension UIWindow {
    /// Возвращает основное окно приложения.
    static var key: UIWindow? {
        let sceneDelegate = UIApplication.shared.connectedScenes
            .first!.delegate as! SceneDelegate
        return sceneDelegate.window
    }
}

// MARK: - Методы для управления индикатором активности

extension UIWindow {
    /// Метод для отображения индикатора загрузки.
    func startAnimating() {
        guard !subviews.contains(where: { $0 is BlockingActivityIndicator }) else {
            return
        }
        let activityIndicator = BlockingActivityIndicator()
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.frame = bounds

        UIView.transition(
            with: self,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: { self.addSubview(activityIndicator) }
        )
    }

    /// Метод для скрытия индикатора загрузки.
    func stopAnimating() {
        subviews.compactMap({ $0 as? BlockingActivityIndicator }).forEach({ existingView in
            UIView.transition(
                with: self,
                duration: 0.3, // Длительность анимации
                options: .transitionCrossDissolve, // Эффект перехода
                animations: { existingView.removeFromSuperview() } // Удаляем индикатор
            )
        })
    }
}
