//
//  SearchResultView.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 11.10.2020.
//

import UIKit

protocol SearchResultViewDelegate: class {
    func updateResults(movieId: Int?)
}

class SearchResultView: UIView {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    var movies: [MovieCellModel]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    weak var delegate: SearchResultViewDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setTableView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SearchResultView {

    func setTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        ])
    }
}

extension SearchResultView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let movie = movies?[indexPath.row]
        cell.textLabel?.text = movie?.title

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let id = movies?[indexPath.row].id
        delegate?.updateResults(movieId: id)
    }

}
