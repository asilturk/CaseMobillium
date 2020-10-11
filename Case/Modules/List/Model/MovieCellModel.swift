//
//  MovieCellModel.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 8.10.2020.
//

import Foundation

struct MovieCellModel {

    let id: Int?
    let title: String?
    let descrtiption: String?
    let date: Date?
    let imageURL: URL?

    init(id: Int?, title: String?, descrtiption: String? = nil, date: Date?, imageURL: URL? = nil) {
        self.id = id
        self.title = title
        self.descrtiption = descrtiption
        self.date = date
        self.imageURL = imageURL
    }

}

