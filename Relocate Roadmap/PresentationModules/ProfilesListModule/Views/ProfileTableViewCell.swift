//
//  ProfileTableViewCell.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 27.07.2023.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {


    // MARK: - Cell Components

        let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        let nameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        // MARK: - Initialization

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            setupUI()
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

      

        // MARK: - Configuration

        func configure(with profileImage: UIImage?, name: String, description: String) {
            profileImageView.image = profileImage
            nameLabel.text = name
            descriptionLabel.text = description
        }

        // MARK: - UI Setup

        func setupUI() {
            contentView.addSubview(profileImageView)
            contentView.addSubview(nameLabel)
            contentView.addSubview(descriptionLabel)

            // Set up constraints for the cell components
            NSLayoutConstraint.activate([
                profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                profileImageView.widthAnchor.constraint(equalToConstant: 80),
                profileImageView.heightAnchor.constraint(equalToConstant: 80),

                nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
                nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

                descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            ])
        }
    }

