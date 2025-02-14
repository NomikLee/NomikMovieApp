//
//  APIService.swift
//  NomikMovieApp
//
//  Created by Nomik on 2025/2/12.
//

import Foundation

class APIService {
    
    static let shard = APIService()
    
    private init() {}
    
    struct Constants {
        static let baseURL = "https://api.themoviedb.org/3"
        static let apiKey = ""
    }
    
    //取得電影清單
    func getMoveLists(to listName: String, completion: @escaping (Result<MovieListModel, Error>) -> Void) {
        var urlComponents: URLComponents?
        
        let queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        
        switch listName {
        case "Now Playing":
            urlComponents = URLComponents(string: Constants.baseURL + "/movie/now_playing")
        case "Popular":
            urlComponents = URLComponents(string: Constants.baseURL + "/movie/popular")
        case "Top Rated":
            urlComponents = URLComponents(string: Constants.baseURL + "/movie/top_rated")
        case "Upcoming":
            urlComponents = URLComponents(string: Constants.baseURL + "/movie/upcoming")
        default:
            break
        }

        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let moveListDatas = try JSONDecoder().decode(MovieListModel.self, from: data)
                completion(.success(moveListDatas))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    //取得當日趨勢電影清單
    func getTrendingMovieList(completion: @escaping(Result<MovieTrendingModel, Error>) -> Void) {
        var urlComponent = URLComponents(string: Constants.baseURL + "/trending/movie/day")
        
        let queryItems = [
            URLQueryItem(name: "language", value: "en-US")
        ]
        
        urlComponent?.queryItems = queryItems
        
        guard let url = urlComponent?.url else { return }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let trendingMovieData = try JSONDecoder().decode(MovieTrendingModel.self, from: data)
                completion(.success(trendingMovieData))
            } catch {
                completion(.failure(error))
            }
        }
        .resume()
    }
    
//    https://api.themoviedb.org/3/movie/{movie_id}
//    https://api.themoviedb.org/3/movie/{movie_id}/credits
}
