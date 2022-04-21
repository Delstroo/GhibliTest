//
//  Movie.swift
//  StudioGhibliApiTest
//
//  Created by Delstun McCray on 9/15/21.
//

import Foundation

struct MovieTopLevelObject:Decodable {
    let page: Int
    let results: [Movie]
}

struct Movie: Decodable{
    
    let movieTitle: String
    let posterImage: URL
    let overview: String
    let rating: Double
    let id: Int
    
    enum CodingKeys: String, CodingKey{
        case movieTitle = "original_title"
        case posterImage = "poster_path"
        case overview = "overview"
        case rating = "vote_average"
        case id = "id"
        
    }
}
