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
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"

        return searchBar
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        return tableView
    }()

    private let movieSliderView: MovieSliderView = {
        let sliderView = MovieSliderView()
        sliderView.frame.size.height = 240

        return sliderView
    }()

    private var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUserInterface()
        setInteractiveRecognizer()
        setLightMode()

        viewModel.delegate = self
        viewModel.getNowPlaying()
        viewModel.getUpcoming()
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
        tableView.tableHeaderView = movieSliderView
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
        return viewModel.movieArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.typeName, for: indexPath) as! MovieTableViewCell
        let model = viewModel.movieArray[indexPath.row]
        cell.model = model

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModel.movieArray[indexPath.row]
        let destination = MovieDetailViewController()
        destination.movieId = model.id
        navigationController?.pushViewController(destination, animated: true)
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

// MARK: - ListViewModelDelegate
extension ListViewController: ListViewModelDelegate {

    func updateSliderView() {
        DispatchQueue.main.async {
            self.movieSliderView.model = self.viewModel.nowPlayingMovie
        }
    }

    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }


}
