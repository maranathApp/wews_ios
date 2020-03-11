//
//  MasterViewModel.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 3/6/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import Foundation
import UIComponentKit
import Core
import Combine

struct MasterViewModelInputs {
    let RSSFeedService: RSSFeedServicing
}

protocol MasterViewModelling: ListViewModelling, Statable {
    func loadData()
}

final class MasterViewModel: MasterViewModelling, ObservableObject {

    typealias ListModel = MasterCollectionViewModel

    // MARK: - PRIVATE ATTRIBUTES

    private let inputs: MasterViewModelInputs
    private var dataSource = [MasterCollectionViewModel]() {
        didSet {
            viewState = dataSource.isEmpty ? .empty : .data
            if !dataSource.isEmpty {
                shouldReloadData.send()
            }
        }
    }

    // MARK: - ATTRIBUTES

    private(set) var viewState: ViewState = .empty {
        didSet {
            viewStateChanged.send(viewState)
        }
    }

    var itemsCount: Int { dataSource.count }
    var cancellables = Set<AnyCancellable>()

    var shouldReloadData = PassthroughSubject<Void, Never>()
    var viewStateChanged = PassthroughSubject<ViewState, Never>()

    // MARK: - INITIALIZERS

    init(inputs: MasterViewModelInputs) {
        self.inputs = inputs
    }

    // MARK: - METHODS

    func loadData() {
        inputs
            .RSSFeedService
            .call(parameter: RSSFeedServiceParameter())
            .sink(receiveCompletion: { [weak self] errorCompletion in
                switch errorCompletion {
                case .failure(let error):
                    self?.viewState = .error(error)
                case .finished: break
                }
            }) { [weak self] response in
                self?.dataSource.append(contentsOf: response.channel.items.map({ MasterCollectionViewModel(title: $0.title, description: $0.description, link: URL(string: $0.link), imageURL: URL(string: $0.mediaContent.url)) }))
            }
            .store(in: &cancellables)
    }

    func getItem(for indexPath: IndexPath) -> MasterCollectionViewModel {
        return dataSource[indexPath.row]
    }
}
