//
//  TabBarController.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }

    private func setupTabBarController() {
        let tradeViewController = TradeViewController()
        let tradeSelectedImage = Images.tradeTabBar?.withTintColor(Colors.appGreen, renderingMode: .alwaysOriginal)
        tradeViewController.tabBarItem = UITabBarItem(title: L10n.tradeTabBarTitle,
                                                      image: Images.tradeTabBar,
                                                      selectedImage: tradeSelectedImage)
        let topSelectedImage = Images.topTabBar?.withTintColor(Colors.appGreen, renderingMode: .alwaysOriginal)
        let topViewController = TopViewController()
        topViewController.tabBarItem = UITabBarItem(title: L10n.topTradersTabBarTitle,
                                                    image: Images.topTabBar,
                                                    selectedImage: topSelectedImage)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: Colors.appGreen], for: .selected)
        viewControllers = [tradeViewController, topViewController]
        selectedIndex = 1
    }
}
