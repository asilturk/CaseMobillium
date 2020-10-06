//
//  MovieDetailViewController.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 6.10.2020.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var popRecognizer: InteractivePopRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange

        setInteractiveRecognizer()
        setUserInterface()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

// MARK: - Actions
extension MovieDetailViewController {

}

// MARK: - Auxiliary Methods
extension MovieDetailViewController {
    func setUserInterface() {
        setLightMode()
    }

    func setLightMode() {
        overrideUserInterfaceStyle = .light
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MovieDetailViewController: UIGestureRecognizerDelegate {

    private func setInteractiveRecognizer() {
        guard let controller = navigationController else { return }
        popRecognizer = InteractivePopRecognizer(controller: controller)
        controller.interactivePopGestureRecognizer?.delegate = popRecognizer
    }

}
