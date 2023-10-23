//
//  TabBarController.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import UIKit

final class TabBarController: UITabBarController {

    private class CustomTabBar: UITabBar {

        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 96
            return sizeThatFits
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, CustomTabBar.self)

    }

    required init?(coder: NSCoder) {
        fatalError("TabBarController init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }

    private func setupController() {
        let tradeViewController = TradeViewController()
        let navigationController = NavigationController(rootViewController: tradeViewController)
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
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -9)
        UITabBar.appearance().backgroundColor = Colors.tabBarBackground
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = Colors.tabBarBorders?.cgColor
        viewControllers = [navigationController, topViewController]
        selectedIndex = 1
    }
}
