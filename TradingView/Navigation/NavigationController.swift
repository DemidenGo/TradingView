//
//  NavigationController.swift
//  TradingView
//
//  Created by Юрий Демиденко on 22.10.2023.
//

import UIKit

final class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    private func setupController() {
        setNavigationBarHidden(true, animated: false)
    }
}
