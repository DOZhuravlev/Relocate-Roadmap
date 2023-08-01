//
//  NextVC.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 25.07.2023.
//

import UIKit

final class NextVC: UIViewController {

    private let countries = ["Россия", "Грузия", "Турция", "Сербия"]
    private let minAge = 18
    private let maxAge = 70

    private let pickerCountryView = UIPickerView()
    private let ageSlider = CustomSlider()

    private let habitationSwitch = UISwitch()
    private let leisureSwitch = UISwitch()

    private let fromAgeLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratRegular.font(size: 18)
        label.textColor = Colors.textBlack
        return label
    }()

    private let toAgeLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratRegular.font(size: 18)
        label.textColor = Colors.textBlack
        return label
    }()

    private let choiceLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите параметры поиска:"
        label.font = CustomFonts.PoppinsBold.font(size: 20)
        label.textColor = Colors.textBlack
        return label
    }()

    private let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Страна:"
        label.font = CustomFonts.MontserratRegular.font(size: 18)
        label.textColor = Colors.textBlack
        return label
    }()

    private let ageNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Возраст:"
        label.font = CustomFonts.MontserratRegular.font(size: 18)
        label.textColor = Colors.textBlack
        return label
    }()

    private let ageToLabel: UILabel = {
        let label = UILabel()
        label.text = "До:"
        label.font = CustomFonts.MontserratRegular.font(size: 18)
        label.textColor = Colors.textBlack
        return label
    }()

    private let ageFromLabel: UILabel = {
        let label = UILabel()
        label.text = "От:"
        label.font = CustomFonts.MontserratRegular.font(size: 18)
        label.textColor = Colors.textBlack
        return label
    }()

    private let habitationLabel: UILabel = {
        let label = UILabel()
        label.text = "Совместное проживание:"
        label.font = CustomFonts.MontserratRegular.font(size: 18)
        label.textColor = Colors.textBlack
        label.numberOfLines = 0
        return label
    }()

    private let leisureLabel: UILabel = {
        let label = UILabel()
        label.text = "Совместный досуг:"
        label.font = CustomFonts.MontserratRegular.font(size: 18)
        label.textColor = Colors.textBlack
        return label
    }()

    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("ПОИСК", for: .normal)
        button.tintColor = .red
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupSubviews()
        setupLayout()
        setupSlider()
        updateLabels()

        pickerCountryView.delegate = self
        pickerCountryView.dataSource = self

        ageSlider.lowerValue = CGFloat(minAge)
        ageSlider.upperValue = CGFloat(maxAge)

        fromAgeLabel.text = "\(minAge) лет"
        toAgeLabel.text = "\(maxAge) лет"

        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)

        habitationSwitch.isOn = true
        leisureSwitch.isOn = true

        habitationSwitch.addTarget(self, action: #selector(habitationSwitchValueChanged), for: .valueChanged)
        leisureSwitch.addTarget(self, action: #selector(leisureSwitchValueChanged), for: .valueChanged)


    }
    
    // MARK: - Setup

    private func setupSubviews() {
        view.addSubview(choiceLabel)
        view.addSubview(pickerCountryView)
        view.addSubview(countryLabel)
        view.addSubview(ageNameLabel)
        view.addSubview(ageFromLabel)
        view.addSubview(ageToLabel)
        view.addSubview(pickerCountryView)
        view.addSubview(ageSlider)
        view.addSubview(fromAgeLabel)
        view.addSubview(toAgeLabel)
        view.addSubview(habitationLabel)
        view.addSubview(habitationSwitch)
        view.addSubview(leisureLabel)
        view.addSubview(leisureSwitch)
        view.addSubview(searchButton)

    }

    private func setupBehavior() {


    }

    @objc private func findPartnerImageViewTapped() {

    }

    @objc private func search() {
        print("SEARCH START")

        let nextVC = ChoosePartnerViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    private func setupSlider() {
        ageSlider.minimumValue = CGFloat(minAge)
        ageSlider.maximumValue = CGFloat(maxAge)
        ageSlider.trackTintColor = Colors.textBlack
        ageSlider.thumbTintColor = .red
        ageSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }

    private func setupLabel(_ label: UILabel) {
        fromAgeLabel.textAlignment = .center
        fromAgeLabel.font = CustomFonts.MontserratRegular.font(size: 16)
        fromAgeLabel.textColor = Colors.textBlack
    }

    @objc private func sliderValueChanged() {
          updateLabels()
      }

    private func updateLabels() {
          let fromAge = Int(ageSlider.lowerValue)
          let toAge = Int(ageSlider.upperValue)
          fromAgeLabel.text = "\(fromAge) лет"
          toAgeLabel.text = "\(toAge) лет"
      }

    @objc private func habitationSwitchValueChanged() {
        print("habitationSwitchValueChanged CHANGED")
    }

    @objc private func leisureSwitchValueChanged() {
        print("leisureSwitchValueChanged CHANGED")
    }


    private func setupLayout() {
        choiceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
        }

        countryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(choiceLabel.snp.bottom).offset(10)
        }

        pickerCountryView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(countryLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
            make.height.equalTo(200)
        }

        ageNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(pickerCountryView.snp.bottom).offset(5)
        }

        ageSlider.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
            make.height.equalTo(30)
            make.top.equalTo(ageNameLabel.snp.bottom).offset(5)

        }

        fromAgeLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageSlider.snp.leading)
            make.top.equalTo(ageSlider.snp.bottom).offset(10)
            make.width.equalTo(80)
        }
        toAgeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(ageSlider.snp.trailing).offset(20)
            make.top.equalTo(ageSlider.snp.bottom).offset(10)
            make.width.equalTo(80)
        }

        habitationLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageSlider.snp.leading).offset(0)
            make.top.equalTo(fromAgeLabel.snp.bottom).offset(10)
        }

        habitationSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(ageSlider.snp.trailing).offset(0)
            make.top.equalTo(toAgeLabel.snp.bottom).offset(10)
            make.leading.equalTo(habitationLabel.snp.trailing).inset(5)
        }

        leisureLabel.snp.makeConstraints { make in
            make.leading.equalTo(ageSlider.snp.leading).offset(0)
            make.top.equalTo(habitationLabel.snp.bottom).offset(10)
        }

        leisureSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(ageSlider.snp.trailing).offset(0)
            make.top.equalTo(habitationSwitch.snp.bottom).offset(10)
            make.leading.equalTo(habitationLabel.snp.trailing).inset(5)
        }

        searchButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(leisureLabel.snp.bottom).offset(30)
            make.width.equalTo(200)
        }




//        view.addSubview(habitationLabel)
//        view.addSubview(habitationSwitch)
//        view.addSubview(leisureLabel)
//        view.addSubview(leisureSwitch)
    }

}

extension NextVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(countries[row])
    }
}

