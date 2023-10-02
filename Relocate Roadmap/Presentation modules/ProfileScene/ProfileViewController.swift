//
//  ProfileViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.09.2023.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {


    //MARK: - Outlets

    private let imageProfile: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        label.text = "ABRAKADABRA"
        return label
    }()

    private let aboutUserLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        label.text = "Занимаюсь тусовками и спортом и танцами"
        return label
    }()

    private let followersLabel: UILabel = {
           let label = UILabel()
           label.text = "100\nПодписчиков" // Замените на количество подписчиков
           label.numberOfLines = 2
           label.textAlignment = .center
           return label
       }()

       private let followingLabel: UILabel = {
           let label = UILabel()
           label.text = "50\nПодписки" // Замените на количество подписок
           label.numberOfLines = 2
           label.textAlignment = .center
           return label
       }()

    private let subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подписаться", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()

    private let messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сообщение", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()

    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - Lifecycle

       override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .white
           setupUI()

           imageProfile.image = UIImage(named: "1")
       }

    private func setupUI() {
        view.addSubview(imageProfile)
        view.addSubview(usernameLabel)
        view.addSubview(followersLabel)
        view.addSubview(followingLabel)
        view.addSubview(aboutUserLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(subscribeButton)
        buttonStackView.addArrangedSubview(messageButton)

        imageProfile.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.size.equalTo(100)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }

        followersLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.centerX.equalTo(view)
        }

        followingLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(50)
            make.leading.equalTo(followersLabel.snp.trailing).offset(20)
        }

        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageProfile.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }

        aboutUserLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(20)
        }

        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(aboutUserLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(40)
        }


    }


}

