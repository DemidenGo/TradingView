//
//  TopTableHeaderView.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import UIKit

final class TopTableHeaderView: UIView {

    private lazy var numberLabel = makeLabel(text: L10n.numberSymbol)
    private lazy var countryLabel = makeLabel(text: L10n.countryTitle)
    private lazy var nameLabel = makeLabel(text: L10n.nameTitle)
    private lazy var depositLabel = makeLabel(text: L10n.depositTitle)
    private lazy var profitLabel = makeLabel(text: L10n.profitTitle)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.topTradersTableBackground
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("TopTableHeaderView init(coder:) has not been implemented")
    }

    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont(name: Fonts.interMedium, size: 12)
        label.textColor = Colors.topTradersGrayFont
        return label
    }

    private func setupConstraints() {
        [numberLabel, countryLabel, nameLabel, depositLabel, profitLabel].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),

            countryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countryLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 15),

            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: countryLabel.trailingAnchor, constant: 36),

            depositLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            depositLabel.trailingAnchor.constraint(equalTo: profitLabel.leadingAnchor, constant: -42),

            profitLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            profitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

        ])
    }
}
