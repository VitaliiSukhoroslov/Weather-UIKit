//
//  SwipeInteractionController.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Контроллер взаимодействия, который позволяет закрывать представление свайпом вниз.
class SwipeInteractionController: UIPercentDrivenInteractiveTransition {

    // MARK: - Свойства

    /// Флаг, указывающий, что взаимодействие находится в процессе.
    private(set) var interactionInProgress = false

    /// Флаг, указывающий, что переход должен завершиться.
    private var shouldCompleteTransition = false

    /// Контроллер, представляющий представление, которое будет закрываться.
    private weak var viewController: UIViewController?

    /// Показывает, на сколько пикселей нижняя часть `animatedView` находится ниже нижней части его супервью.
    var animatedViewBottomOffset: CGFloat = 0

    /// Константа, уменьшающая необходимый перевод (translation) для закрытия окна на фиксированное значение.
    var translationDecreaseConstant: CGFloat = 0

    /// Порог скорости свайпа, после которого представление автоматически закроется.
    var velocityThreshold: CGFloat?

    /// Процент прогресса, после которого переход считается завершённым.
    let progressEnd: CGFloat

    // MARK: - Инициализация

    /// Инициализатор, задающий контроллер, представление для анимации и порог завершения перехода.
    /// - Parameters:
    ///   - viewController: Контроллер представления, которое должно быть закрыто.
    ///   - animatedView: Представление, которое будет участвовать в анимации свайпа.
    ///   - progressEnd: Минимальный процент завершения перехода для закрытия окна.
    init(
        viewController: UIViewController,
        animatedView: UIView,
        progressEnd: CGFloat
    ) {
        self.progressEnd = progressEnd
        super.init()
        self.viewController = viewController

        animatedView.addGestureRecognizer(
            UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        )
    }

    // MARK: - Обработка жестов

    /// Обработчик панорамного жеста, который обновляет прогресс перехода в зависимости от положения и скорости свайпа.
    /// - Parameter gestureRecognizer: Распознаватель жестов, отвечающий за панорамный свайп.
    @objc private func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let animatedViewHeight = gestureRecognizer.view?.bounds.height,
              let transitionView = gestureRecognizer.view?.superview?.superview else {
            finish()
            return
        }

        let currentTranslation = gestureRecognizer.translation(in: transitionView).y
        let currentVelocity = gestureRecognizer.velocity(in: transitionView).y

        let requiredTranslation = animatedViewHeight - animatedViewBottomOffset - translationDecreaseConstant
        let progress = min(max(currentTranslation / requiredTranslation, 0.0), 1.0)

        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController?.dismiss(animated: true, completion: nil)
        case .changed:
            let didPassVelocityThreshold = currentVelocity > velocityThreshold ?? CGFloat.greatestFiniteMagnitude
            shouldCompleteTransition = progress > progressEnd || didPassVelocityThreshold
            update(progress)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default: break
        }
    }

    /// Метод для принудительного завершения перехода.
    func close() {
        finish()
    }
}
