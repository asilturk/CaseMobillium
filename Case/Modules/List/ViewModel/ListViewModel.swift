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
    func updateSearchResult()
}

final class ListViewModel {
    
    private let service = Service()
    
    private(set) var upcomingMovies = [MovieCellModel]() {
        didSet {
            delegate?.updateTableView()
        }
    }
    
    private(set) var playingMovies = [MovieSliderModel]() {
        didSet {
            delegate?.updateSliderView()
        }
    }
    
    private(set) var searchResult: [MovieCellModel]? {
        didSet {
            delegate?.updateSearchResult()
        }
    }
    
    weak var delegate: ListViewModelDelegate?
}

// MARK: - Request Methods
extension ListViewModel {
    
    func getNowPlaying() {
        service.getMoviesNowPlaying { (response) in
            var model = [MovieSliderModel]()
            for result in response?.results ?? [] {
                let data = MovieSliderModel(title: result.title,
                                            date: Date.date(from: result.release_date),
                                            imageURL: URL(string: ImageType.big.url + (result.backdrop_path ?? "")))
                model.append(data)
            }
            self.playingMovies = model
        }
    }
    
    func getUpcoming() {
        service.getMoviesUpcoming { (response) in
            var model = [MovieCellModel]()
            for result in response?.results ?? [] {
                let data = MovieCellModel(id: result.id,
                                          title: result.title,
                                          descrtiption: result.overview,
                                          date: Date.date(from: result.release_date),
                                          imageURL: URL(string: ImageType.small.url + (result.backdrop_path ?? "")))
                model.append(data)
            }
            
            self.upcomingMovies = model
        }
    }
    
    func searchMovies(by searchText: String) {
        service.searchMovie(by: searchText) { (response) in
            var model = [MovieCellModel]()
            for result in response?.results ?? [] {
                let data = MovieCellModel(id: result.id,
                                          title: result.title,
                                          date: Date.date(from: result.release_date))
                model.append(data)
            }
            self.searchResult = model
        }
    }
}
