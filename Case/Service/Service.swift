//
//  Service.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 10.10.2020.
//

import Foundation
import Alamofire

struct Service {
    
    private let apiKey = "5f8aa4bd65792788f329a3e785908ab7"
    private let baseUrl = "https://api.themoviedb.org/3"

    func getMoviesNowPlaying(page: Int = 1, completion: @escaping(NowPlayingMovieResponse?) -> ()) {
        let url = "\(baseUrl)/movie/now_playing?api_key=\(apiKey)&language=en-US&page=\(page)"

        AF.request(url, method: .get).response { result in
            guard let data = result.data else { return }
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(NowPlayingMovieResponse.self, from: data)
            completion(responseModel)
        }
    }

    func getMoviesUpcoming(page: Int = 1, completion: @escaping(UpcomingMovieResponse?) -> ()) {
        let url = "\(baseUrl)/movie/upcoming?api_key=\(apiKey)&language=en-US&page=\(page)"

        AF.request(url, method: .get).response { result in
            guard let data = result.data else { return }
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(UpcomingMovieResponse.self, from: data)
            completion(responseModel)
        }
    }

    func getMovieDetails(movieId: Int?, completion: @escaping(MovieDetailResponse?) -> ()) {
        guard let movieId = movieId else { return }
        let url = "\(baseUrl)/movie/\(movieId)?api_key=\(apiKey)&language=en-US"

        AF.request(url, method: .get).response { result in
            guard let data = result.data else { return }
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(MovieDetailResponse.self, from: data)
            completion(responseModel)
        }
    }

    func getSimilarMovies(movieId: Int?, page: Int = 1, completion: @escaping(SimilarMovieResponse?) -> ()) {
        guard let movieId = movieId else { return }
        let url = "\(baseUrl)/movie/\(movieId)/similar?api_key=\(apiKey)&language=en-US&page=\(page)"

        AF.request(url, method: .get).response { result in
            guard let data = result.data else { return }
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(SimilarMovieResponse.self, from: data)
            completion(responseModel)
        }
    }

    func searchMovie(by searchText: String, page: Int = 1, includeAdult: Bool = false, completion: @escaping(SearchResponse?) -> ()) {

        let url = "\(baseUrl)/search/movie?api_key=\(apiKey)&language=en-US&query=\(searchText)&page=\(page)&include_adult=\(includeAdult)"

        AF.request(url, method: .get).response { result in
            guard let data = result.data else { return }
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(SearchResponse.self, from: data)
            completion(responseModel)
        }
    }


}
