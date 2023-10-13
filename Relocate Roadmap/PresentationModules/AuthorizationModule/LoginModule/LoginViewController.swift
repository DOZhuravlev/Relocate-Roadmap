//
//  LoginViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.07.2023.
//

import UIKit


final class LoginViewController: UIViewController, FlowController {

    // MARK: - Properties

    private var viewModel: LoginViewModelProtocol
    private var coordinator: Coordinator
    var completionHandler: ((String?) -> ())?

    // MARK: - Outlets

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = CustomFonts.MontserratBold.font(size: 24)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let loginButton: CustomButton = {
        let button = CustomButton(title: "Войти через почту", type: .secondary, state: .standard, size: .medium) {
            //TODO: переход
        }
        return button
    }()

    private let signupButton: CustomButton = {
        let button = CustomButton(title: "Войти через Google", type: .secondary, state: .standard, size: .medium) {
            //TODO: переход
        }
        return button
    }()

    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
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

    private let showHideButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye_closed"), for: .normal)
        button.setImage(UIImage(named: "eye_open"), for: .selected)
        return button
    }()

    private let forgotPasswordButton: CustomButton = {
        let button = CustomButton(title: "Забыли пароль?", type: .help, state: .standard, size: .small) {
            //TODO: переход
        }
        return button
    }()

    private lazy var enterButton: CustomButton = {
        let button = CustomButton(title: "Войти", type: .primary, state: .standard, size: .medium) {
            //self.authorization()
            self.viewModel.authorization(findUserCompletion: { [weak self] success in
                if success {
                    print("Успешно авторизован")
                    // вызываем иф елс авторизация(в ней комлишн координатора)
                } else {
                    print("Ошибка авторизации")
                    // здесь комплишн для координатора для перехода на настройку профиля
                    self?.showAlert(title: "Ошибка", message: "Логин или пароль неверные")
                }
            }, failureCompletion: { error in
                self.showAlert(title: "Ошибка", message: error.localizedDescription)
            })
        }
        return button
    }()



    private let noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас нет аккаунта?"
        label.font = CustomFonts.MontserratBold.font(size: 12)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private lazy var registerButton: CustomButton = {
        let button = CustomButton(title: "Зарегистрироваться", type: .help, state: .standard, size: .small) {
//            let nextVC = RegistrationViewController()
//            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        return button
    }()

    // MARK: - Init

    init(viewModel: LoginViewModelProtocol, coordinator: Coordinator) {
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
            setupShowHideButton()
            setupConstraints()
            bindViewModel()
            enterButton.delegate = self

        }

    // MARK: - Actions

    private func setupShowHideButton() {
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
    }

    @objc private func showHideButtonTapped() {
        passwordTextField.isSecureTextEntry.toggle()
        showHideButton.isSelected = !passwordTextField.isSecureTextEntry
    }

    @objc func registerButtonPressed() {
//        let nextVC = ChoosingRelocationOptionViewController()
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    func bindViewModel() {

        loginTextField.addTarget(self, action: #selector(loginTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)

    }

    @objc private func loginTextFieldDidChange(_ textField: UITextField) {
            if let text = textField.text {
                viewModel.login = text
            }
        }

    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.password = text
        }
    }

    // MARK: - Setup

        private func setupViews() {
            view.backgroundColor = .white
            view.addSubview(titleLabel)
            view.addSubview(loginButton)
            view.addSubview(signupButton)
            view.addSubview(loginTextField)
            view.addSubview(passwordTextField)
            view.addSubview(showHideButton)
            view.addSubview(forgotPasswordButton)
            view.addSubview(enterButton)
            view.addSubview(noAccountLabel)
            view.addSubview(registerButton)
        }

    // MARK: - Layout

        private func setupConstraints() {
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
                make.leading.equalToSuperview().offset(20)
            }

            loginButton.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.height.equalTo(40)
            }

            signupButton.snp.makeConstraints { make in
                make.top.equalTo(loginButton.snp.bottom).offset(10)
                make.leading.trailing.height.equalTo(loginButton)
            }

            loginTextField.snp.makeConstraints { make in
                make.top.equalTo(signupButton.snp.bottom).offset(30)
                make.leading.trailing.equalTo(loginButton)
                make.height.equalTo(40)
            }

            passwordTextField.snp.makeConstraints { make in
                make.top.equalTo(loginTextField.snp.bottom).offset(10)
                make.leading.trailing.equalTo(loginButton)
                make.height.equalTo(40)
            }

            showHideButton.snp.makeConstraints { make in
                make.leading.equalTo(passwordTextField.snp.trailing).offset(-40)
                make.centerY.equalTo(passwordTextField)
                make.width.height.equalTo(30)
            }

            forgotPasswordButton.snp.makeConstraints { make in
                make.top.equalTo(passwordTextField.snp.bottom).offset(10)
                make.trailing.equalTo(loginButton)
            }

            enterButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
                make.width.equalTo(150)
                make.height.equalTo(40)
            }

            noAccountLabel.snp.makeConstraints { make in
                make.leading.equalTo(view.snp.leading).offset(40)
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            }

            registerButton.snp.makeConstraints { make in
                make.leading.equalTo(noAccountLabel.snp.trailing).offset(60)
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            }
        }

}

extension LoginViewController: CustomButtonDelegate {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
