//
//  TraderViewModel.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import Foundation

enum Country: String {
    case usa, can, bra, kor, ger, fra, nzl, ind, spa, empty
}

struct TraderViewModel {
    let name: String
    let country: Country
    let deposit: String
    let profit: String
}
