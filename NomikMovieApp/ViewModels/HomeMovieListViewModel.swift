//
//  HomeMovieListViewModel.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/14.
//

import Foundation

class HomeMovieListViewModel: ObservableObject {
    @Published var movieLists: MovieListModel?
    @Published var movieTrendings: MovieTrendingModel?
    
    func fechMoveLists(to listName: String) {
        APIService.shard.getMoveLists(to: listName) { [weak self] results in
            switch results {
            case .success(let datas):
                self?.movieLists = datas
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fechMovieTrending() {
        APIService.shard.getTrendingMovieList { [weak self] results in
            switch results {
            case .success(let datas):
                self?.movieTrendings = datas
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
