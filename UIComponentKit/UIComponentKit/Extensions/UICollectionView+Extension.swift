//
//  UICollectionView+Extension.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/05/2020.
//  Copyright © 2019 MaranathApp. All rights reserved.
//

import UIKit.UICollectionView

public extension UICollectionView {
    func registerCell<Cell: UICollectionViewCell>(_ classType: Cell.Type, customNibName: String? = nil) {
        let nib = UINib(nibName: customNibName ?? Cell.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }

    func registerNiblessCell<Cell: UICollectionViewCell>(_ classType: Cell.Type) {
        register(classType.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }

    func registerHeaderFooter<SectionView: SetupableView>(_ classType: SectionView.Type) {
        let nib = UINib(nibName: SectionView.nibName, bundle: nil)
        register(nib, forSupplementaryViewOfKind: SectionView.nibName, withReuseIdentifier: SectionView.reuseIdentifier)
    }

    func registerNiblessHeaderFooter<SectionView: SetupableView>(_ classType: SectionView.Type) {
        register(classType.self, forSupplementaryViewOfKind: SectionView.nibName, withReuseIdentifier: SectionView.reuseIdentifier)
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            preconditionFailure("\(#function). Failed to dequeue reusable cell \(String(describing: Cell.self)).")
        }
        return cell
    }

    func dequeueReusableHeader<SectionView: SetupableView>(_ classType: SectionView.Type, for indexPath: IndexPath) -> SectionView {
        guard let headerView = self.dequeueReusableSupplementaryView(ofKind: SectionView.nibName, withReuseIdentifier: SectionView.reuseIdentifier, for: indexPath) as? SectionView else {
            preconditionFailure("\(#function). Failed to dequeue ReusableSupplementaryView \(String(describing: SectionView.self)).")
        }

        return headerView
    }
}
