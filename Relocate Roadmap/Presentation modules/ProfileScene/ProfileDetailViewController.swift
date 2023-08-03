//
//  ProfileDetailViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 27.07.2023.
//

import UIKit
import SnapKit

final class ProfileDetailViewController: UIViewController {

    // MARK: - Properties

    var profile: Profile?

    // MARK: - Outlets

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    private lazy var chatButton: CustomButton = {
        let button = CustomButton(title: "Чат", type: .primary, state: .standard, size: .medium) {
            self.goToTheNextScreen()
        }
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        populateData()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(chatButton)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(200)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }

        chatButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }

    // MARK: - Data Population

    private func populateData() {
        guard let profile = profile else { return }
        profileImageView.image = profile.image
        nameLabel.text = profile.name
        descriptionLabel.text = profile.description
    }

    private func goToTheNextScreen() {
        let vc = ChatViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
