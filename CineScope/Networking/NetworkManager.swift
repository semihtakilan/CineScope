//
//  NetworkManager.swift
//  CineScope
//
//  Created by Semih TAKILAN on 23.12.2025.
//  apiKey = "e70c36c3e7fa1b89b3cbf1684d2945ca"

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "e70c36c3e7fa1b89b3cbf1684d2945ca"
    private let baseURL = "https://api.themoviedb.org/3/movie/"
    
    private init() {}
    
    // Hangi listeyi istiyoruz? (Seçenekler)
    enum Endpoint: String {
        case popular = "popular"
        case upcoming = "upcoming"
        case topRated = "top_rated"
        case nowPlaying = "now_playing"
    }
    
    // Artık 'endpoint' parametresi alıyor
    func fetchMovies(from endpoint: Endpoint, completion: @escaping ([Movie]?) -> Void) {
        
        // URL'yi seçilen türe göre oluşturuyoruz
        let urlString = "\(baseURL)\(endpoint.rawValue)?api_key=\(apiKey)&language=tr-TR&page=1"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: data)
                completion(response.results)
            } catch {
                print("JSON Hatası: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
