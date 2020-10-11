//
//  ListViewModel.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 6.10.2020.
//

import UIKit

protocol ListViewModelDelegate: class {
    func updateSliderView()
    func updateTableView()
}

final class ListViewModel {

    private let service = Service()

    private(set) var movieArray = [MovieCellModel]() {
        didSet {
            delegate?.updateTableView()
        }
    }

    private(set) var nowPlayingMovie: NowPlayingMovieResponse? {
        didSet {
            delegate?.updateSliderView()
        }
    }

    weak var delegate: ListViewModelDelegate?

}

// MARK: - Request Methods
extension ListViewModel {

    func getNowPlaying() {
        service.getMoviesNowPlaying { (movie) in
            self.nowPlayingMovie = movie
        }
    }

    func getUpcoming() {
        service.getMoviesUpcoming { (movie) in
            var model = [MovieCellModel]()
            for result in movie?.results ?? [] {
                let data = MovieCellModel(id: result.id,
                                          title: result.title,
                                          descrtiption: result.overview,
                                          dateText: result.release_date,
                                          imageURL: URL(string: ImageType.small.url + (result.poster_path ?? "")))
                model.append(data)
            }

            self.movieArray = model
        }
    }
    
}
