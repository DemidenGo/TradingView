//
//  TopTradersViewModel.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import Foundation

final class TopTradersViewModel {

    private let tradersStore: TradersStoreProtocol

    @Observable
    private var viewModelUpdatedIndices: [Int]
    private(set) var traders: [TraderViewModel]
    var timer: Timer

    init(tradersStore: TradersStoreProtocol = TradersStore()) {
        self.tradersStore = tradersStore
        self.viewModelUpdatedIndices = []
        self.traders = []
        self.timer = Timer()
    }

    private func setTraderViewModels(from traderModels: [TraderModel]) {
        traders = traderModels.map {
            TraderViewModel(name: $0.name,
                            country: Country(rawValue: $0.country) ?? .empty,
                            deposit: L10n.currencySymbol + String($0.deposit),
                            profit: L10n.currencySymbol + String($0.profit))
        }
    }
}

extension TopTradersViewModel: TopTradersViewModelProtocol {

    var viewModelUpdatedIndicesObservable: Observable<[Int]> { $viewModelUpdatedIndices }

    func viewDidLoad() {
        let traderModels = tradersStore.fetchTraders()
        setTraderViewModels(from: traderModels)
    }

    func viewDidAppear() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            self?.tradersStore.setRandomIncome { traderModels, modelUpdatedIndices in
                self?.setTraderViewModels(from: traderModels)
                self?.viewModelUpdatedIndices = modelUpdatedIndices
            }
        }
    }

    func viewWillDisappear() {
        timer.invalidate()
    }
}
