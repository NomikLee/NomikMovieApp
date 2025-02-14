//
//  HomeViewController.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/12.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    
    // MARK: - Variables
    private let selectionBarView = SelectionBarView()
    private let viewModel = HomeMovieListViewModel()
    private lazy var homeHeaderView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 300))
    
    private var searchBar: UISearchController!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI Components
    private let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .mainColor
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: -50, y: 13, width: 250, height: 50))
        label.text = "你有喜歡的電影嗎？"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 31)
        label.sizeToFit()
        return label
    }()
    
    private let titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 44))
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(homeTableView)
        titleView.addSubview(titleLabel)
        
        homeTableView.tableHeaderView = homeHeaderView
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        
        navigationItem.titleView = titleView
        
        setSearch()
//        bindView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.bounds
    }
    
    // MARK: - Functions
    private func bindView() {
        viewModel.fechMovieTrending()
        viewModel.fechMoveLists(to: "Now Playing")
        
        viewModel.$movieTrendings.receive(on: DispatchQueue.main)
            .sink { [weak self] datas in
                if let viewModel = datas {
                    self?.homeHeaderView.bindView(to: viewModel)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$movieLists.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.homeTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setSearch() {
        searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchResultsUpdater = self
        searchBar.obscuresBackgroundDuringPresentation = false
        
        searchBar.searchBar.searchTextField.backgroundColor = .brown
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray, // Placeholder 文字顏色
            .font: UIFont.systemFont(ofSize: 20) // Placeholder 字體大小
        ]
        searchBar.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "搜尋電影...", attributes: attributes)
        
        let searchIcon = UIImage(systemName: "magnifyingglass.circle.fill")
        let clearIcon = UIImage(systemName: "xmark.circle.fill")
        
        searchBar.searchBar.setImage(searchIcon, for: .search, state: .normal)
        searchBar.searchBar.setImage(clearIcon, for: .clear, state: .normal)
        searchBar.searchBar.searchTextField.tintColor = .lightGray
        
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false  // 讓搜尋欄固定顯示
        definesPresentationContext = true
    }
    
    // MARK: - Selectors
    
    // MARK: - UI Setup

}
// MARK: - Extension
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        selectionBarView.selectionBarTap.receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                self?.viewModel.fechMoveLists(to: name)
            }
            .store(in: &cancellables)
        
        return selectionBarView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        if let movieLists = viewModel.movieLists {
            cell.configureData(to: movieLists)
        }
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

extension HomeViewController: DetailTableViewCellDelegate {
    func didSelectItem(_ item: String) {
        let detail = DetailViewController()
        detail.title = item
        navigationController?.pushViewController(detail, animated: true)
    }
}
