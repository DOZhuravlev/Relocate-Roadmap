//
//  ProfileRegistrationViewModel.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 07.08.2023.
//

import Foundation
import UIKit
import FirebaseAuth

protocol ProfileRegistrationViewModelProtocol: AnyObject {
    var welcomeLabelText: String { get }
    var defaultProfileImage: UIImage? { get }
    var nameLabelText: String { get }
    var aboutMeLabelText: String { get }
    var genderLabelText: String { get }
    var ageLabelText: String { get }
    var ageSliderMinimumValue: Float { get }
    var ageSliderMaximumValue: Float { get }
    var ageSliderDefaultValue: Float { get }
    var ageValueLabelText: String { get }

    func saveProfile(userName: String, description: String, gender: String, completion: @escaping (Result<UserApp, Error>) -> Void)

}

final class ProfileRegistrationViewModel: ProfileRegistrationViewModelProtocol {

    private var currentUser: User

    init(currentUser: User) {
        self.currentUser = currentUser
    }


    func fetchCurrentUser() {
        if let currentUser = Auth.auth().currentUser {
            self.currentUser = currentUser
        } else {
            // Обработка ситуации, когда пользователь не вошел в систему
            // Можно выполнить перенаправление на экран входа в систему
        }

    }

        var welcomeLabelText: String {
            return "Настройте ваш профиль!"
        }

        var defaultProfileImage: UIImage? {
            return UIImage(named: "1")
        }

        var nameLabelText: String {
            return "Имя"
        }

        var aboutMeLabelText: String {
            return "О себе"
        }

        var genderLabelText: String {
            return "Пол"
        }

        var ageLabelText: String {
            return "Возраст"
        }

        var ageSliderMinimumValue: Float {
            return 18
        }

        var ageSliderMaximumValue: Float {
            return 70
        }

        var ageSliderDefaultValue: Float {
            return 35
        }

        var ageValueLabelText: String {
            return "\(Int(ageSliderDefaultValue))"
        }

        func saveProfile(userName: String, description: String, gender: String, completion: @escaping (Result<UserApp, Error>) -> Void) {
            FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                    email: currentUser.email!,
                                                    userName: userName,
                                                    avatarImageString: "nil",
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

