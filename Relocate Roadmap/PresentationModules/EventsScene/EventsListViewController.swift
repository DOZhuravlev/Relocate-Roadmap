//
//  EventsViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 25.09.2023.
//

import UIKit
import FirebaseAuth

final class EventsListViewController: UIViewController {

    enum Section {
        case eventCategory([EventCategory])
        case event([EventMock])

        var count: Int {
            switch self {
            case .eventCategory(let eventCategories):
                return eventCategories.count
            case .event(let events):
                return events.count
            }
        }
    }

    private var sections: [Section] = [
        .eventCategory([EventCategory(image: UIImage(named: "onboarding"), peoples: 5),
                        EventCategory(image: UIImage(named: "onboarding"), peoples: 5),
                        EventCategory(image: UIImage(named: "onboarding"), peoples: 5),
                        EventCategory(image: UIImage(named: "onboarding"), peoples: 5),
                        EventCategory(image: UIImage(named: "onboarding"), peoples: 5),
                        EventCategory(image: UIImage(named: "onboarding"), peoples: 5)]),
        .event([EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен в тени ааа", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера"),
                EventMock(image: UIImage(named: "onboarding"), category: "Кино", description: "Собираю всех на фильма спайдер мен", date: "завтра в 10:00 вечера")
               ])
    ]

    //MARK: - Outlets

    private lazy var collectionView: UICollectionView = {

        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FirstCell.self, forCellWithReuseIdentifier: FirstCell.identifier)
        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: SecondCell.identifier)
        collectionView.register(AddEventCell.self, forCellWithReuseIdentifier: AddEventCell.identifier)
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
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LOG OUT", style: .plain, target: self, action: #selector(signOut))
    }

    //MARK: - Setup

    @objc private func signOut() {
        let ac = UIAlertController(title: nil, message: "Want to exit?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { _ in
            do {
                try Auth.auth().signOut()
                // ДОБАВИТЬ ПЕРЕХОД НА ЭТАП АВТОРИЗАЦИИ(в координаторе)
            } catch {
                print("ERROR \(error.localizedDescription)")
            }
        }))
        present(ac, animated: true)
    }

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
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            let groupSize: NSCollectionLayoutSize
            let orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior

            if section == 0 {
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(100),
                    heightDimension: .absolute(100)
                )
                orthogonalScrollingBehavior = .continuous
            } else {
                groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(80)
                )
                orthogonalScrollingBehavior = .none
            }
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

extension EventsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let section = sections[indexPath.section]
        switch section {
        case .eventCategory(let eventCategory):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstCell.identifier, for: indexPath) as! FirstCell
            let category = eventCategory[indexPath.item]
                cell.configuration(model: category)
            return cell
        case .event(let event):
            let event = event[indexPath.item]


            if indexPath.item == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddEventCell.identifier, for: indexPath) as! AddEventCell
                cell.configuration()
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCell.identifier, for: indexPath) as! SecondCell
                cell.configuration(model: event)
                return cell
            }

        }
    }

}
