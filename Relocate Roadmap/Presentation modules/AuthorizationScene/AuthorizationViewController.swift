//
//  AuthenticationViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.07.2023.
//
//
import UIKit
import SnapKit

final class AuthorizationViewController: UIViewController {

    // MARK: - Outlets

    private let topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "traveller")
        return imageView
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "План вашей релокации"
        label.font = CustomFonts.MontserratBold.font(size: 18)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

   private lazy var registrationButton: CustomButton = {
        let button = CustomButton(title: "Зарегистрироваться", type: .primary, state: .standard, size: .medium) { [weak self] in
            let nextVC = RegistrationViewController()
            self?.navigationController?.pushViewController(nextVC, animated: true)
        }
        return button
    }()

    private lazy var authorizationButton: CustomButton = {
        let  button = CustomButton(title: "Войти", type: .secondary, state: .standard, size: .medium, action: { [weak self] in
                let nextVC = RegistrationViewController()
                self?.navigationController?.pushViewController(LoginViewController(), animated: true)
        })
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Setup

    private func setupSubviews() {
        view.addSubview(topImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(registrationButton)
        view.addSubview(authorizationButton)
    }

    // MARK: - Layout

    private func setupConstraints() {
        topImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(300)
        }

        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(topImageView.snp.bottom).offset(70)
        }

        registrationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeLabel.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }

        authorizationButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registrationButton.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
}

