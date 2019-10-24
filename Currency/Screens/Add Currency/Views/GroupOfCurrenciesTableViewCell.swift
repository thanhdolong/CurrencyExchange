//
//  GroupOfCurrenciesTableViewCell.swift
//  Currency
//
//  Created by Thành Đỗ Long on 23/10/2019.
//  Copyright © 2019 Thành Đỗ Long. All rights reserved.
//

import UIKit

class GroupOfCurrenciesTableViewCell: UITableViewCell, ReusableView {
    public var items: [Currency] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private var selectedCurrencies: Set<String> {
        get {
            let defaults = UserDefaults.standard
            let selectedArray: [String] = defaults.array(forKey: "selectedCurrencies") as? [String] ?? [String]()
            return Set(selectedArray)
        }

        set(newSelectedCurrencies) {
            let defaults = UserDefaults.standard
            defaults.set(Array(newSelectedCurrencies), forKey: "selectedCurrencies")
            collectionView.reloadData()
        }
    }

    weak var collectionView: UICollectionView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        createSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createSubviews() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = true

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }

        addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(CurrencyCollectionViewCell.nib, forCellWithReuseIdentifier: CurrencyCollectionViewCell.reuseIdentifier)
        self.collectionView = collectionView
    }
}

extension GroupOfCurrenciesTableViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.reuseIdentifier, for: indexPath) as! CurrencyCollectionViewCell

        let currency = items[indexPath.row]
        cell.titleLabel.text = currency.name
        cell.subtitleLabel.text = currency.code.uppercased()

        if selectedCurrencies.contains(currency.code) {
            cell.bgView.backgroundColor = .red
        } else {
            cell.bgView.backgroundColor = .blue
        }
        return cell
    }
}

extension GroupOfCurrenciesTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toggleCurrencyStatus(indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        toggleCurrencyStatus(indexPath)
    }

    private func toggleCurrencyStatus(_ indexPath: IndexPath) {
        let code = items[indexPath.row].code

        guard selectedCurrencies.contains(code) else {
            selectedCurrencies.insert(code)
            return
        }

        selectedCurrencies.remove(code)
    }
}

extension GroupOfCurrenciesTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 130, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 40)
    }
}
