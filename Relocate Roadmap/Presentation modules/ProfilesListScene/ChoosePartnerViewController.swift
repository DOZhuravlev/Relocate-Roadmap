//
//  ChoisePartnerViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 27.07.2023.
//

import UIKit

final class ChoosePartnerViewController: UIViewController {

    // MARK: - Data Model

    let profiles = [
        Profile(image: UIImage(named: "manyAnimals"), name: "John Doe", description: "В течение 3 месяцев"),
        Profile(image: UIImage(named: "elephant"), name: "Jane Smith", description: "В ближайший месяц"),
    ]

    // MARK: - Outlets

    let tableView = UITableView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    // MARK: - Setup

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")

        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension ChoosePartnerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        let profile = profiles[indexPath.row]
        cell.configure(with: profile.image, name: profile.name, description: profile.description)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profile = profiles[indexPath.row]

        let vc = ProfileDetailViewController()
        vc.profile = profile
        self.navigationController?.pushViewController(vc, animated: true)

    }
}


// MARK: - Profile Model

struct Profile {
    let image: UIImage?
    let name: String
    let description: String
}

