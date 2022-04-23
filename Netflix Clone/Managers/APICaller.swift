//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Михаил on 23.02.2022.
//

import Foundation

struct constants {
    static let API_KEY = "521e400b2a9273919fb6f6747bfc73d6"
    static let baseURL = "https://api.themoviedb.org"
    static let youTubeAPI_KEY = "AIzaSyC1mKO5LMmirgP2wma1iBu8h2WLanN2CDs"
    static let youTubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search"
}

enum APIError: Error {
    case failedToGetData
    
}

class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(constants.baseURL)/3/trending/movie/day?api_key=\(constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getTrendingsTvs(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(constants.baseURL)/3/trending/tv/day?api_key=\(constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getUpCommingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(constants.baseURL)/3/movie/upcoming?api_key=\(constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                
                completion(.success(results.results))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(constants.baseURL)/3/movie/popular?api_key=\(constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                
                completion(.failure(error))
                
            }
        }
        task.resume()
    }
    
   func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(constants.baseURL)/3/movie/top_rated?api_key=\(constants.API_KEY)&language=en-US&page=1") else { return }
       let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                
                completion(.failure(error))
                
            }
        }
       task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(constants.baseURL)/3/discover/movie?api_key=\(constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
               
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(error))
                
            }
        }
       task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        
        guard let url = URL(string: "\(constants.baseURL)/3/search/movie?api_key=\(constants.API_KEY)&query=\(query)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                
                completion(.failure(error))
                
            }
        }
       task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        guard let url = URL(string: "\(constants.youTubeBaseUrl)?q=\(query)&key=\(constants.youTubeAPI_KEY)") else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(YouTubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
                
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
                
            }
        }
       task.resume()
    }
}
