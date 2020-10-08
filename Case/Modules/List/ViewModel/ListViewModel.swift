//
//  ListViewModel.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 6.10.2020.
//

import UIKit

class ListViewModel {

    let dummySliderDatas = [
        MovieSliderModel(imageData: UIImage(named: "demo")?.pngData(), title: "demo object 1"),
        MovieSliderModel(imageData: UIImage(named: "demo")?.pngData(), title: "demo object 2"),
        MovieSliderModel(imageData: UIImage(named: "demo")?.pngData(), title: "demo object 3")
    ]

    let dummyCellDatas = [
        MovieCellModel(title: "demo title 1", descrtiption: "description of that movie as an explanation", dateText: "12.01.12", imageData: UIImage(named: "demo")?.pngData()),
        MovieCellModel(title: "demo title 2", descrtiption: "description of that movie as an explanation", dateText: "13.02.13", imageData: UIImage(named: "demo")?.pngData()),
        MovieCellModel(title: "demo title 3", descrtiption: "description of that movie as an explanation", dateText: "14.03.14", imageData: UIImage(named: "demo")?.pngData()),

    ]
}
