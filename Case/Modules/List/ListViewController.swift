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

    // TODO: scroll, imageview ve pagination kisimlari kodlanip eklenecek,

    private let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 6

        return view
    }()

    private let headerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 240))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple

        return view
    }()

    private let movieLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 13)
        view.numberOfLines = 1
        view.textColor = .white

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUserInterface()
        setInteractiveRecognizer()

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
        setLightMode()
        setMovieLabel()
    }

    func setSearchBar() {
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.isHidden = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    func setTableView() {
        view.addSubview(tableView)
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.typeName)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    // TODO: slide alanini yaz, label ekle.
    func setMovieLabel() {
        let x = UIView(frame: CGRect(x: 0, y: 0, width: 29, height: 29))
        x.backgroundColor = .white
        tableView.tableHeaderView?.addSubview(x)
//        guard let headerView = tableView.tableHeaderView else { return }
//        headerView.addSubview(movieLabel)
//        movieLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
//        movieLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
//        movieLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
//        movieLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    func setHeaderView() {
        tableView.tableHeaderView = headerView
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

    var dummys: [String] {
        ["ali", "veli", "selami","ali", "veli", "selami", "ali", "veli", "selami","ali", "veli", "selami"]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.typeName, for: indexPath) as! MovieTableViewCell
        let dummyItem = dummys[indexPath.row]

        cell.dummy = dummyItem

        return cell
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }

}

// MARK: - UIGestureRecognizerDelegate
extension ListViewController: UIGestureRecognizerDelegate {

    private func setInteractiveRecognizer() {
        guard let controller = navigationController else { return }
        popRecognizer = InteractivePopRecognizer(controller: controller)
        controller.interactivePopGestureRecognizer?.delegate = popRecognizer
    }

}

