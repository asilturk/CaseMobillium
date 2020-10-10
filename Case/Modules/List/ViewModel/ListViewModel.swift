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

    private(set) var nowPlayingMovie: NowPlayingMovie? {
        didSet {
            delegate?.updateSliderView()
        }
    }

    weak var delegate: ListViewModelDelegate?

    private(set) var dummyCellDatas = [MovieCellModel]()

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
            for result in movie?.results ?? [] {
                let data = MovieCellModel(title: result.title, descrtiption: result.overview, dateText: result.release_date, imageData: nil)
                self.dummyCellDatas.append(data)
            }
            self.delegate?.updateTableView()
        }
    }
    
}


class Demo {
    private init() {}
    static let s = Demo()
    lazy var image: Data? = {
        UIImage(named: "demo")?.pngData()
    }()
}
