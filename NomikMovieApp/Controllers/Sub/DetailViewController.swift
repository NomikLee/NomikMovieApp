//
//  DetailViewController.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/14.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Variables
    
    // MARK: - UI Components
    private let detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColor
        view.addSubview(detailTableView)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        detailTableView.frame = view.bounds
    }
    
    // MARK: - Functions
    // MARK: - Selectors
    // MARK: - UI Setup

}
// MARK: - Extension
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
        return cell
    }
}
