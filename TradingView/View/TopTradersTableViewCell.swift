//
//  TopTradersTableViewCell.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import UIKit

final class TopTableViewCell: UITableViewCell {

    static var identifier: String {
        String(describing: self)
    }

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.interBold, size: 14)
        label.textColor = Colors.topTradersGreyFont
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("TopTradersTableViewCell init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        [numberLabel].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9)
        ])
    }

    func setup(with traderViewModel: TraderViewModel, for rowNumber: Int) {
        contentView.backgroundColor = rowNumber % 2 == 0 ? Colors.topTradersTableBackground : Colors.topTradersBackground
        numberLabel.text = String(rowNumber)
    }
}
