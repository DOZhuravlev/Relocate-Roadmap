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
        label.text = "Выберите:"
        label.font = UIFont(name: "", size: 20)

        return label
    }()

    private let alreadyRelocatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите:"
        label.font = UIFont(name: "Poppins-Bold", size: 30)

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

        //отработка кнопок
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
            make.top.equalTo(view).offset(200)
        }

    }

}

