//
//  MovieSliderView.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 8.10.2020.
//

import UIKit
import Kingfisher

class MovieSliderView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.backgroundColor = .clear
        
        return pageControl
    }()
    
    var movies: [MovieSliderModel]? {
        didSet {
            layoutSubviews()
            pageControl.numberOfPages = movies?.count ?? 0
            updateTitleLabel()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if scrollView.subviews.count == 2 {
            configureScrollView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubviews()
        setConstraints()
        setGestureForPageControl()
        setScrollDelegate()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Auxiliary Methods
extension MovieSliderView {
    
    private func setScrollDelegate() {
        scrollView.delegate = self
    }
    
    private func setSubviews() {
        addSubview(scrollView)
        addSubview(pageControl)
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            
            pageControl.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            pageControl.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureScrollView() {
        guard let modelArray = movies else { return }
        
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(modelArray.count), height: scrollView.frame.size.height)
        
        for (index, movie) in modelArray.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(index) * frame.size.width,
                                                      y: 0,
                                                      width: frame.size.width,
                                                      height: scrollView.frame.size.height))
            
            imageView.kf.setImage(with: movie.imageURL)
            
            scrollView.addSubview(imageView)
        }
    }
    
    private func setGestureForPageControl() {
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_ :)), for: .valueChanged)
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * frame.size.width, y: 0), animated: false)
        updateTitleLabel(for: current)
    }
    
    private func updateTitleLabel(for index: Int = 0) {
        let title = movies?[index].title ?? ""
        let date = movies?[index].date?.onlyYear ?? ""
        
        self.titleLabel.text = " \(title) (\(date))"
    }
}

// MARK: - UIScrollViewDelegate
extension MovieSliderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width))
        updateTitleLabel(for: pageControl.currentPage)
    }
}
