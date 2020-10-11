//
//  MovieDetailViewController.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 6.10.2020.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    var popRecognizer: InteractivePopRecognizer?

    var viewModel = MovieDetailViewModel()
    var movieId: Int? // servis cagrilarinda kullanilacak


    private let movieImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true

        return view
    }()

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .darkText
        view.font = UIFont.boldSystemFont(ofSize: 20)

        return view
    }()

    private let detailTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textColor = .darkGray
        view.isEditable = false
        view.isSelectable = false

        return view
    }()

    private let imdbView: IMDBView = {
        let view = IMDBView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .clear
        
        return view
    }()

    private let similarMoviesView: SimilarMoviesView = {
        let view = SimilarMoviesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUserInterface()
        setInteractiveRecognizer()
        setLightMode()

        requestMovieDetails()
        requestSimilarMovies()

        viewModel.delegate = self
        similarMoviesView.delegate = self
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Actions
extension MovieDetailViewController {

}

// MARK: - Auxiliary Methods
extension MovieDetailViewController {
    func setUserInterface() {
        setSubviews()
        setMovieImageView()
        setTitleLabel()
        setDescriptionView()
        setImdbView()
        setSimilarMoviesView()
        setImdbGesture()
    }

    func setSubviews() {
        view.addSubview(movieImageView)
        view.addSubview(titleLabel)
        view.addSubview(detailTextView)
        view.addSubview(imdbView)
        view.addSubview(similarMoviesView)
    }

    func setMovieImageView() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20),
            movieImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            movieImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            movieImageView.heightAnchor.constraint(equalToConstant: view.frame.width - 100)
        ])
    }

    func setTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func setDescriptionView() {
        NSLayoutConstraint.activate([
            detailTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            detailTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            detailTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            detailTextView.bottomAnchor.constraint(equalTo: imdbView.topAnchor, constant: -8)
        ])
    }

    func setImdbView() {
        NSLayoutConstraint.activate([
            imdbView.bottomAnchor.constraint(equalTo: similarMoviesView.topAnchor, constant: -16),
            imdbView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            imdbView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            imdbView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setSimilarMoviesView() {

        NSLayoutConstraint.activate([
            similarMoviesView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            similarMoviesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            similarMoviesView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            similarMoviesView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func setLightMode() {
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
    }

    func requestMovieDetails() {
        viewModel.getMovieDetails(movieId: movieId)
    }

    func requestSimilarMovies() {
        viewModel.getSimilarMovies(movieId: movieId)
    }

    func setImdbGesture() {
        imdbView.isUserInteractionEnabled = true
        imdbView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openImdbWebsite)))
    }

    @objc func openImdbWebsite() {
        if let id = movieId, let url = URL(string: "https://www.themoviedb.org/redirect?external_source=\(id)") {
            UIApplication.shared.open(url)
        }
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

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func updateDetails() {
        titleLabel.text = "\(viewModel.movie?.title ?? "") (\(viewModel.movie?.date?.onlyYear ?? ""))"
        detailTextView.text = viewModel.movie?.detail
        imdbView.dateString = viewModel.movie?.date?.shortDate
        imdbView.avarage = viewModel.movie?.avarage
        movieImageView.kf.setImage(with: viewModel.movie?.imageURL)
    }

    func updateSimilarMoves() {
        similarMoviesView.similarMovies = viewModel.similarMovies
    }
}

// MARK: - SimilarMoviesViewDelegate
extension MovieDetailViewController: SimilarMoviesViewDelegate {

    func selected(movieId: Int?) {
        guard let movieId = movieId else { return }

        let destination = MovieDetailViewController()
        destination.movieId = movieId
        navigationController?.pushViewController(destination, animated: true)
    }

}
