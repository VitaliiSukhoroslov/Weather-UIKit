//
//  ActionButton.swift
//  Weather-UIKit
//
//  Created by Виталий Сухорослов on 02.11.2024.
//
//

import UIKit

/// `ActionButton` — это пользовательский класс UIButton, который добавляет обработчики событий для различных состояний нажатия кнопки.
/// Этот класс позволяет обрабатывать нажатия, удержания и отмены нажатия с помощью замыканий.
class ActionButton: UIButton {
    // MARK: - Callbacks

    /// Замыкание, которое вызывается при нажатии кнопки.
    var touchDown: ((_ button: UIButton) -> Void)?

    /// Замыкание, которое вызывается при выходе из кнопки (отмена нажатия).
    var touchExit: ((_ button: UIButton) -> Void)?

    /// Замыкание, которое вызывается при отпускании кнопки.
    var touchUp: ((_ button: UIButton) -> Void)?

    /// Замыкание, которое вызывается при длительном нажатии кнопки.
    var touchDownLong: ((_ button: UIButton) -> Void)?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        initComponent()
        initConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        initComponent()
        initConstraints()
    }

    // MARK: - Private Methods

    /// Инициализация компонентов кнопки.
    /// Настраивает обработчики событий для различных состояний кнопки.
    private func initComponent() {
        addTarget(self, action: #selector(touchDown(_:)), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(touchExit(_:)), for: [.touchCancel, .touchDragExit])
        addTarget(self, action: #selector(touchUp(_:)), for: [.touchUpInside])
    }

    /// Инициализация ограничений для кнопки (если необходимо).
    private func initConstraints() {
        // Здесь можно добавить код для настройки ограничений
    }

    /// Добавляет жест длительного нажатия к кнопке.
    func addLongPressGesture() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        longPress.minimumPressDuration = 1.5
        self.addGestureRecognizer(longPress)
    }

    // MARK: - Gesture Handling

    /// Обработчик жеста длительного нажатия.
    /// - Parameter gesture: Жест длительного нажатия.
    @objc private func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            touchDownLong?(self)
        }
    }

    // MARK: - Action Methods

    /// Обработчик события нажатия кнопки.
    /// - Parameter sender: Кнопка, на которую нажали.
    @objc private func touchDown(_ sender: UIButton) {
        touchDown?(sender)
    }

    /// Обработчик события выхода из кнопки (отмена нажатия).
    /// - Parameter sender: Кнопка, от которой вышли.
    @objc private func touchExit(_ sender: UIButton) {
        touchExit?(sender)
    }

    /// Обработчик события отпускания кнопки.
    /// - Parameter sender: Кнопка, которую отпустили.
    @objc private func touchUp(_ sender: UIButton) {
        touchUp?(sender)
    }
}
