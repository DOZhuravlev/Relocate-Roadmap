//
//  OnboardingViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.07.2023.
//

import UIKit
import SnapKit

final class WelcomeViewController: UIViewController, FlowController {

    // MARK: - Properties

    private var viewModel: WelcomeViewModelProtocol
    private var coordinator: Coordinator
    var completionHandler: ((String?) -> ())?

    // MARK: - Outlets

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFonts.MontserratBold.font(size: 24)
        label.textColor = Colors.backgroundWhite
        label.textAlignment = .center
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
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
        let button = CustomButton(title: "Начать", type: .secondary, state: .standard, size: .medium) { [weak self] in
            guard let self = self else { return }
            self.completionHandler?("!!!!!!!!!!")
//            let nextVC = AuthorizationViewController()
//            self?.navigationController?.pushViewController(AuthorizationViewController(), animated: true)
        }
        return button
    }()

    // MARK: - Init

    init(viewModel: WelcomeViewModelProtocol, coordinator: Coordinator) {
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
        setupSubviews()
        setupConstraints()
        bindViewModel()
    }

    // MARK: - Actions

    private func bindViewModel() {
        backgroundImageView.image = viewModel.backgroundImage
        welcomeLabel.text = viewModel.welcomeLabelText
        descriptionLabel.text = viewModel.descriptionLabelText
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
