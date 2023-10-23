//
//  CurrencyPairCollectionViewCell.swift
//  TradingView
//
//  Created by Юрий Демиденко on 22.10.2023.
//

import UIKit

final class CurrencyPairCollectionViewCell: UICollectionViewCell {

    static var identifier: String {
        String(describing: self)
    }

    private lazy var currencyPairLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Colors.labelBackground
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("CurrencyPairCollectionViewCell init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        contentView.addSubview(currencyPairLabel)
        NSLayoutConstraint.activate([
            currencyPairLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            currencyPairLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            currencyPairLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            currencyPairLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func setup(with currencyPair: CurrencyPair) {
        currencyPairLabel.text = currencyPair.rawValue
    }

    func select() {
        currencyPairLabel.backgroundColor = Colors.appGreen
    }

    func unselect() {
        currencyPairLabel.backgroundColor = Colors.labelBackground
    }
}
