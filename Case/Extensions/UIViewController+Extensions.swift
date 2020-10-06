//
//  UIViewController+Destination.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 6.10.2020.
//

import UIKit

// This extension used for navigation easily by viewController to viewController
class Destination {

    static let shared = Destination()
    private init() {}

    // MARK: PreDefinded Destinations

    var movieDetail: MovieDetailViewController {
        MovieDetailViewController()
    }

    var list: ListViewController {
        ListViewController()
    }

}
