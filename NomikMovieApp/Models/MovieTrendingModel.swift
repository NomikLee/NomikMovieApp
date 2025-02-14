//
//  MovieTrendingModel.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/14.
//

import Foundation

struct MovieTrendingModel: Codable {
    let page: Int
    let results: [Results]
}

struct Results: Codable {
    let backdrop_path: String
    let id: Int
    let title: String
    let original_title: String
    let overview: String
    let poster_path: String
    let media_type: String
    let adult: Bool
    let original_language: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
