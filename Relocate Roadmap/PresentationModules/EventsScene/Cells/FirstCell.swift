//
//  FirstCell.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 27.09.2023.
//

import UIKit

final class FirstCell: UICollectionViewCell {


    static let identifier = "firstCell"

    // MARK: - Outlets

    var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true

        return image
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
        contentView.addSubview(image)

    }

    private func setupLayout() {
        image.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(contentView)

        }

    }

    func configuration(model: EventCategory) {
        image.image = model.image


    }

    override func prepareForReuse() {
        self.image.image = nil
    }

}
