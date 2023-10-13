//
//  AddEventCell.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.09.2023.
//

import UIKit

class AddEventCell: UICollectionViewCell {

    static let identifier = "addCell"

    // MARK: - Outlets

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return image
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupHierarchy() {
        addSubview(image)
        addSubview(nameLabel)
    }

    private func setupLayout() {
        image.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.leading.top.equalTo(contentView)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(image.snp.trailing).offset(30)
            make.top.equalTo(contentView).offset(30)
        }





    }

    func configuration() {
        image.image = UIImage(named: "iconSend")
        nameLabel.text = "Добавить событие"

    }

    override func prepareForReuse() {
        self.image.image = nil
    }

}


