//
//  ChatsListViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 06.10.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

final class ChatsListViewController: UIViewController {


    private var chats = [UserChat]()
    private var chatsListener: ListenerRegistration?
    
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

    deinit {
        chatsListener?.remove()
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
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
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

        navigationController?.navigationBar.isHidden = true
        chatsListener = ListenerService.shared.chatsObserve(chats: chats, completion: { result in
            switch result {
            case .success(let chats):
                // if self.chats != [] - сделать пустой экран когда чатов еще нет
                self.chats = chats
                print("CHAAAAAAAT - \(chats)")
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
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

extension ChatsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        chats.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let chat = chats[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
        cell.configuration(model: chat)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chat = chats[indexPath.item]
        let chatsVC = ChatsViewController(user: currentUser, chat: chat)
        present(chatsVC, animated: true)

    print("ТРЫНЬьььььь")

    }
}
