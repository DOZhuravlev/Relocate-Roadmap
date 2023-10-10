//
//  EventListCategoryViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 29.09.2023.
//

import Foundation
import UIKit

final class EventListCategoryViewController: UIViewController {

    private var events: [EventMock] =
        [EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен в тени ааа", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера")
               ]

    //MARK: - Outlets

    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: SecondCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()


    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupHierarchy()
        setupLayout()
        navigationController?.navigationBar.isHidden = true
    }


    //MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(collectionView)

    }

    private func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(view)
        }

    }
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { section, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize: NSCollectionLayoutSize
            let orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior

                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(80)
                )
                orthogonalScrollingBehavior = .none

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = orthogonalScrollingBehavior
            return section
        }
    }
}

extension EventListCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let event = events[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCell.identifier, for: indexPath) as! SecondCell
        cell.configuration(model: event)
        return cell
    }
}

