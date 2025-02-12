//
//  HomeHeaderCollectionViewCell.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/12.
//

import UIKit

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
        label.font = .systemFont(ofSize: 80)
        label.textColor = .systemIndigo
        label.textAlignment = .center
        label.text = "2"
        label.layer.borderWidth = 2
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
    public func configureData(with image: String, num: Int) {
        movieImageView.image = UIImage(named: image)
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
            movieNumLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            movieNumLabel.widthAnchor.constraint(equalToConstant: 50),
            movieNumLabel.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
}
// MARK: - Extension
