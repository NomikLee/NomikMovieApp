//
//  HomeTableViewCell.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/12.
//

import UIKit

protocol DetailTableViewCellDelegate: AnyObject {
    func didSelectItem(_ item: String) // 定義點擊事件
}

class HomeTableViewCell: UITableViewCell {

    static let identifier = "HomeTableViewCell"
    
    // MARK: - Variables
    private var movieLists: MovieListModel?
    weak var delegate: DetailTableViewCellDelegate?
    
    // MARK: - UI Components
    private let movieListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 11
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .mainColor
        collectionView.register(HomeMovieListCollectionViewCell.self, forCellWithReuseIdentifier: HomeMovieListCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .mainColor
        contentView.addSubview(movieListCollectionView)
        
        movieListCollectionView.delegate = self
        movieListCollectionView.dataSource = self
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    public func configureData(to movieLists: MovieListModel) {
        self.movieLists = movieLists
        
        DispatchQueue.main.async {
            self.movieListCollectionView.reloadData()
        }
    }
    
    // MARK: - Selectors
    
    // MARK: - UI Setup
    private func configureUI() {
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            movieListCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieListCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
}
// MARK: - Extension
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieLists?.results.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieListCollectionViewCell.identifier, for: indexPath) as? HomeMovieListCollectionViewCell else { return UICollectionViewCell() }
        cell.configureData(with: movieLists?.results[indexPath.item].posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem("ddd")
    }
}

extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (contentView.bounds.width / 3) - 8
        return CGSize(width: size, height: 200)
    }
}
