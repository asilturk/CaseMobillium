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

    let dummySimilarMovieArray = [
        SimilarMovieModel(imageData: Demo.s.image, title: "deneme 1", dateString: "2020"),
        SimilarMovieModel(imageData: nil, title: "deneme 3", dateString: "2021"),
        SimilarMovieModel(imageData:  Demo.s.image, title: "deneme 2", dateString: "2022"),
        SimilarMovieModel(imageData: nil, title: "deneme 4", dateString: "2021"),
        SimilarMovieModel(imageData: Demo.s.image, title: "deneme 5", dateString: "2021"),
    ]

    weak var delegate: MovieDetailViewModelDelegate?

    func getMovieDetails(movieId: Int?) {
        service.getMovieDetails(movieId: movieId) { (movieDetail) in
            self.movieDetail = movieDetail
        }
    }
    
}
