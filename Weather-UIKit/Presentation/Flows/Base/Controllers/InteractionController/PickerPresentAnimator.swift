//
//  PickerPresentAnimator.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Протокол для контроллеров, которые поддерживают анимацию с фоном и движущимся представлением.
protocol PickerAnimatable {
    /// Представление, отображающее задний фон для анимации.
    var animatedBackgroundView: UIView { get }
    /// Основное движущееся представление, которое будет анимироваться.
    var animatedMovingView: UIView { get }
}

/// Класс для анимации перехода, при котором представление появляется с движением и плавным фоном.
class PickerPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    /// Устанавливает продолжительность анимации перехода.
    /// - Parameter transitionContext: Контекст перехода, предоставляющий информацию о переходе.
    /// - Returns: Продолжительность анимации перехода.
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        return 0.5
    }

    /// Выполняет анимацию перехода.
    /// - Parameter transitionContext: Контекст перехода, содержащий информацию о начальном и конечном состоянии представлений.
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        guard let toVC = transitionContext.viewController(forKey: .to),
              let pickerAnimatable = toVC as? PickerAnimatable
        else {
            transitionContext.completeTransition(false)
            return
        }

        let containerView = transitionContext.containerView
        let backgroundView = pickerAnimatable.animatedBackgroundView
        let movingView = pickerAnimatable.animatedMovingView
        let finalFrame = transitionContext.finalFrame(for: toVC)

        containerView.addSubview(toVC.view)
        toVC.view.frame = finalFrame
        toVC.view.layoutIfNeeded()

        backgroundView.alpha = 0
        let initialFrame = movingView.frame
        movingView.frame = CGRect(
            x: initialFrame.origin.x,
            y: finalFrame.maxY,
            width: initialFrame.width,
            height: initialFrame.height
        )

        let duration = transitionDuration(using: transitionContext)

        UIView.animate(
            withDuration: duration / 2
        ) {
            backgroundView.alpha = 1
        }

        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.0,
            options: .curveEaseInOut,
            animations: {
                movingView.frame = initialFrame
            },
            completion: { completed in
                transitionContext.completeTransition(
                    !transitionContext.transitionWasCancelled
                )
            }
        )
    }
}
