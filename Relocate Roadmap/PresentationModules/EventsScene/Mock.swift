//
//  Mock.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 06.10.2023.
//


import Foundation
import UIKit
import FirebaseAuth

final class MockViewController: UIViewController {

    private var userApp: [UserApp] = []
    private var currentUser: UserApp

    init(currentUser: UserApp = UserApp(userName: "A",
                                        email: "A",
                                        avatarStringURL: "A",
                                        description: "A",
                                        gender: "A",
                                        id: "A")) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    func fetchUsers() {
        ListenerService.shared.usersObserve(users: userApp) { result in
            switch result {
            case .success(let a):
                self.userApp = a
                print("adfasdasdasdasdasd\(a)")
                self.collectionView.reloadData()
            case .failure(let error):
                print("aaa \(error.localizedDescription)")
            }
        }
    }

    func fetchUser() {
        if let user = Auth.auth().currentUser {
            FirestoreService.shared.getUserData(user: user) { result in
                switch result {
                case .success(let user):
                    print(user)
                    self.currentUser = user
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }



    //MARK: - Outlets

    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MockCell.self, forCellWithReuseIdentifier: MockCell.identifier)
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
        fetchUser()
        fetchUsers()
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

extension MockViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userApp.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let event = userApp[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MockCell.identifier, for: indexPath) as! MockCell
        cell.configuration(model: event)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = userApp[indexPath.item]

        let message = UserMessage(user: currentUser, content: "HELLO")



        FirestoreService.shared.createChat(message: message, receiver: item) { result in
            switch result {

            case .success():
                print("CREATE CHAAAAAAAATTTT")
                let vc = ChatsListViewController()

                self.present(vc, animated: true)
            case .failure(_):
                print("CДЕЛАТЬ АЛЕРТ ЧТО НЕУДАЕТСЯ СОЗДАТЬ ЧАТ")
            }
        }



        let vc = ChatsListViewController()

        self.present(vc, animated: true)


//
//        FirestoreService.shared.createChatWithUser(message: "1 SMS", receiver: item) { result in
//            switch result {
//
//            case .success(let b):
//                print("YES \(b)")
//                let vc = ChatsListViewController()
//                self.present(vc, animated: true)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }




    }
}
