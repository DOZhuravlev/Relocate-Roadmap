//
//  ProfileRegistrationViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 04.08.2023.
//

import UIKit
import FirebaseAuth

final class SetupProfileRegistrationViewController: UIViewController, FlowController {

    // MARK: - Properties

    private var viewModel: SetupProfileRegistrationViewModelProtocol
    private var coordinator: Coordinator
    var completionHandler: ((User?) -> ())?

    // MARK: - Outlets

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratBold.font(size: 24)
        label.text = "Настройте ваш профиль!"
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 10
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
        label.font = CustomFonts.MontserratBold.font(size: 14)
        label.text = "Имя"
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratBold.font(size: 14)
        label.text = "О себе"
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let genderLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratBold.font(size: 14)
        label.text = "Пол"
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
        let button = CustomButton(title: "Зарегистрироваться", type: .primary, state: .standard, size: .medium) {
            self.doneButtonPressed()
        }
        return button
    }()

    // MARK: - Init

    init(viewModel: SetupProfileRegistrationViewModelProtocol, coordinator: Coordinator) {
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
        bindViewModel()
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    private func doneButtonPressed() {
        viewModel.saveProfile { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let userApp):
                self.showAlert(title: "Успешно", message: "Приятного пользования!")
            case .failure(let error):
                self.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }

    @objc private func plusButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }

    private func bindViewModel() {

        profileImageView.image = viewModel.defaultProfileImage


        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged)
        aboutMeTextField.addTarget(self, action: #selector(aboutMeTextFieldDidChange(_:)), for: .editingChanged)
        genderSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)


    }

    @objc private func nameTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.userName = text
        }
    }

    @objc private func aboutMeTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            viewModel.description = text
        }
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        if selectedIndex >= 0 && selectedIndex < sender.numberOfSegments {
            let selectedGender = sender.titleForSegment(at: selectedIndex)
            if let gender = selectedGender {
                viewModel.gender = gender
            }
        }
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
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.centerX.equalTo(view)
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.height.width.equalTo(100)
        }

        plusButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.height.width.equalTo(20)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(plusButton.snp.bottom).offset(10)
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
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
}

extension SetupProfileRegistrationViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        viewModel.defaultProfileImage = image
        bindViewModel()

    }
}
