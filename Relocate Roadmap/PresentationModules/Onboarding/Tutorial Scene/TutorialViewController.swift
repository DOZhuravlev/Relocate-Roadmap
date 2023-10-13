//
//  TutorialViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.08.2023.
//

import UIKit
import SnapKit

final class TutorialViewController: UIViewController, FlowController {

    var completionHandler: ((String?) -> ())?

    // MARK: - Outlets

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboarding1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.font = CustomFonts.MontserratBold.font(size: 24)
        label.textColor = Colors.backgroundWhite
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Приложение поможет вам релоцироваться в другие страны и легко адаптироваться в новой среде."
        label.font = CustomFonts.MontserratSemiBold.font(size: 20)
        label.textColor = Colors.backgroundWhite
        label.textAlignment = .center
        label.highlightedTextColor = .black
        label.numberOfLines = 0
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.shadowColor = Colors.backgroundGray
        return label
    }()

    private lazy var startButton: CustomButton = {
        let button = CustomButton(title: "SECOND", type: .secondary, state: .standard, size: .medium) { [weak self] in
            self!.completionHandler?("!!!!!!!!!!")
        
        }
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Setup

    private func setupSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(startButton)
    }

    // MARK: - Layout

    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }

        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
}

