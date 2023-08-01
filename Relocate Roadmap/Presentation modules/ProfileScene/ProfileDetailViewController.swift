//
//  ProfileDetailViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 27.07.2023.
//

import UIKit
import SnapKit

class ProfileDetailViewController: UIViewController {

    // MARK: - Properties

    var profile: Profile?

    // MARK: - UI Components

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let chatButton: UIButton = {
        let button = UIButton()
        button.setTitle("Чат", for: .normal)
        button.tintColor = .red
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        return button
    }()


    let bbb = CustomButton(title: "Google", type: .primary, state: .standard, size: .medium) {
        print("Aa")
        
    }


    

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        populateData()
        chatButton.addTarget(self, action: #selector(chatButtonPressed), for: .touchUpInside)
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(profileImageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(chatButton)
        scrollView.addSubview(bbb)

        // Set up constraints using SnapKit
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
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }

        bbb.snp.makeConstraints { make in
            make.top.equalTo(chatButton.snp.bottom).offset(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }


    }

    // MARK: - Data Population

    private func populateData() {
        guard let profile = profile else { return }
        profileImageView.image = profile.image
        nameLabel.text = profile.name
        descriptionLabel.text = profile.description
    }

    @objc func chatButtonPressed() {
        let vc = ChatViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
