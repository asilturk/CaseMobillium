//
//  MovieTableViewCell.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 7.10.2020.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.textColor = .black
        view.numberOfLines = 1

        return view
    }()

    private let descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 13)
        view.textAlignment = .left
        view.textColor = .systemGray
        view.numberOfLines = 2

        return view
    }()

    private let dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 10)
        view.textAlignment = .left
        view.textColor = .lightGray
        view.numberOfLines = 1

        return view
    }()

    private let movieImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.contentMode = .scaleToFill

        return view
    }()

    private let arrowImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "rightArrow.png")
        view.contentMode = .scaleAspectFit

        return view
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        view.axis = .horizontal
        view.spacing = 5

        return view
    }()

    var dummy: String? {
        didSet {
            titleLabel.text = dummy
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
    }

    func setAnchors() {
        movieImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        movieImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        movieImageView.image = #imageLiteral(resourceName: "demo.png")

        arrowImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        stackView.leftAnchor.constraint(equalTo: movieImageView.rightAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true


    }

}
