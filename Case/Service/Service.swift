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

    func getMoviesNowPlaying(page: Int = 1, completion: @escaping(NowPlayingMovie?) -> ()) {
        let url = "\(baseUrl)/movie/now_playing?api_key=\(apiKey)&language=en-US&page=\(page)"

        AF.request(url, method: .get).response { result in
            guard let data = result.data else { return }
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(NowPlayingMovie.self, from: data)
            completion(responseModel)
        }

    }

    func getMoviesUpcoming(page: Int = 1, completion: @escaping(UpcomingMovie?) -> ()) {
        let url = "\(baseUrl)/movie/upcoming?api_key=\(apiKey)&language=en-US&page=\(page)"

        AF.request(url, method: .get).response { result in
            guard let data = result.data else { return }
            let jsonDecoder = JSONDecoder()
            let responseModel = try? jsonDecoder.decode(UpcomingMovie.self, from: data)
            completion(responseModel)
        }
    }

}
