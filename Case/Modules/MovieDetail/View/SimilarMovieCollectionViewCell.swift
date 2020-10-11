//
//  SimilarMovieCollectionViewCell.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 10.10.2020.
//

import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {

    class var typeName: String {
        String(describing: self)
    }

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5

        return stackView
    }()

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .yellow

        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = .systemFont(ofSize: 10)

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.3)
        label.font = .systemFont(ofSize: 10)

        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var model: SimilarMovieModel? {
        didSet {
            titleLabel.text = model?.title
            dateLabel.text = model?.dateString
            movieImageView.kf.setImage(with: model?.imageURL)
        }
    }

}

// MARK: - Auxiliary Methods
extension SimilarMovieCollectionViewCell {

    func setSubviews() {
        addSubview(movieImageView)
        addSubview(stackView)
        [titleLabel, dateLabel].forEach{ stackView.addArrangedSubview($0) }
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            movieImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            movieImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            movieImageView.heightAnchor.constraint(equalToConstant: 90),

            stackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 5),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 5),
        ])
    }

}
