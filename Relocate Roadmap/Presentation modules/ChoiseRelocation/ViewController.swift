//
//  ViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 25.07.2023.
//

import UIKit 
import SnapKit

final class ViewController: UIViewController {

    // MARK: - Outlets

    private let findPartnerImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.image = UIImage(named: "manyAnimals")
        view.tintColor = .blue
        view.layer.cornerRadius = 10
        return view
    }()

    private let alreadyRelocatedImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.image = UIImage(named: "elephant")
        view.tintColor = .blue
        view.layer.cornerRadius = 10
        return view
    }()

    private let choiceLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите:"
        label.font = CustomFonts.PoppinsBold.font(size: 30)
        label.textColor = Colors.textBlack
        return label
    }()

    private let findPartnerLabel: UILabel = {
        let label = UILabel()
        label.text = "Ищу партнера:"
        label.font = CustomFonts.PoppinsBold.font(size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let alreadyRelocatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Релоцировался:"
        label.font = CustomFonts.PoppinsBold.font(size: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupSubviews()
        setupBehavior()
        setupLayout()
    }

    // MARK: - Setup
    private func setupSubviews() {
        view.addSubview(findPartnerImageView)
        view.addSubview(alreadyRelocatedImageView)

        view.addSubview(choiceLabel)
        view.addSubview(findPartnerLabel)
        view.addSubview(alreadyRelocatedLabel)
    }

    private func setupBehavior() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(findPartnerImageViewTapped))
        findPartnerImageView.isUserInteractionEnabled = true
        findPartnerImageView.addGestureRecognizer(tapGesture)

    }

    @objc private func findPartnerImageViewTapped() {
        let nextVC = NextVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    private func setupLayout() {
        findPartnerImageView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(30)
            make.height.equalTo(150)
            make.width.equalTo(150)
            make.centerY.equalTo(view)
        }

        alreadyRelocatedImageView.snp.makeConstraints { make in
            make.right.equalTo(view).offset(-30)
            make.centerY.equalTo(view)
            make.height.equalTo(150)
            make.width.equalTo(150)
        }

        choiceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }

        findPartnerLabel.snp.makeConstraints { make in
            make.bottom.equalTo(findPartnerImageView.snp.top).offset(-10)
            make.leading.equalTo(findPartnerImageView.snp.leading).offset(0)
            make.trailing.equalTo(findPartnerImageView.snp.trailing).offset(0)

        }

        alreadyRelocatedLabel.snp.makeConstraints { make in
            make.bottom.equalTo(alreadyRelocatedImageView.snp.top).offset(-10)
            make.leading.equalTo(alreadyRelocatedImageView.snp.leading).offset(0)
            make.trailing.equalTo(alreadyRelocatedImageView.snp.trailing).offset(0)
        }



    }

}

