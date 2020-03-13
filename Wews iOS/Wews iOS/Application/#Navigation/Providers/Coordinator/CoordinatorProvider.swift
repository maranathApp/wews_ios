//
//  CoordinatorProvider.swift
//  Wews iOS
//
//  Created by Frezy Mboumba on 2/26/20.
//  Copyright © 2020 MaranathApp. All rights reserved.
//

import UIKit

struct CoordinatorProvider {
    static var app: AppCoordinator { AppCoordinator() }
    static var main: MainCoordinator { MainCoordinator() }
}
