//
//  ChatViewController.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.07.2023.
//

struct Message {
    let sender: String
    let text: String
    let timestamp: Date
    let isSentByCurrentUser: Bool
}

import UIKit
import SnapKit

class ChatViewController: UIViewController {

    // MARK: - Properties

    var messages: [Message] = [Message(sender: "STASON", text: "Привет как дела?", timestamp: Date(), isSentByCurrentUser: false)]

    // MARK: - Outlets

    private var tableViewBottomConstraint: Constraint?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private let messageInputTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Введите сообщение..."
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private let sendButton: UIButton = {
        let button = UIButton(type: .custom)
        let sendIcon = UIImage(named: "iconSend")
        button.setImage(sendIcon, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTableView()
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)

        messageInputTextView.delegate = self
        setupKeyboardNotifications()

        NotificationCenter.default.addObserver(self, selector: #selector(scrollToBottom), name: NSNotification.Name(rawValue: "newMessageAdded"), object: nil)

    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(tableView)
        view.addSubview(messageInputTextView)
        view.addSubview(sendButton)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            tableViewBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).constraint
        }

        messageInputTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(sendButton.snp.leading).offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.greaterThanOrEqualTo(40) // Закрепляем высоту текстового поля
        }

        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(40)
        }
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")
        tableView.keyboardDismissMode = .interactive
    }

    // MARK: - Actions

    @objc private func sendButtonTapped() {
        guard let text = messageInputTextView.text, !text.isEmpty else {
            return
        }

        let newMessage = Message(sender: "Me", text: text, timestamp: Date(), isSentByCurrentUser: true)
        addMessage(newMessage)
        print(newMessage)

        messageInputTextView.text = nil
    }


    @objc private func scrollToBottom() {
        if tableView.numberOfSections > 0, tableView.numberOfRows(inSection: tableView.numberOfSections - 1) > 0 {
            let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: tableView.numberOfSections - 1) - 1, section: tableView.numberOfSections - 1)
            tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        }
    }


    // MARK: - Data Handling

    func addMessage(_ message: Message) {
        messages.append(message)
        tableView.reloadData()
        // Scroll to the bottom to show the latest message
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    // MARK: - Keyboard Handling

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }

        let keyboardHeight = keyboardFrame.size.height

        tableView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-keyboardHeight)
        }

        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }

        tableView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }

}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let message = messages[indexPath.row]

        let alignment: MessageCell.MessageAlignment = message.isSentByCurrentUser ? .right : .left

        cell.configure(with: message, alignment: alignment)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ChatViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Введите сообщение..." {
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите сообщение..."
        }
    }
}
