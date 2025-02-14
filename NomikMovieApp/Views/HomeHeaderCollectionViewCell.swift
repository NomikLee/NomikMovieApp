//
//  HomeHeaderCollectionViewCell.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/12.
//

import UIKit
import SDWebImage

class HomeHeaderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeHeaderCollectionViewCell"
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private let movieNumLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 70)
        label.textColor = .systemIndigo
        label.textAlignment = .center
        label.text = "2"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieNumLabel)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //清除舊資料
        movieImageView.image = nil
        movieNumLabel.text = nil
    }
    
    // MARK: - Functions
    public func configureData(with imageUrl: String, num: Int) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w185\(imageUrl)") else { return }
        movieImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        movieNumLabel.text = "\(num)"
    }
    
    // MARK: - Selectors
    
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            movieImageView.heightAnchor.constraint(equalToConstant: 210),
            movieImageView.widthAnchor.constraint(equalToConstant: 145),
            
            movieNumLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            movieNumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            movieNumLabel.widthAnchor.constraint(equalToConstant: 80),
            movieNumLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
}
// MARK: - Extension
