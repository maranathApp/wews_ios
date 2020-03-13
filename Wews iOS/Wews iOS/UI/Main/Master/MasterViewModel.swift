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

protocol MasterViewModelling: ListViewModelling{
    var hasNetwork: Bool { get }
    func loadData()
}

final class MasterViewModel: MasterViewModelling, ObservableObject {

    typealias ListModel = MasterCollectionViewModel

    // MARK: - PRIVATE ATTRIBUTES

    private let inputs: MasterViewModelInputs
    private var dataSource = [MasterCollectionViewModel]()

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
                let dataSourceModels = response.channel.items.map({ MasterCollectionViewModel(title: $0.title, description: $0.description, link: URL(string: $0.link), imageURL: URL(string: $0.mediaContent.url)) })
                self?.dataSource.append(contentsOf: dataSourceModels)
        }
        .store(in: &cancellables)
    }

    func getItem(for indexPath: IndexPath) -> MasterCollectionViewModel {
        return dataSource[indexPath.row]
    }
}
