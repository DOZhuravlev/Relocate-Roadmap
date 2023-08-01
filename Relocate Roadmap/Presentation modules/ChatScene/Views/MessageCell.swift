//
//  MessageCell.swift
//  Relocate Roadmap
//
//  Created by Zhuravlev Dmitry on 28.07.2023.
//

import UIKit
import SnapKit

final class MessageCell: UITableViewCell {

    enum MessageAlignment {
           case left, right
       }

    // MARK: - UI Components

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timestampLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 12)
           label.textColor = .gray
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupUI()
    }

    // MARK: - Configuration

    func configure(with message: Message, alignment: MessageAlignment) {
           messageLabel.text = message.text

           // Set the alignment of the message label based on the provided alignment
           switch alignment {
           case .left:
               messageLabel.textAlignment = .left
               timestampLabel.snp.remakeConstraints { make in
                   make.leading.equalToSuperview().offset(16)
                   make.bottom.equalToSuperview().offset(-2)
               }

           case .right:
               messageLabel.textAlignment = .right
               timestampLabel.snp.remakeConstraints { make in
                   make.trailing.equalToSuperview().offset(-16)
                   make.bottom.equalToSuperview().offset(-2)
               }
           }

           // Display the timestamp
           let formatter = DateFormatter()
           formatter.dateFormat = "HH:mm" // Формат времени, например, "13:30"
           timestampLabel.text = formatter.string(from: message.timestamp)
       }

    // MARK: - UI Setup

    private func setupUI() {
            selectionStyle = .none
            contentView.addSubview(messageLabel)
            contentView.addSubview(timestampLabel)

            // Set up constraints for the cell components
        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(timestampLabel.snp.top).offset(-8) // Ограничение снизу к timestampLabel
        }

        timestampLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

