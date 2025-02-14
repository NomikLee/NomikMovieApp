//
//  HomeMovieListCollectionViewCell.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/12.
//

import UIKit
import SDWebImage

class HomeMovieListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeMovieListCollectionViewCell"
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let movieListImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "heroImage")
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(movieListImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieListImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieListImageView.image = nil //清除舊資料
    }
    
    // MARK: - Functions
    public func configureData(with imageUrl: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w185\(imageUrl)") else { return }
        movieListImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup

}
// MARK: - Extension
