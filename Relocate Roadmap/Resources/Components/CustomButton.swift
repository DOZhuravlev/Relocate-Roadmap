//
//  CustomButton.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 26.07.2023.
//

import UIKit
import SnapKit

protocol CustomButtonType {
    var standard: CustomButtonConfiguration { get }
    var pressed: CustomButtonConfiguration { get }
}

protocol CustomButtonConfiguration {
    var backgroundColor: UIColor? { get }
    var titleColor: UIColor { get }
    var tintColor: UIColor { get }
    var font: UIFont { get }
}

protocol CustomButtonSize {
    var buttonHeight: CGFloat { get }
    var buttonWidth: CGFloat { get }
}

enum CustomButtonState {
    case standard
    case pressed
}

final class CustomButton: UIView {
    private let title: String
    private let type: CustomButtonType
    private let state: CustomButtonState
    private let size: CustomButtonSize
    private let action: () -> Void

    private let button = UIButton(frame: .zero)

    init(title: String, type: CustomButtonType, state: CustomButtonState, size: CustomButtonSize, action: @escaping () -> Void) {
        self.title = title
        self.type = type
        self.state = state
        self.size = size
        self.action = action

        super.init(frame: .zero)

        embedView()
        setupConstraints()
        setupAppearance()

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var stateConfig: CustomButtonConfiguration {
        switch state {
        case .standard: return type.standard
        case .pressed: return type.pressed
        }
    }
}

//MARK: - Setup view

private extension CustomButton {

    func embedView() {
        addSubview(button)
    }

    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(size.buttonHeight)
            make.width.equalTo(size.buttonWidth)
        }
    }

    func setupAppearance() {
        button.backgroundColor = stateConfig.backgroundColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(stateConfig.titleColor, for: .normal)
        button.setTitleColor(stateConfig.titleColor, for: .highlighted)
        button.tintColor = stateConfig.tintColor
        button.layer.cornerRadius = 20
        button.titleLabel?.font = stateConfig.font
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped() {
        action()
    }
}


