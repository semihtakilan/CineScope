//
//  Movie.swift
//  CineScope
//
//  Created by Semih TAKILAN on 23.12.2025.
//

import Foundation

// API'den gelen ana cevap
struct MovieResponse: Codable, Sendable {
    let results: [Movie]
}

// Film Modeli
struct Movie: Codable, Sendable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
}

// YENİ: Kategori Modeli (ViewController'da kullanacağız)
struct MovieCategory {
    let title: String
    let movies: [Movie]
}
