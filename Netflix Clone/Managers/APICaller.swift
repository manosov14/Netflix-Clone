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
}
