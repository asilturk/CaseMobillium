//
//  MovieSliderView.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 8.10.2020.
//

import UIKit

class MovieSliderView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 14)

        return label
    }()

    private let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 6

        return view
    }()


    private let movieImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // TODO: model
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
        self.setConstraints()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addCustomView() {
        addSubview(titleLabel)
        addSubview(movieImageView)
        backgroundColor = .purple
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            movieImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            movieImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            movieImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            movieImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
    }
    
}
