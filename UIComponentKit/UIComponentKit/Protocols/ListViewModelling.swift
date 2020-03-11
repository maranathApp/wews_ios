//
//  ListViewModelling.swift
//  UIComponentKit
//
//  Created by Frezy Mboumba on 3/05/2020.
//  Copyright © 2019 MaranathApp. All rights reserved.
//

import Foundation

public protocol ListViewModelling: ViewModelling {
    associatedtype ListModel
    var itemsCount: Int { get }
    var sectionsCount: Int { get }
    func getItem(for indexPath: IndexPath) -> ListModel
}

public extension ListViewModelling {
    var sectionsCount: Int { return 1 }
}
