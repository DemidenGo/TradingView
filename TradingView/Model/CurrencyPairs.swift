//
//  CurrencyPairs.swift
//  TradingView
//
//  Created by Юрий Демиденко on 22.10.2023.
//

import Foundation

enum CurrencyPair: String {
    case eurusd = "EUR / USD"
    case gbpusd = "GBP / USD"
    case usdjpy = "USD / JPY"
    case gbpjpy = "GBP / JPY"
    case audusd = "AUD / USD"
    case usdcad = "USD / CAD"
    case usdchf = "USD / CHF"
    case eurjpy = "EUR / JPY"
    case gbpaud = "GBP / AUD"
    case nzdusd = "NZD / USD"
    case eurgbp = "EUR / GBP"
    case euraud = "EUR / AUD"
    case audcad = "AUD / CAD"
    case gbpcad = "GBP / CAD"

    var string: String {
        switch self {
        case .eurusd: return "eurusd"
        case .gbpusd: return "gbpusd"
        case .usdjpy: return "usdjpy"
        case .gbpjpy: return "gbpjpy"
        case .audusd: return "audusd"
        case .usdcad: return "usdcad"
        case .usdchf: return "usdchf"
        case .eurjpy: return "eurjpy"
        case .gbpaud: return "gbpaud"
        case .nzdusd: return "nzdusd"
        case .eurgbp: return "eurgbp"
        case .euraud: return "euraud"
        case .audcad: return "audcad"
        case .gbpcad: return "gbpcad"
        }
    }

    var stringWithSlash: String {
        switch self {
        case .eurusd: return "EUR/USD"
        case .gbpusd: return "GBP/USD"
        case .usdjpy: return "USD/JPY"
        case .gbpjpy: return "GBP/JPY"
        case .audusd: return "AUD/USD"
        case .usdcad: return "USD/CAD"
        case .usdchf: return "USD/CHF"
        case .eurjpy: return "EUR/JPY"
        case .gbpaud: return "GBP/AUD"
        case .nzdusd: return "NZD/USD"
        case .eurgbp: return "EUR/GBP"
        case .euraud: return "EUR/AUD"
        case .audcad: return "AUD/CAD"
        case .gbpcad: return "GBP/CAD"
        }
    }
}
