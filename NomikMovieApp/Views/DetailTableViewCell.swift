//
//  DetailTableViewCell.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/14.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    static let identifier = "DetailTableViewCell"
    
    // MARK: - Variables
    
    // MARK: - UI Components
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .mainColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Functions
    // MARK: - Selectors
    // MARK: - UI Setup

}
// MARK: - Extension
