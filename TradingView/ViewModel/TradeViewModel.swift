//
//  TradeViewModel.swift
//  TradingView
//
//  Created by Юрий Демиденко on 20.10.2023.
//

import Foundation

final class TradeViewModel {

    @Observable
    private var balanceString: String
    @Observable
    private(set) var currencyPair: CurrencyPair
    @Observable
    private var timeString: String
    @Observable
    private var investmentString: String
    @Observable
    private var shouldShowSuccessfullyNotice: Bool

    private var investment: Int {
        didSet {
            investmentString = investment.formatted()
        }
    }

    private var balance: Int {
        didSet {
            balanceString = balance.formatted().replacingOccurrences(of: ",", with: " ")
        }
    }
    
    private var time: Int {
        didSet {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            formatter.allowedUnits = [.minute, .second]
            let timeInterval = TimeInterval(time)
            guard let timeString = formatter.string(from: timeInterval) else { return }
            self.timeString = timeString
        }
    }

    init() {
        self.time = 0
        self.balance = 0
        self.investment = 0
        self.currencyPair = .gbpusd
        self.timeString = ""
        self.investmentString = ""
        self.balanceString = ""
        self.shouldShowSuccessfullyNotice = false
    }

    private func invest() {
        if balance >= investment {
            balance -= investment
            shouldShowSuccessfullyNotice = true
        }
    }
}

// MARK: - TradeViewModelProtocol

extension TradeViewModel: TradeViewModelProtocol {

    var currencyPairObservable: Observable<CurrencyPair> { $currencyPair }
    var timeStringObservable: Observable<String> { $timeString }
    var investmentStringObservable: Observable<String> { $investmentString }
    var balanceStringObservable: Observable<String> { $balanceString }
    var shouldShowSuccessfullyNoticeObservable: Observable<Bool> { $shouldShowSuccessfullyNotice }

    var chartURLRequest: URLRequest? {
        guard var components = URLComponents(string: Constants.baseURLString) else { return nil }
        let currencyPairItem = URLQueryItem(name: "symbol", value: "FX:" + currencyPair.string)
        components.queryItems?.append(currencyPairItem)
        guard let url = components.url else { return nil }
        let request = URLRequest(url: url)
        return request
    }

    func viewDidLoad() {
        balance = Constants.startBalance
        currencyPair = Constants.startCurrencyPair
        time = Constants.startTime
        investment = Constants.startInvestment
    }

    func didSelect(_ currencyPair: CurrencyPair) {
        if self.currencyPair != currencyPair {
            self.currencyPair = currencyPair
        }
    }

    func timerDidTapMinus() {
        if time > Constants.timerStep {
            time -= Constants.timerStep
        }
    }

    func timerDidTapPlus() {
        if time < 3599 {
            time += Constants.timerStep
        }
    }

    func investmentDidTapMinus() {
        if investment > Constants.investmentStep {
            investment -= Constants.investmentStep
        }
    }

    func investmentDidTapPlus() {
        if investment <= balance - Constants.investmentStep {
            investment += Constants.investmentStep
        }
    }

    func didEnter(investment: String) {
        if investment == "" || Int(investment) == 0 {
            self.investment = balance >= Constants.startInvestment ? Constants.startInvestment : balance
            return
        }
        let newInvestment = investment.replacingOccurrences(of: ",", with: "")
        guard let newInvestmentInt = Int(newInvestment) else { return }
        self.investment = newInvestmentInt < balance ? newInvestmentInt : balance
    }

    func didEnter(timer: String) {
        if timer == "" {
            time = Constants.startTime
            return
        }
        var minutes = Int(timer.prefix(2)) ?? 0
        var seconds = Int(timer.suffix(2)) ?? 0
        if minutes > 59 {
            minutes = 59
        }
        if seconds > 59 {
            seconds = 59
        }
        time = minutes * 60 + seconds
    }

    func didTapBuy() {
        invest()
    }

    func didTapSell() {
        invest()
    }

    func didTapContinue() {
        if [true, false].randomElement()! {
            balance += investment + (investment * 70) / 100
        }
        if balance < investment {
            investment = balance < Constants.startInvestment ? balance : Constants.startInvestment
        }
    }
}
