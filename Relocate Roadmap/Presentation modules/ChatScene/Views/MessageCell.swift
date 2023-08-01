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

    // MARK: - Outlets

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

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        timestampLabel.text = formatter.string(from: message.timestamp)
    }

    // MARK: - Setup

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(messageLabel)
        contentView.addSubview(timestampLabel)

        messageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(timestampLabel.snp.top).offset(-8)
        }

        timestampLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

