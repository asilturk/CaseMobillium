//
//  IMDBView.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 10.10.2020.
//

import UIKit

protocol IMDBViewDelegate: class {
    func imdbIconTapped()
}

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

    private let rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.2)
        label.text = "1.1"

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.2)
        label.text = "12.12.2012"

        return label
    }()

    private let imdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "icon-imdb.png")
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imdbIconTapped)))
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    weak var delegate: IMDBViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setSubview()

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Auxiliarh Methods
extension IMDBView {

    func setSubview() {
        addSubview(stackView)
        [starImageView, rateLabel, dateLabel, imdbImageView].forEach { stackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
//            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }

    @objc func imdbIconTapped() {
        delegate?.imdbIconTapped()
    }
}

