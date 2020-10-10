//
//  InteractivePopNavigation.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 7.10.2020.
//

import UIKit

class InteractivePopRecognizer: NSObject {

    fileprivate weak var navigationController: UINavigationController?

    init(controller: UINavigationController) {
        self.navigationController = controller

        super.init()

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension InteractivePopRecognizer: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (navigationController?.viewControllers.count ?? 0) > 1
    }

    // This is necessary because without it, subviews of your top controller can cancel out your gesture recognizer on the edge.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
