//
//  Films.swift
//  StudioGhibliApiTest
//
//  Created by Delstun McCray on 9/15/21.
//

import Foundation

struct Film: Codable {
    let id: String
    let title: String
    let originalTitle: String
    let originalTitleRomanised: String
    let filmDescription: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
        case originalTitleRomanised = "original_title_romanised"
        case filmDescription = "description"
        case releaseDate = "release_date"

    }
}// End of struct

