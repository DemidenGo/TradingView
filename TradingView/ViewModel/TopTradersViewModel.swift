//
//  TopTradersViewModel.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import Foundation

final class TopTradersViewModel {

    @Observable
    private(set) var traders: [TraderViewModel]

    init() {
        self.traders = []
    }
}

extension TopTradersViewModel: TopTradersViewModelProtocol {

    var tradersObservable: Observable<[TraderViewModel]> { $traders }

    func viewDidLoad() {
        traders = TraderModel.makeMockModel().map {
            TraderViewModel(name: $0.name,
                            country: Country(rawValue: $0.country) ?? .empty,
                            deposit: L10n.currencySymbol + String($0.deposit),
                            profit: L10n.currencySymbol + String($0.profit))
        }
    }
}
