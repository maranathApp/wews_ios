//
//  CollectionViewController.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/05/2020.
//  Copyright © 2019 MaranathApp. All rights reserved.
//

import UIKit

open class CollectionViewController<Cell: UICollectionViewCell, ViewModel: ListViewModelling>: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout where Cell: SetupableView, ViewModel.ListModel == Cell.SetupModel {

    // MARK: - PUBLIC ATTRIBUTES

    public var collectionView: UICollectionView!
    public var viewModel: ViewModel!

    // MARK: - PUBLIC INITIALIZERS

    public init(viewModel: ViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        preconditionFailure("Tried to instantiate \(name) from nib.")
    }

    #if DEBUG
    deinit {
        print(name + " has been deinitialized.")
    }
    #endif

    // MARK: - PUBLIC METHODS

    open func setUpCollectionView(with layout: UICollectionViewLayout, isNiblessCell: Bool = false) {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false

        if isNiblessCell {
            collectionView.registerNiblessCell(Cell.self)
        } else {
            collectionView?.registerCell(Cell.self)
        }

        setUpView()
    }

    // MARK: - PRIVATE METHODS

    private func setUpView() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    // MARK: UISCROLLVIEWDELEGATE

    open func scrollViewDidScroll(_ scrollView: UIScrollView) {}

    // MARK: UICOLLECTIONVIEWDATASOURCE 

    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionsCount
    }

    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }

    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as Cell
        cell.setup(with: viewModel.getItem(for: indexPath))

        return cell
    }

    // MARK: UICOLLECTIONVIEWDELEGATE

    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {}

    // MARK: UICOLLECTIONVIEWDELEGATEFLOWLAYOUT

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
}
