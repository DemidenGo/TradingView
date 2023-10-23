//
//  TradeViewController.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import UIKit
import WebKit

final class TradeViewController: UIViewController {

    private let viewModel: TradeViewModelProtocol
    private let notificationCenter: NotificationCenter
    private var buttonsViewTopConstraint: NSLayoutConstraint

    private lazy var tradeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.tradeTitle
        label.font = UIFont(name: Fonts.interBold, size: 22)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var balanceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.labelBackground
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()

    private lazy var balanceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.balanceTitle
        label.textColor = Colors.tradeGrayFont
        label.font = UIFont(name: Fonts.interMedium, size: 12)
        label.textAlignment = .center
        return label
    }()

    private lazy var balanceCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    private lazy var chartWebView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isOpaque = false
        return view
    }()

    private lazy var buttonsBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.tradeBackground
        return view
    }()

    private lazy var currencyPairLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Colors.labelBackground
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        return label
    }()

    private lazy var selectPairButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Images.arrowRight, for: .normal)
        button.addTarget(self, action: #selector(choosePair), for: .touchUpInside)
        return button
    }()

    private lazy var timePicker: ValuePicker = {
        let picker = ValuePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.titleText = L10n.timerTitle
        picker.minusButton.addTarget(self, action: #selector(minusTimerAction), for: .touchUpInside)
        picker.plusButton.addTarget(self, action: #selector(plusTimerAction), for: .touchUpInside)
        picker.valueCounterTextField.delegate = self
        return picker
    }()

    private lazy var investmentPicker: ValuePicker = {
        let picker = ValuePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.titleText = L10n.investmentTitle
        picker.minusButton.addTarget(self, action: #selector(minusInvestmentAction), for: .touchUpInside)
        picker.plusButton.addTarget(self, action: #selector(plusInvestmentAction), for: .touchUpInside)
        picker.valueCounterTextField.delegate = self
        return picker
    }()

    private lazy var pickersStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timePicker, investmentPicker])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 11
        return stack
    }()

    private lazy var sellButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.appRed
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .top
        button.titleEdgeInsets = UIEdgeInsets(top: 2, left: 20, bottom: 0, right: 0)
        button.setTitle(L10n.sellTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.interMedium, size: 24)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sellAction), for: .touchUpInside)
        return button
    }()

    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.appGreen
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .top
        button.titleEdgeInsets = UIEdgeInsets(top: 2, left: 20, bottom: 0, right: 0)
        button.setTitle(L10n.buyTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.interMedium, size: 24)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buyAction), for: .touchUpInside)
        return button
    }()

    private lazy var buySellButtonsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [sellButton, buyButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 11
        return stack
    }()

    init(viewModel: TradeViewModelProtocol = TradeViewModel()) {
        self.viewModel = viewModel
        self.notificationCenter = NotificationCenter.default
        self.buttonsViewTopConstraint = NSLayoutConstraint()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("TradeViewController init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.tradeBackground
        setupConstraints()
        hideKeyboardByTap()
        bind()
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow),
                                       name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide),
                                       name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func bind() {
        viewModel.balanceStringObservable.bind { [weak self] balance in
            self?.balanceCountLabel.text = balance
        }
        viewModel.currencyPairObservable.bind { [weak self] currencyPair in
            self?.loadChart()
            self?.currencyPairLabel.text = currencyPair.stringWithSlash
        }
        viewModel.timeStringObservable.bind { [weak self] timeString in
            self?.timePicker.valueCounterText = timeString
        }
        viewModel.investmentStringObservable.bind { [weak self] investmentString in
            self?.investmentPicker.valueCounterText = investmentString
        }
        viewModel.shouldShowSuccessfullyNoticeObservable.bind { [weak self] shouldShow in
            if shouldShow {
                self?.presentAlert()
            }
        }
    }

    private func loadChart() {
        guard let request = viewModel.chartURLRequest else { return }
        chartWebView.load(request)
    }

    @objc private func buyAction() {
        viewModel.didTapBuy()
    }

    @objc private func sellAction() {
        viewModel.didTapSell()
    }

    @objc private func choosePair() {
        let viewController = SelectPairViewController(selectedPair: viewModel.currencyPair) { [weak self] selectedPair in
            self?.viewModel.didSelect(selectedPair)
        }
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func minusTimerAction() {
        viewModel.timerDidTapMinus()
    }

    @objc private func plusTimerAction() {
        viewModel.timerDidTapPlus()
    }

    @objc private func minusInvestmentAction() {
        viewModel.investmentDidTapMinus()
    }

    @objc private func plusInvestmentAction() {
        viewModel.investmentDidTapPlus()
    }

    private func presentAlert() {
        let alert = UIAlertController(title: L10n.successfullyTitle, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: L10n.continueTitle, style: .cancel) { [weak self] _ in
            self?.viewModel.didTapContinue()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }

    private func setupConstraints() {
        [tradeLabel,
         balanceView,
         chartWebView,
         buttonsBottomView,
         currencyPairLabel,
         selectPairButton,
         pickersStackView].forEach { view.addSubview($0) }
        [balanceTitleLabel, balanceCountLabel].forEach { balanceView.addSubview($0) }
        [currencyPairLabel, selectPairButton, pickersStackView, buySellButtonsStackView].forEach { buttonsBottomView.addSubview($0) }
        buttonsViewTopConstraint = buttonsBottomView.topAnchor.constraint(equalTo: chartWebView.bottomAnchor)
        NSLayoutConstraint.activate([
            tradeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tradeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            balanceTitleLabel.topAnchor.constraint(equalTo: balanceView.topAnchor, constant: 5),
            balanceTitleLabel.centerXAnchor.constraint(equalTo: balanceView.centerXAnchor),

            balanceCountLabel.bottomAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: -8),
            balanceCountLabel.centerXAnchor.constraint(equalTo: balanceView.centerXAnchor),

            balanceView.topAnchor.constraint(equalTo: tradeLabel.bottomAnchor, constant: 15),
            balanceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            balanceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            balanceView.heightAnchor.constraint(equalToConstant: 54),

            chartWebView.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 25),
            chartWebView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chartWebView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chartWebView.heightAnchor.constraint(equalToConstant: 321),

            buttonsViewTopConstraint,
            buttonsBottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            buttonsBottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            buttonsBottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            currencyPairLabel.topAnchor.constraint(equalTo: buttonsBottomView.topAnchor, constant: 16),
            currencyPairLabel.leadingAnchor.constraint(equalTo: buttonsBottomView.leadingAnchor, constant: 30),
            currencyPairLabel.trailingAnchor.constraint(equalTo: buttonsBottomView.trailingAnchor, constant: -30),
            currencyPairLabel.heightAnchor.constraint(equalToConstant: 54),

            selectPairButton.centerYAnchor.constraint(equalTo: currencyPairLabel.centerYAnchor),
            selectPairButton.trailingAnchor.constraint(equalTo: currencyPairLabel.trailingAnchor, constant: -19),

            pickersStackView.topAnchor.constraint(equalTo: currencyPairLabel.bottomAnchor, constant: 10),
            pickersStackView.leadingAnchor.constraint(equalTo: buttonsBottomView.leadingAnchor, constant: 30),
            pickersStackView.trailingAnchor.constraint(equalTo: buttonsBottomView.trailingAnchor, constant: -30),
            pickersStackView.heightAnchor.constraint(equalToConstant: 54),

            buySellButtonsStackView.topAnchor.constraint(equalTo: pickersStackView.bottomAnchor, constant: 10),
            buySellButtonsStackView.leadingAnchor.constraint(equalTo: buttonsBottomView.leadingAnchor, constant: 30),
            buySellButtonsStackView.trailingAnchor.constraint(equalTo: buttonsBottomView.trailingAnchor, constant: -30),
            buySellButtonsStackView.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    private func hideKeyboardByTap() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 1) {
                self.buttonsViewTopConstraint.constant = -keyboardSize.height + self.view.safeAreaInsets.bottom
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: 1) {
            self.buttonsViewTopConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UITextFieldDelegate

extension TradeViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == investmentPicker.valueCounterTextField {
            if let newInvestment = textField.text {
                viewModel.didEnter(investment: newInvestment)
                return
            }
        }
        if textField == timePicker.valueCounterTextField {
            if let newTimer = textField.text {
                viewModel.didEnter(timer: newTimer)
            }
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == timePicker.valueCounterTextField, range.location == 2 {
            return false
        }
        let maxLength = textField == timePicker.valueCounterTextField ? 5 : 8
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
        return newString.count <= maxLength
    }
}
