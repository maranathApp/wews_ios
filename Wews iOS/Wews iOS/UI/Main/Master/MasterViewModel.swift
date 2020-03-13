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

protocol MasterViewModelling: ListViewModelling {
    var hasNetwork: Bool { get }
    func loadData()
    func getDetailViewModel(for indexPath: IndexPath) -> DetailViewModel
}

final class MasterViewModel: MasterViewModelling, ObservableObject {

    typealias ListModel = MasterCollectionViewCellModel

    // MARK: - PRIVATE ATTRIBUTES

    private let inputs: MasterViewModelInputs
    private var dataSource = [MasterCollectionViewCellModel]()

    // MARK: - ATTRIBUTES

    @Published var viewState: ViewState?

    let alertTitle = "common.error.title".localized
    let noNetworkMessage = "common.noInternet".localized
    let alertOkayButtonTitle = "common.okay".localized
    let noDataMessage = "common.noData".localized

    var hasNetwork: Bool {
        guard let reachability = Reachability(),
            reachability.currentReachabilityStatus != .notReachable else  {
                return false
        }

        return true
    }

    var itemsCount: Int { dataSource.count }
    var cancellables = Set<AnyCancellable>()
    var shouldReloadData = PassthroughSubject<Void, Never>()
    var rssInformation: RSS?

    // MARK: - INITIALIZERS

    init(inputs: MasterViewModelInputs) {
        self.inputs = inputs
        self.viewState = .empty
    }

    // MARK: - METHODS

    func loadData() {
        viewState = .loading

        guard hasNetwork else {
            viewState = .error(ReachabilityError.noNetwork)

            return
        }

        inputs
            .RSSFeedService
            .call(parameter: RSSFeedServiceParameter())
            .sink(receiveCompletion: { [weak self] errorCompletion in
                switch errorCompletion {
                case .failure(let error):
                    self?.viewState = .error(error)
                case .finished:
                    self?.viewState = .data
                }
            }) { [weak self] response in
                self?.rssInformation = response
                let dataSourceModels = response.channel.items.map({ MasterCollectionViewCellModel(title: $0.title, description: $0.description, link: URL(string: $0.link), imageURL: URL(string: $0.mediaContent.url)) })
                self?.dataSource.append(contentsOf: dataSourceModels)
        }
        .store(in: &cancellables)
    }

    func getItem(for indexPath: IndexPath) -> MasterCollectionViewCellModel {
        return dataSource[indexPath.row]
    }

    func getDetailViewModel(for indexPath: IndexPath) -> DetailViewModel {
        return dataSource.map({ DetailViewModel(title: $0.title ?? "", imageURL: $0.imageURL, description: $0.description, link: $0.link) })[indexPath.row]
    }
}
 
