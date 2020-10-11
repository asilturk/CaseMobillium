//
//  SimilarMoviesView.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 10.10.2020.
//

import UIKit

class SimilarMoviesView: UIView {

    private let seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator

        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.3)

        return label
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: 100, height: 140)
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SimilarMovieCollectionViewCell.self, forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.typeName)
        collectionView.backgroundColor = .white

        return collectionView
    }()
    

    var similarMovies = [SimilarMovieModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setSubviews()
        setSeperatorView()
        setTitleLabel()
        setCollectionView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
    }

    // TODO: collectionViewModel
}

// MARK: - Auxiliary Methods
extension SimilarMoviesView {

    func setSubviews() {
        addSubview(seperatorView)
        addSubview(titleLabel)
        addSubview(collectionView)
    }

    func setSeperatorView() {
        NSLayoutConstraint.activate([
            seperatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            seperatorView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            seperatorView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

    func setTitleLabel() {
        titleLabel.text = "Benzer Filmler"

        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SimilarMoviesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.typeName, for: indexPath) as! SimilarMovieCollectionViewCell
        let model = similarMovies[indexPath.row]

        cell.model = model

        return cell
    }


}

