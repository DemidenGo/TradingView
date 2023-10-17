//
//  SplashViewController.swift
//  TradingView
//
//  Created by Юрий Демиденко on 18.10.2023.
//

import UIKit

final class SplashViewController: UIViewController {

    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.launchScreen
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }

    private func setupConstraints() {
        [backgroundImageView].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
