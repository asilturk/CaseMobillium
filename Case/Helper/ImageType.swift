//
//  ImageType.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 11.10.2020.
//

import Foundation

enum ImageType {
    case small
    case medium
    case big

    var url: String {
        let baseURL = "https://image.tmdb.org/t/p"

        switch self {
        case .small: return "\(baseURL)/w185/"
        case .medium: return "\(baseURL)/w342/"
        case .big: return "\(baseURL)/w780/"
        }
    }
}
