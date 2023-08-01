//
//  ChooseCountryViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.07.2023.
//

import UIKit

class ChooseCountryViewController: UIViewController {

    private let countries = ["Россия", "Грузия", "Турция", "Сербия"] // Замените на свой список стран
       private let tableView = UITableView()

       override func viewDidLoad() {
           super.viewDidLoad()
           setupViews()
           setupConstraints()
       }

       private func setupViews() {
           title = "Выберите страну"

           tableView.delegate = self
           tableView.dataSource = self
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
           view.addSubview(tableView)
       }

       private func setupConstraints() {
           tableView.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
       }
   }

   extension ChooseCountryViewController: UITableViewDataSource, UITableViewDelegate {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return countries.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
           cell.textLabel?.text = countries[indexPath.row]
           return cell
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedCountry = countries[indexPath.row]
           // Добавьте код для сохранения выбранной страны или передачи ее на следующий экран
           // Например, используйте делегирование, блоки, NotificationCenter или другие подходы для передачи данных на следующий экран
           // После сохранения или передачи выбранной страны, выполните переход на следующий экран

           // Пример использования делегирования:
           // delegate?.didSelectCountry(selectedCountry)

           // Пример использования блока:
           // completionHandler(selectedCountry)

           // Пример использования NotificationCenter:
           // NotificationCenter.default.post(name: Notification.Name("CountrySelected"), object: selectedCountry)

           // Замените примеры выше на свои реализации передачи данных на следующий экран и перехода на него
       }

}
