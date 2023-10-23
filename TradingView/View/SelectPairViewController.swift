//
//  ChoosePairViewController.swift
//  TradingView
//
//  Created by Юрий Демиденко on 22.10.2023.
//

import UIKit

final class SelectPairViewController: UIViewController {

    private var selectedPair: CurrencyPair

    private let completion: (CurrencyPair) -> ()

    private let currencyPairs: [CurrencyPair] = [.eurusd, .gbpusd, .usdjpy, .gbpjpy, .audusd, .usdcad, .usdchf, .eurjpy, .gbpaud, .nzdusd, .eurgbp, .euraud, .audcad, .gbpcad]

    private var selectedPairIndexPath: IndexPath {
        guard let index = currencyPairs.firstIndex(of: selectedPair) else {
            return IndexPath()
        }
        return IndexPath(item: index, section: 0)
    }

    private lazy var currencyPairLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.currencyPairTitle
        label.font = UIFont(name: Fonts.interBold, size: 22)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Images.arrowLeft, for: .normal)
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        return button
    }()

    private lazy var currencyPairsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CurrencyPairCollectionViewCell.self,
                                forCellWithReuseIdentifier: CurrencyPairCollectionViewCell.identifier)
        return collectionView
    }()

    init(selectedPair: CurrencyPair, completion: @escaping (CurrencyPair) -> ()) {
        self.selectedPair = selectedPair
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("ChoosePairViewController init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.tradeBackground
        setupConstraints()
    }

    @objc private func navigateBack() {
        completion(selectedPair)
        navigationController?.popViewController(animated: true)
    }

    private func setupConstraints() {
        [currencyPairLabel, backButton, currencyPairsCollectionView].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            currencyPairLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            currencyPairLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            backButton.centerYAnchor.constraint(equalTo: currencyPairLabel.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 9),

            currencyPairsCollectionView.topAnchor.constraint(equalTo: currencyPairLabel.bottomAnchor, constant: 37),
            currencyPairsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            currencyPairsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            currencyPairsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension SelectPairViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencyPairs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyPairCollectionViewCell.identifier, for: indexPath) as? CurrencyPairCollectionViewCell
        else { return UICollectionViewCell() }
        cell.setup(with: currencyPairs[indexPath.row])
        if indexPath.row == currencyPairs.firstIndex(of: selectedPair) {
            cell.select()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SelectPairViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 95) / 2, height: 54)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CurrencyPairCollectionViewCell
        if indexPath != selectedPairIndexPath {
            selectedCell?.select()
            let previousSelectedCell = collectionView.cellForItem(at: selectedPairIndexPath) as? CurrencyPairCollectionViewCell
            previousSelectedCell?.unselect()
            selectedPair = currencyPairs[indexPath.row]
        }
    }
}
