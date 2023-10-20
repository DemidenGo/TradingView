//
//  TradersStore.swift
//  TradingView
//
//  Created by Юрий Демиденко on 20.10.2023.
//

import Foundation

final class TradersStore: TradersStoreProtocol {

    private var traderModels: [TraderModel]

    init() {
        self.traderModels = []
    }

    func fetchTraders() -> [TraderModel] {
        traderModels = TraderModel.makeMockModel()
        return traderModels
    }

    func setRandomIncome(completion: ([TraderModel], [Int]) -> ()) {
        let randomIndex = (traderModels.startIndex...traderModels.endIndex - 1).randomElement() ?? 0
        let randomTraderModel = traderModels[randomIndex]
        let randomIncome = (50...150).randomElement() ?? 50
        let updatedTraderModel = TraderModel(name: randomTraderModel.name,
                                             country: randomTraderModel.country,
                                             deposit: randomTraderModel.deposit + randomIncome,
                                             profit: randomTraderModel.profit + randomIncome)
        traderModels[randomIndex] = updatedTraderModel
        completion(traderModels, [randomIndex])
    }
}
