//
//  ListViewController.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 6.10.2020.
//

import UIKit

class ListViewController: UIViewController {

    private var popRecognizer: InteractivePopRecognizer? = nil

    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.searchBarStyle = .minimal
        view.placeholder = "Search"

        return view
    }()

    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear

        return view
    }()

    private let headerView: MovieSliderView = {
        let view = MovieSliderView()
        view.frame.size.height = 240

        return view
    }()

    private lazy var viewModel: ListViewModel = {
        ListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUserInterface()
        setInteractiveRecognizer()
        setLightMode()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

}

// MARK: - Actions
extension ListViewController {

}

// MARK: - Auxiliary Methods
extension ListViewController {

    func setUserInterface() {
        setSearchBar()
        setTableView()
        setHeaderView()
    }

    func setSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.isHidden = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setTableView() {
        view.addSubview(tableView)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.typeName)
//        tableView.register(MovieHeaderView.self, forHeaderFooterViewReuseIdentifier: MovieHeaderView.typeName)
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    func setHeaderView() {
        tableView.tableHeaderView = headerView
        headerView.modelArray = viewModel.dummySliderDatas
    }

    func setLightMode() {
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dummyCellDatas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.typeName, for: indexPath) as! MovieTableViewCell
        let model = viewModel.dummyCellDatas[indexPath.row]
        cell.model = model

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - UIGestureRecognizerDelegate
extension ListViewController: UIGestureRecognizerDelegate {

    private func setInteractiveRecognizer() {
        guard let controller = navigationController else { return }
        popRecognizer = InteractivePopRecognizer(controller: controller)
        controller.interactivePopGestureRecognizer?.delegate = popRecognizer
    }

}

