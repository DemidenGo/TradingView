//
//  Constants.swift
//  TradingView
//
//  Created by Юрий Демиденко on 22.10.2023.
//

import Foundation

enum Constants {
    static let baseURLString = "https://www.tradingview.com/widgetembed/?hideideas=1&overrides=%7B%7D&enabled_features=%5B%5D&disabled_features=%5B%5D&locale=en&&interval=1&theme=dark"
    static let startBalance = 10_000
    static let startTime = 1
    static let startCurrencyPair: CurrencyPair = .gbpusd
    static let startInvestment = 1000
    static let timerStep = 1
    static let investmentStep = 100
}
