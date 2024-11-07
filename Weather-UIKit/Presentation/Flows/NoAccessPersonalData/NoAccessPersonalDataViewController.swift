//
//  NoAccessPersonalDataViewController.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 07.11.2024.
//  
//

import SnapKit
import UIKit

/**
 Контроллер для экрана, отображающего информацию о том, что нет доступа к персональным данным.
 */
class NoAccessPersonalDataViewController: ViewController<NoAccessPersonalDataView>, NoAccessPersonalDataAssemblable {

    // MARK: - Navigation
    var onCompletion: CompletionBlock?

    // MARK: - Dependency
    var presenter: NoAccessPersonalDataPresenterInput?

    // MARK: - Life Cycles
    override func loadView() {
        super.loadView()

        mainView.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.onStart()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        mainView.swipeDismissInteractor?.animatedViewBottomOffset = mainView.animatedViewBottomOffset
    }

    override func initUI() {
        configureSwipeAction()
    }

    override func initListeners() {
        transitioningDelegate = self
    }

    /// Обработчик нажатия на фон для завершения экрана.
    @objc func tapHolder() {
        self.onCompletion?()
    }

    deinit {
        print("NoAccessPersonalDataViewController is deinit")
    }

    // MARK: - Private methods
}

// MARK: - NoAccessPersonalDataPresenterOutput

extension NoAccessPersonalDataViewController {
    /// Метод для подготовки данных для отображения в представлении.
    func prepareData(_ input: NoAccessPersonalDataViewInput) {
        mainView.configure(input)
    }
}

extension NoAccessPersonalDataViewController: UIViewControllerTransitioningDelegate {
    /// Метод для анимации представления при появлении.
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        PickerPresentAnimator()
    }

    /// Метод для анимации представления при исчезновении.
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        PickerDismissAnimator()
    }

    /// Метод для управления интерактивной анимацией при закрытии экрана.
    func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        guard let interactionInProgress = mainView.swipeDismissInteractor?.interactionInProgress else {
            return nil
        }
        return interactionInProgress ? mainView.swipeDismissInteractor : nil
    }
}

extension NoAccessPersonalDataViewController: PickerAnimatable {
    /// Взаимодействие с анимацией фона.
    var animatedBackgroundView: UIView {
        mainView.backgroundView
    }

    /// Взаимодействие с анимацией движущегося вида.
    var animatedMovingView: UIView {
        mainView.animatedView
    }
}

private extension NoAccessPersonalDataViewController {
    /// Конфигурирует действие свайпа для закрытия экрана.
    func configureSwipeAction() {
        mainView.swipeDismissInteractor = SwipeInteractionController(
            viewController: self,
            animatedView: mainView.animatedView,
            progressEnd: 0.3
        )
        mainView.swipeDismissInteractor?.animatedViewBottomOffset = mainView.animatedViewBottomOffset
        mainView.swipeDismissInteractor?.velocityThreshold = 1500

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHolder))
        mainView.backgroundView.addGestureRecognizer(tapGesture)
    }
}
