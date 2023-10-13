//
//  RegistrationViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.07.2023.
//

import UIKit
import FirebaseAuth

final class RegistrationViewController: UIViewController, FlowController {

    // MARK: - Properties

    private var viewModel: RegistrationViewModelProtocol
    private var coordinator: Coordinator
    var completionHandler: ((User?) -> ())?

    // MARK: - Outlets

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = CustomFonts.MontserratBold.font(size: 24)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private lazy var loginWithMailButton: CustomButton = {
        let button = CustomButton(title: "Войти через почту", type: .secondary, state: .standard, size: .medium) { [weak self] in
            //TODO: переход
        }
        return button
    }()


    private lazy var loginWithGoogleButton: CustomButton = {
        let button = CustomButton(title: "Войти через Google", type: .secondary, state: .standard, size: .medium) {
            //TODO: переход
        }
        return button
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Подтвердите пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    private let showHidePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye_closed"), for: .normal)
        button.setImage(UIImage(named: "eye_open"), for: .selected)
        return button
    }()

    private let showHideConfirmPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye_closed"), for: .normal)
        button.setImage(UIImage(named: "eye_open"), for: .selected)
        return button
    }()

    private lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "Зарегистрироваться", type: .primary, state: .standard, size: .medium) { [weak self] in
            guard let self else { return }
            self.registration()


        }
        return button
    }()

    // MARK: - Init

    init(viewModel: RegistrationViewModelProtocol, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupShowHidePasswordButton()
        setupShowHideConfirmPasswordButton()
        bindViewModel()

        registerButton.delegate = self
    }

    // MARK: - Actions

    private func setupShowHidePasswordButton() {
        showHidePasswordButton.addTarget(self, action: #selector(showHidePasswordButtonTapped), for: .touchUpInside)
    }

    private func setupShowHideConfirmPasswordButton() {
        showHideConfirmPasswordButton.addTarget(self, action: #selector(showHideConfirmPasswordButtonTapped), for: .touchUpInside)
    }

    @objc private func showHidePasswordButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        showHidePasswordButton.isSelected = !passwordTextField.isSecureTextEntry
    }

    @objc private func showHideConfirmPasswordButtonTapped() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        showHideConfirmPasswordButton.isSelected = !confirmPasswordTextField.isSecureTextEntry
    }

    private func registration() {
        viewModel.registration { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                self.showAlert(title: "Регистрация", message: "Вы зарегистрированы!")
                self.completionHandler?(user)
            case .failure(let error):
                self.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }

    func bindViewModel() {

        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextFieldDidChange(_:)), for: .editingChanged)

    }

    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.login = text
        }
    }

    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.password = text
        }
    }

    @objc private func confirmPasswordTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.confirmPassword = text
        }
    }

    // MARK: - Setup

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(loginWithMailButton)
        view.addSubview(loginWithGoogleButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(showHidePasswordButton)
        view.addSubview(showHideConfirmPasswordButton)
        view.addSubview(registerButton)
    }

    // MARK: - Layout

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalToSuperview().offset(20)
        }

        loginWithMailButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }

        loginWithGoogleButton.snp.makeConstraints { make in
            make.top.equalTo(loginWithMailButton.snp.bottom).offset(10)
            make.leading.trailing.height.equalTo(loginWithMailButton)
        }

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(loginWithGoogleButton.snp.bottom).offset(30)
            make.leading.trailing.equalTo(loginWithMailButton)
            make.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(loginWithMailButton)
            make.height.equalTo(40)
        }

        showHidePasswordButton.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField.snp.trailing).offset(-40)
            make.centerY.equalTo(passwordTextField)
            make.width.height.equalTo(30)
        }

        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(loginWithMailButton)
            make.height.equalTo(40)
        }

        showHideConfirmPasswordButton.snp.makeConstraints { make in
            make.leading.equalTo(confirmPasswordTextField.snp.trailing).offset(-40)
            make.centerY.equalTo(confirmPasswordTextField)
            make.width.height.equalTo(30)
        }

        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(30)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
}

extension RegistrationViewController: CustomButtonDelegate {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
