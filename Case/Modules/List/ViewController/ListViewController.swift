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

    private let searchResultView: SearchResultView = {
        let view = SearchResultView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
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
        sliderView.frame.size.height = 250

        return sliderView
    }()

    private let viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUserInterface()
        setInteractiveRecognizer()
        setLightMode()
        setViewModel()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

// MARK: - Auxiliary Methods
extension ListViewController {

    func setUserInterface() {
        setSearchBar()
        setTableView()
        setHeaderView()
        setSearchResultView()
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

    func setSearchResultView() {
        view.addSubview(searchResultView)
        searchResultView.delegate = self
        searchResultView.isHidden = true

        NSLayoutConstraint.activate([
            searchResultView.leftAnchor.constraint(equalTo: view.leftAnchor, constant:0),
            searchResultView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            searchResultView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            searchResultView.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ])
    }

    func setHeaderView() {
        tableView.tableHeaderView = movieSliderView
    }

    func setLightMode() {
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
    }

    func showMovieDetail(by id: Int) {
        let destination = MovieDetailViewController()
        destination.movieId = id
        navigationController?.pushViewController(destination, animated: true)

        searchResultView.isHidden = true
        searchBar.text = nil
        view.endEditing(true)
    }

    func setViewModel() {
        viewModel.delegate = self
        viewModel.getNowPlaying()
        viewModel.getUpcoming()
    }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count >= 2 else { return }
        viewModel.searchMovies(by: searchText)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.upcomingMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.typeName, for: indexPath) as! MovieTableViewCell
        let model = viewModel.upcomingMovies[indexPath.row]
        cell.model = model

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let id = viewModel.upcomingMovies[indexPath.row].id else { return }
        showMovieDetail(by: id)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        searchResultView.isHidden = true
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
        movieSliderView.movies = viewModel.playingMovies
    }

    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func updateSearchResult() {
        searchResultView.movies = viewModel.searchResult
        searchResultView.isHidden = viewModel.searchResult?.count == 0
    }
}

// MARK: - SearchResultViewDelegate
extension ListViewController: SearchResultViewDelegate {

    func updateResults(movieId: Int?) {
        guard let id = movieId else { return }
        showMovieDetail(by: id)
    }
}
