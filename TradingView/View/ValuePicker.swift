//
//  ValuePicker.swift
//  TradingView
//
//  Created by Юрий Демиденко on 22.10.2023.
//

import UIKit

final class ValuePicker: UIControl {

    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }

    var valueCounterText: String = "" {
        didSet {
            valueCounterTextField.text = valueCounterText
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.tradeGrayFont
        label.font = UIFont(name: Fonts.interMedium, size: 12)
        label.textAlignment = .center
        return label
    }()

    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Images.minusButton, for: .normal)
        return button
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Images.plusButton, for: .normal)
        return button
    }()

    lazy var valueCounterTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .systemFont(ofSize: 16, weight: .bold)
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .dark
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeAppearance()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("ValuePicker init(coder:) has not been implemented")
    }

    private func customizeAppearance() {
        backgroundColor = Colors.labelBackground
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }

    private func setupConstraints() {
        [titleLabel, minusButton, plusButton, valueCounterTextField].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            minusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            minusButton.widthAnchor.constraint(equalToConstant: 18),
            minusButton.heightAnchor.constraint(equalToConstant: 18),

            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            plusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
            plusButton.widthAnchor.constraint(equalToConstant: 18),
            plusButton.heightAnchor.constraint(equalToConstant: 18),

            valueCounterTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueCounterTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
