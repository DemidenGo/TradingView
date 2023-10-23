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
        label.font = UIFont(name: Fonts.interMedium, size: 14)
        label.textColor = Colors.topTradersGrayFont
        return label
    }()

    private lazy var countryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.interMedium, size: 14)
        label.textColor = .white
        return label
    }()

    private lazy var depositLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.interMedium, size: 14)
        label.textColor = .white
        return label
    }()

    private lazy var profitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.interMedium, size: 14)
        label.textColor = Colors.appGreen
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
        [numberLabel, countryImageView, nameLabel, depositLabel, profitLabel].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),

            countryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            countryImageView.heightAnchor.constraint(equalToConstant: 26),
            countryImageView.widthAnchor.constraint(equalToConstant: 26),

            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 110),

            depositLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            depositLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -98),

            profitLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9)
        ])
    }

    func setup(with traderViewModel: TraderViewModel, for rowNumber: Int) {
        contentView.backgroundColor = rowNumber % 2 == 0 ? Colors.topTradersTableBackground : Colors.topTradersBackground
        numberLabel.text = String(rowNumber)
        countryImageView.image = UIImage(named: traderViewModel.country.rawValue)
        nameLabel.text = traderViewModel.name
        depositLabel.text = traderViewModel.deposit
        profitLabel.text = traderViewModel.profit
    }
}
