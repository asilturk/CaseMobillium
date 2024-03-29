//
//  IMDBView.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 10.10.2020.
//

import UIKit

class IMDBView: UIView {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 12

        return stackView
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.insetsLayoutMarginsFromSafeArea = false
        imageView.image = #imageLiteral(resourceName: "icon-star.png")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private let avarageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.2)
        label.font = UIFont.systemFont(ofSize: 13)

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.2)
        label.font = UIFont.systemFont(ofSize: 13)

        return label
    }()

    private let imdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "icon-imdb.png")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    var dateString: String? {
        didSet {
            dateLabel.text = dateString
        }
    }

    var avarage: Double? {
        didSet {
            avarageLabel.text = "\(avarage ?? 0.0)"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setSubview()

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Auxiliary Methods
extension IMDBView {

    func setSubview() {
        addSubview(stackView)
        [starImageView, avarageLabel, dateLabel, imdbImageView].forEach { stackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

}

