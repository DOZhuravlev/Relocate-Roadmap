//
//  ProfileRegistrationViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 04.08.2023.
//

import UIKit
import FirebaseAuth

final class ProfileRegistrationViewController: UIViewController {

    // MARK: - Properties

    private var viewModel: ProfileRegistrationViewModelProtocol!
    var coordinator: AppCoordinator

    // MARK: - Outlets

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratBold.font(size: 24)
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
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let aboutMeLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratBold.font(size: 14)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let genderLabel: UILabel = {
        let label = UILabel()
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

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratBold.font(size: 14)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private let ageSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor(red: 0, green: 0.81, blue: 0.79, alpha: 1)
        return slider
    }()

    private let ageValueLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratBold.font(size: 14)
        label.textColor = Colors.textBlack
        label.textAlignment = .center
        return label
    }()

    private lazy var doneButton: CustomButton = {
        let button = CustomButton(title: "Зарегистрироваться", type: .primary, state: .standard, size: .medium) {
            self.goToTheNextScreen()
        }
        return button
    }()

    // MARK: - Init

    init(viewModel: ProfileRegistrationViewModelProtocol, coordinator: AppCoordinator) {
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
      //  viewModel = ProfileRegistrationViewModel()
        
        setupViews()
        setupConstraints()
        setupSlider()
        updateAgeValueLabel()
        bindViewModel()
    }

    // MARK: - Actions

    private func goToTheNextScreen() {
        let nextVC = ChoosingRelocationOptionViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    private func setupSlider() {
        ageSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }

    @objc private func sliderValueChanged() {
        updateAgeValueLabel()
    }

    private func updateAgeValueLabel() {
        let age = Int(ageSlider.value)
        ageValueLabel.text = "\(age)"
    }

    private func doneButtonPressed() {
        guard let userName = nameTextField.text,
              let description = aboutMeTextField.text else { return }
        let gender = genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex) ?? ""
        let age = ageSlider.value

        viewModel.saveProfile(userName: userName, description: description, gender: gender, age: age) { result in
            switch result {
            case .success(let userTravel):
                self.showAlert(title: "Регистрация", message: "Вы зарегистрированы!")
                print(userTravel)
            case .failure(let error):
                self.showAlert(title: "Ошибка", message: error.localizedDescription)
            }
        }
    }

    private func bindViewModel() {
        welcomeLabel.text = viewModel.welcomeLabelText
        profileImageView.image = viewModel.defaultProfileImage
        nameLabel.text = viewModel.nameLabelText
        aboutMeLabel.text = viewModel.aboutMeLabelText
        genderLabel.text = viewModel.genderLabelText
        ageLabel.text = viewModel.ageLabelText
        ageSlider.minimumValue = viewModel.ageSliderMinimumValue
        ageSlider.maximumValue = viewModel.ageSliderMaximumValue
        ageSlider.value = viewModel.ageSliderDefaultValue
        ageValueLabel.text = viewModel.ageValueLabelText
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
        view.addSubview(ageLabel)
        view.addSubview(ageSlider)
        view.addSubview(ageValueLabel)
        view.addSubview(doneButton)
    }

    // MARK: - Layout

    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
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

        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(30)
        }

        ageValueLabel.snp.makeConstraints { make in
            make.top.equalTo(genderSegmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(ageLabel.snp.trailing).offset(30)
        }

        ageSlider.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
        }

        doneButton.snp.makeConstraints { make in
            make.top.equalTo(ageSlider.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
}

extension ProfileRegistrationViewController {

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
