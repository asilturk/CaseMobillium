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

    init(id: Int?, title: String?, descrtiption: String?, date: Date?, imageURL: URL?) {
        self.id = id
        self.title = title
        self.descrtiption = descrtiption
        self.date = date
        self.imageURL = imageURL
    }

    init(id: Int?, title: String?) {
        self.id = id
        self.title = title
        self.descrtiption = nil
        self.date = nil
        self.imageURL = nil
    }
}

