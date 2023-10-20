//
//  TopTradersViewController.swift
//  TradingView
//
//  Created by Юрий Демиденко on 19.10.2023.
//

import UIKit

final class TopViewController: UIViewController {

    private let viewModel: TopTradersViewModelProtocol

    private lazy var topTradersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.topTradersTitle
        label.font = UIFont(name: Fonts.interBold, size: 22)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var topTradersTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TopTableViewCell.self, forCellReuseIdentifier: TopTableViewCell.identifier)
        tableView.backgroundColor = Colors.topTradersBackground
        tableView.sectionHeaderTopPadding = 0.0
        tableView.layer.cornerRadius = 8.75
        tableView.layer.masksToBounds = true
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    init(viewModel: TopTradersViewModelProtocol = TopTradersViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("TopTradersViewController init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.topTradersBackground
        setupConstraints()
        viewModel.viewDidLoad()
        bind()
    }

    private func bind() {
        viewModel.tradersObservable.bind { [weak self] _ in
            self?.topTradersTableView.performBatchUpdates({
                self?.topTradersTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            })
        }
    }

    private func setupConstraints() {
        [topTradersLabel, topTradersTableView].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            topTradersLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topTradersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            topTradersTableView.topAnchor.constraint(equalTo: topTradersLabel.bottomAnchor, constant: 29),
            topTradersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            topTradersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            topTradersTableView.heightAnchor.constraint(equalToConstant: 550)
        ])
    }
}

// MARK: - UITableViewDataSource

extension TopViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.traders.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TopTableHeaderView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopTableViewCell.identifier) as? TopTableViewCell
        else { return UITableViewCell() }
        cell.setup(with: viewModel.traders[indexPath.row], for: indexPath.row + 1)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TopViewController: UITableViewDelegate {

}
