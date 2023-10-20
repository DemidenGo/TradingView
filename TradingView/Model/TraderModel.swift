//
//  TraderModel.swift
//  TradingView
//
//  Created by Юрий Демиденко on 17.10.2023.
//

import Foundation

struct TraderModel {

    let name: String
    let country: String
    let deposit: Int
    let profit: Int

    static func makeMockModel() -> [TraderModel] {
        var model = [TraderModel]()
        model.append(TraderModel(name: "Oliver",
                                 country: "usa",
                                 deposit: 8367,
                                 profit: 336755))
        model.append(TraderModel(name: "Jack",
                                 country: "can",
                                 deposit: 7489,
                                 profit: 287190))
        model.append(TraderModel(name: "Harry",
                                 country: "bra",
                                 deposit: 7004,
                                 profit: 230712))
        model.append(TraderModel(name: "Jacob",
                                 country: "kor",
                                 deposit: 6489,
                                 profit: 198640))
        model.append(TraderModel(name: "Charley",
                                 country: "ger",
                                 deposit: 6084,
                                 profit: 167500))
        model.append(TraderModel(name: "Thomas",
                                 country: "bra",
                                 deposit: 5602,
                                 profit: 139750))
        model.append(TraderModel(name: "George",
                                 country: "fra",
                                 deposit: 4992,
                                 profit: 97600))
        model.append(TraderModel(name: "Oscar",
                                 country: "nzl",
                                 deposit: 4299,
                                 profit: 75100))
        model.append(TraderModel(name: "James",
                                 country: "ind",
                                 deposit: 3015,
                                 profit: 53760))
        model.append(TraderModel(name: "William",
                                 country: "spa",
                                 deposit: 1563,
                                 profit: 25905))
        return model
    }
}
