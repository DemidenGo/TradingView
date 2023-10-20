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

    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.progressBackground
        view.progressTintColor = Colors.appGreen
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.subviews.last?.layer.cornerRadius = 12
        view.subviews.last?.layer.masksToBounds = true
        return view
    }()

    private lazy var percentProgressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Fonts.interExtraBold, size: 16)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showProgress()
    }

    private func setupConstraints() {
        [backgroundImageView, progressView, percentProgressLabel].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38),
            progressView.heightAnchor.constraint(equalToConstant: 24),

            percentProgressLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            percentProgressLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            percentProgressLabel.widthAnchor.constraint(equalToConstant: 50),
            percentProgressLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func setProgress() {
        progressView.setProgress(progressView.progress + 0.01, animated: true)
        let percentProgress = round(progressView.progress * 100)
        percentProgressLabel.text = String(format: "%.0f", percentProgress) + "%"
    }

    private func hideAllViews() {
        UIView.animate(withDuration: 0.5) {
            self.backgroundImageView.alpha = 0
            self.progressView.alpha = 0
            self.percentProgressLabel.alpha = 0
        }
    }

    private func showTabBarController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }

    private func presentAlert() {
        let alert = UIAlertController(title: L10n.notificationAlertTitle,
                                      message: L10n.notificationAlertMessage,
                                      preferredStyle: .alert)
        let firstAction = UIAlertAction(title: L10n.notificationAlertFirstActionTitle, style: .cancel) { [weak self] _ in
            self?.showTabBarController()
        }
        let secondAction = UIAlertAction(title: L10n.notificationAlertSecondActionTitle, style: .default) { [weak self] _ in
            if let appSettingsURL = URL(string: UIApplication.openNotificationSettingsURLString) {
                UIApplication.shared.open(appSettingsURL) { _ in
                    self?.showTabBarController()
                }
            }
        }
        [firstAction, secondAction].forEach { alert.addAction($0) }
        alert.preferredAction = secondAction
        present(alert, animated: true)
    }

    private func showProgress() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.progressView.progress < 1 {
                timer.tolerance = 0.1
                self.setProgress()
            } else {
                timer.invalidate()
                self.hideAllViews()
                self.presentAlert()
            }
        }
    }
}
