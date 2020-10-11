//
//  MovieTableViewCell.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 7.10.2020.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    class var typeName: String {
        String(describing: self)
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 1

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .systemGray
        label.numberOfLines = 2

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .left
        label.textColor = .lightGray
        label.numberOfLines = 1

        return label
    }()

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill

        return imageView
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "rightArrow.png")
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 5

        return stackView
    }()

    private let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red

        return view
    }()

    var model: MovieCellModel? {
        didSet {
            titleLabel.text = "\(model?.title ?? "") (\(model?.date?.onlyYear ?? ""))"
            descriptionLabel.text = model?.descrtiption
            dateLabel.text = model?.date?.shortDate
            movieImageView.kf.setImage(with: model?.imageURL)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear

        addSubviews()
        setAnchors()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        [stackView, dateLabel, movieImageView, arrowImageView].forEach { addSubview($0) }
        [titleLabel, descriptionLabel].forEach { stackView.addArrangedSubview($0) }
        addSubview(seperatorView)
    }

    func setAnchors() {

        NSLayoutConstraint.activate([

            movieImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            movieImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            movieImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            movieImageView.heightAnchor.constraint(equalToConstant: 80),
            movieImageView.widthAnchor.constraint(equalToConstant: 80),

            arrowImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20),
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            dateLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            dateLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),

            stackView.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),

            seperatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            seperatorView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            seperatorView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            seperatorView.heightAnchor.constraint(equalToConstant: 10),
        ])

    }

}
