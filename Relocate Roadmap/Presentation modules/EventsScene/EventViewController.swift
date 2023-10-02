//
//  EventViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.09.2023.
//

import Foundation
import UIKit

final class EventViewController: UIViewController {

    //MARK: - Outlets

    private let imageProfile: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()

    private var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        return stackView
    }()


    private var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Пойду", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()

    private var chatButton: UIButton = {
        let button = UIButton()
        button.setTitle("ЧАТ", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()

    private var membersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Участники", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        categoryLabel.text = "Тусовка"
        descriptionLabel.text = "Потусить в Бла бар"
        dateLabel.text = "пятница 29.09"
        locationLabel.text = "Екатеринбург ул. Добролюбова дом такой то и тд"
        imageProfile.image = UIImage(named: "1")

    }

    //MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(imageProfile)
        view.addSubview(labelStackView)
        labelStackView.addArrangedSubview(categoryLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        labelStackView.addArrangedSubview(dateLabel)
        labelStackView.addArrangedSubview(locationLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(registrationButton)
        buttonStackView.addArrangedSubview(chatButton)
        buttonStackView.addArrangedSubview(membersButton)

    }
    private func setupLayout() {
        imageProfile.snp.makeConstraints { make in
            make.leading.top.equalTo(view).offset(30)
            make.height.width.equalTo(70)
        }

        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageProfile.snp.trailing).offset(10)
            make.top.equalTo(view).offset(30)
            make.trailing.equalTo(view)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(10)
            make.height.equalTo(200)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-10)
        }







    }
}
