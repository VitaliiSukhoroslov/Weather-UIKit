//
//  PickerDismissAnimator.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// Пользовательская анимация закрытия контроллера представления для выборки.
class PickerDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    /// Возвращает продолжительность анимации перехода.
    /// - Parameter transitionContext: Контекст, содержащий информацию о переходе.
    /// - Returns: Продолжительность анимации перехода в секундах.
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        return 0.4
    }

    /// Выполняет пользовательскую анимацию перехода при закрытии контроллера представления.
    /// - Parameter transitionContext: Контекст, содержащий информацию о переходе.
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        guard let vc = transitionContext.viewController(forKey: .from),
              let backgroundView = (vc as? PickerAnimatable)?.animatedBackgroundView,
              let movingView = (vc as? PickerAnimatable)?.animatedMovingView else {
            return
        }

        transitionContext.containerView.addSubview(vc.view)
        let finalFrame = transitionContext.finalFrame(for: vc)

        let originalFrame = movingView.frame
        var movingFrame = originalFrame
        movingFrame.origin.y = finalFrame.maxY

        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            animations: {
                backgroundView.alpha = 0
                movingView.frame = movingFrame
            },
            completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
