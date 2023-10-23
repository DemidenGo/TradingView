//
//  TradeViewModelProtocol.swift
//  TradingView
//
//  Created by Юрий Демиденко on 20.10.2023.
//

import Foundation

protocol TradeViewModelProtocol {
    var chartURLRequest: URLRequest? { get }
    var currencyPair: CurrencyPair { get }
    var investmentStringObservable: Observable<String> { get }
    var timeStringObservable: Observable<String> { get }
    var balanceStringObservable: Observable<String> { get }
    var currencyPairObservable: Observable<CurrencyPair> { get }
    var shouldShowSuccessfullyNoticeObservable: Observable<Bool> { get }
    func viewDidLoad()
    func didSelect(_ currencyPair: CurrencyPair)
    func timerDidTapMinus()
    func timerDidTapPlus()
    func investmentDidTapMinus()
    func investmentDidTapPlus()
    func didEnter(investment: String)
    func didEnter(timer: String)
    func didTapBuy()
    func didTapSell()
    func didTapContinue()
}
