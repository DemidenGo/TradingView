//
//  ObservableWrapper.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import Foundation

@propertyWrapper
final class Observable<Value> {

    private var onChange: ((Value) -> Void)? = nil

    var wrappedValue: Value {
        didSet {
            onChange?(wrappedValue)
        }
    }

    var projectedValue: Observable {
        return self
    }

    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }

    func bind(action: @escaping (Value) -> Void) {
        self.onChange = action
    }
}
