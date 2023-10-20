//
//  TopTradersViewModelProtocol.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import Foundation

protocol TopTradersViewModelProtocol {
    var traders: [TraderViewModel] { get }
    var tradersObservable: Observable<[TraderViewModel]> { get }
    func viewDidLoad()
}
