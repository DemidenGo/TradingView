//
//  TradersStoreProtocol.swift
//  TradingView
//
//  Created by Юрий Демиденко on 20.10.2023.
//

import Foundation

protocol TradersStoreProtocol {
    func fetchTraders() -> [TraderModel]
    func setRandomIncome(completion: ([TraderModel], [Int]) -> ())
}
