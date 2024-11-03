//
//  MainAssembly.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/**
 MainPageViewController — основной контроллер для отображения страниц погоды.
 */
class MainPageViewController: UIPageViewController, MainPageAssemblable {

    // MARK: - Navigation
    var onCompletion: CompletionBlock?
    var onCompletionByGesture: CompletionBlock?

    // MARK: - Dependency
    var presenter: MainPagePresenterInput?

    // MARK: - State
    private var pages: [UIViewController] = []

    // MARK: - Initialization

    /// Инициализация контроллера с заданным стилем и ориентацией.
    init() {
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        delegate = self
        dataSource = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.onStart()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    deinit {
        print("MainPageViewController is deinit")
    }
}

// MARK: - MainPagePresenterOutput

extension MainPageViewController {

    /// Настройка данных для страниц
    /// - Parameter vcs: Контроллеры для MainPageViewController
    func prepareData(vcs: [UIViewController]) {
        pages = vcs
        guard let firstPage = pages.first else { return }

        setViewControllers(
            [firstPage],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }
}

// MARK: - UIPageViewControllerDelegate

extension MainPageViewController: UIPageViewControllerDelegate {
    /// Метод, вызываемый после завершения анимации перехода между страницами.
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {

        guard completed, let visibleViewController = viewControllers?.first,
              let index = pages.firstIndex(of: visibleViewController) else { return }

        print("Current Page Index: \(index)")
    }
}

// MARK: - UIPageViewControllerDataSource

extension MainPageViewController: UIPageViewControllerDataSource {

    /// Метод для получения контроллера перед текущим контроллером.
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }

    /// Метод для получения контроллера после текущего контроллера.
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
}
