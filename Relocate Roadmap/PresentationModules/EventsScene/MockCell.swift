//
//  MockCell.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 06.10.2023.
//

import UIKit

class MockCell: UICollectionViewCell {

    static let identifier = "mockCell"

    // MARK: - Outlets

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return image
    }()

    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()

    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    lazy var thirdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()

    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 2


        return stackView

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
        addSubview(stackView)
        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(thirdLabel)
    }

    private func setupLayout() {
        image.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.leading.top.equalTo(contentView)
        }

        stackView.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(5)
            make.top.trailing.bottom.equalTo(contentView)
        }



    }

    func configuration(model: UserApp) {
        firstLabel.text = model.userName
        secondLabel.text = model.email
        thirdLabel.text = model.id
    }

    override func prepareForReuse() {
        self.image.image = nil
    }

}
