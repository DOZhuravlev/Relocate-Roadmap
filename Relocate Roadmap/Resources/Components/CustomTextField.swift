//
//  CustomTextField.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.07.2023.
//

import UIKit

class CustomTextField: UITextField {
    // MARK: - Configuration
    var normalConfig: TextFieldConfiguration = TextFieldNormalConfiguration()
    var focusConfig: TextFieldConfiguration = TextFieldFocusConfiguration()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupAppearance()
        setupEvents()
    }

    // MARK: - Setup

    private func setupAppearance() {
        applyConfiguration(normalConfig)
    }

    private func setupEvents() {
        addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    }

    // MARK: - Configuration Handling

    private func applyConfiguration(_ config: TextFieldConfiguration) {
        backgroundColor = config.backgroundColor
        textColor = config.textColor
        font = config.font
        layer.cornerRadius = config.cornerRadius
        layer.borderWidth = config.borderWidth
        layer.borderColor = config.borderColor.cgColor
        clipsToBounds = true
        borderStyle = .roundedRect
    }

    @objc private func textFieldDidBeginEditing(_ textField: UITextField) {
        applyConfiguration(focusConfig)
    }

    @objc private func textFieldDidEndEditing(_ textField: UITextField) {
        applyConfiguration(normalConfig)
    }
}

protocol TextFieldConfiguration {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var font: UIFont { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var borderColor: UIColor { get }
}

struct TextFieldNormalConfiguration: TextFieldConfiguration {
    let backgroundColor: UIColor = .white
    let textColor: UIColor = .black
    let font: UIFont = .systemFont(ofSize: 16)
    let cornerRadius: CGFloat = 8
    let borderWidth: CGFloat = 1
    let borderColor: UIColor = .gray
}

struct TextFieldFocusConfiguration: TextFieldConfiguration {
    let backgroundColor: UIColor = .white
    let textColor: UIColor = .blue
    let font: UIFont = .systemFont(ofSize: 16)
    let cornerRadius: CGFloat = 8
    let borderWidth: CGFloat = 2
    let borderColor: UIColor = .blue
}



