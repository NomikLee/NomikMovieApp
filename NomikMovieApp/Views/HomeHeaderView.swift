//
//  HomeHeaderView.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/12.
//

import UIKit
import Combine

class HomeHeaderView: UIView {

    // MARK: - Variables
    var viewModel: MovieTrendingModel?
    
    // MARK: - UI Components
    private let headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeHeaderCollectionViewCell.self, forCellWithReuseIdentifier: HomeHeaderCollectionViewCell.identifier)
        collectionView.backgroundColor = .mainColor
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerCollectionView)
        
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerCollectionView.frame = bounds
    }
    
    // MARK: - Functions
    public func bindView(to viewModel: MovieTrendingModel) {
        self.viewModel = viewModel
    
        DispatchQueue.main.async {
            self.headerCollectionView.reloadData()
        }
    }
    
    // MARK: - Selectors
    // MARK: - UI Setup
    
}
// MARK: - Extension
extension HomeHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeHeaderCollectionViewCell.identifier, for: indexPath) as? HomeHeaderCollectionViewCell else { return UICollectionViewCell()}
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        
        cell.configureData(with: viewModel?.results[indexPath.item].poster_path ?? "", num: (indexPath.item + 1))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 250)
    }
}


