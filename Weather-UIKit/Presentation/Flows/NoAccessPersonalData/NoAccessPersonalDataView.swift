import UIKit

/// Представление экрана "доступа к персональным данным".
final class NoAccessPersonalDataView: BaseView {

    // State
    var presenter: NoAccessPersonalDataPresenterInput?

    /// Конфигурирует представление с входными данными.
    /// - Parameter input: Входные данные, содержащие заголовок и подзаголовок для отображения.
    func configure(_ input: NoAccessPersonalDataViewInput) {
        titleLabel.text = input.title
        subtitleLabel.text = input.subtitle
    }

    var animatedViewBottomOffset: CGFloat = 0.0
    var swipeDismissInteractor: SwipeInteractionController?

    // MARK: - UI Elements
    private(set) var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()

    private(set) var animatedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()

    private let shapeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 2.5
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let settingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.setTitle("To settings".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 24
        return button
    }()

    /// Инициализация пользовательского интерфейса.
    override func initUI() {
        addSubviews(backgroundView, animatedView)
        animatedView.addSubviews(
            shapeView,
            titleLabel,
            subtitleLabel,
            settingsButton
        )
    }

    /// Установка ограничений для UI-элементов.
    override func initConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        shapeView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(5)
            $0.width.equalTo(44)
        }
        animatedView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(10)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(shapeView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        settingsButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }

        layoutIfNeeded()
    }

    /// Инициализация слушателей событий.
    override func initListeners() {
        settingsButton.addTarget(
            self,
            action: #selector(didTapSettingsButton),
            for: .touchUpInside
        )
    }

    /// Обработчик нажатия на кнопку перехода в настройки.
    @objc func didTapSettingsButton() {
        presenter?.onSettingsApp()
    }
}

typealias NoAccessPersonalDataViewInput = NoAccessPersonalDataView.Input

/// Структура входных данных для конфигурации представления.
extension NoAccessPersonalDataView {
    struct Input {
        var title: String
        var subtitle: String
    }
}
