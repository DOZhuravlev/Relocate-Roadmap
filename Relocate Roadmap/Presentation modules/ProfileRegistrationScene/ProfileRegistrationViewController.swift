//
//  ProfileRegistrationViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 04.08.2023.
//

import UIKit

final class ProfileRegistrationViewController: UIViewController {

    // MARK: - Outlets

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройте ваш профиль!"
        label.font = CustomFonts.MontserratBold.font(size: 24)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()

    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let myImage = UIImage(named: "1")
        button.setImage(myImage, for: .normal)
        button.tintColor = .green
        return button
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.font = CustomFonts.MontserratBold.font(size: 14)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.text = "О себе"
        label.font = CustomFonts.MontserratBold.font(size: 14)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Пол"
        label.font = CustomFonts.MontserratBold.font(size: 14)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let aboutMeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "О себе"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let genderSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Мужской", "Женский"])
        segmentedControl.selectedSegmentIndex = 0

        return segmentedControl
    }()

    private lazy var doneButton: CustomButton = {
        let button = CustomButton(title: "Готово", type: .primary, state: .standard, size: .medium) {
            self.goToTheNextScreen()
        }
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()


    }

    // MARK: - Actions

    private func goToTheNextScreen() {
        let nextVC = ChoosingRelocationOptionViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    // MARK: - Setup

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)
        view.addSubview(profileImageView)
        view.addSubview(plusButton)
        view.addSubview(nameLabel)
        view.addSubview(aboutMeLabel)
        view.addSubview(genderLabel)
        view.addSubview(nameTextField)
        view.addSubview(aboutMeTextField)
        view.addSubview(genderSegmentedControl)
        view.addSubview(doneButton)
    }

    // MARK: - Layout

    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(view)
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(30)
            make.centerX.equalTo(view)
            make.height.width.equalTo(100)
        }

        plusButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.height.width.equalTo(20)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(plusButton.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(30)

        }

        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
        }

        aboutMeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(30)
            make.leading.equalTo(view.snp.leading).offset(30)
        }

        aboutMeTextField.snp.makeConstraints { make in
            make.top.equalTo(aboutMeLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
        }

        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(aboutMeTextField.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(30)
        }

        genderSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
        }

        doneButton.snp.makeConstraints { make in
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
}
