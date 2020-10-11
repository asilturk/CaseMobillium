//
//  MovieDetailViewModel.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 6.10.2020.
//

import UIKit

protocol MovieDetailViewModelDelegate: class {
    func updateDetails()
    func updateSimilarMoves()
}

final class MovieDetailViewModel {

    private(set) var movieDetail: MovieDetailResponse? {
        didSet {
            delegate?.updateDetails()
        }
    }

    private let service = Service()

    var similarMovies = [SimilarMovieModel]() {
        didSet {
            delegate?.updateSimilarMoves()
        }
    }

    weak var delegate: MovieDetailViewModelDelegate?

    func getMovieDetails(movieId: Int?) {
        service.getMovieDetails(movieId: movieId) { (movieDetail) in
            self.movieDetail = movieDetail
        }
    }

    func getSimilarMovies(movieId: Int?) {
        service.getSimilarMovies(movieId: movieId) { (response) in
            var model = [SimilarMovieModel]()
            for result in response?.results ?? [] {
                let data = SimilarMovieModel(imageData: nil, title: result.title, dateString: result.release_date)
                model.append(data)
            }

            self.similarMovies = model
        }
    }
}

