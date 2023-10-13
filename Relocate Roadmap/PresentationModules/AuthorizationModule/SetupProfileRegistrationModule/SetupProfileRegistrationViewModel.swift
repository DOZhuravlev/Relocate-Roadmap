//
//  ProfileRegistrationViewModel.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 07.08.2023.
//

import Foundation
import UIKit
import FirebaseAuth

protocol SetupProfileRegistrationViewModelProtocol: AnyObject {
    var defaultProfileImage: UIImage? { get set }
    var userName: String { get set }
    var description: String { get set }
    var gender: String { get set }

    func saveProfile(completion: @escaping (Result<UserApp, Error>) -> Void)
}

final class SetupProfileRegistrationViewModel: SetupProfileRegistrationViewModelProtocol {

    private var currentUser: User!

    init(currentUser: User) {
        self.currentUser = currentUser
    }

//    func fetchCurrentUser() {
//        if let currentUser = Auth.auth().currentUser {
//            self.currentUser = currentUser
//        } else {
//            // Обработка ситуации, когда пользователь не вошел в систему
//            // Можно выполнить перенаправление на экран входа в систему
//        }
//
//    }


    private var _defaultProfileImage: UIImage? = UIImage(named: "2")

    var defaultProfileImage: UIImage? {
        get {
               return _defaultProfileImage
           }
           set {
               _defaultProfileImage = newValue
           }
    }

    var userName: String = ""
    var description: String = ""
    var gender: String = ""


    func saveProfile(completion: @escaping (Result<UserApp, Error>) -> Void) {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                userName: userName,
                                                avatarImage: defaultProfileImage,
                                                description: description,
                                                gender: gender) { result in
            switch result {
            case .success(let userApp):
                completion(.success(userApp))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

