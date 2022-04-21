//
//  MovieError.swift
//  StudioGhibliApiTest
//
//  Created by Delstun McCray on 9/15/21.
//

import Foundation

enum MovieError: LocalizedError{
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String?{
        
        switch self{
        
        case .invalidURL:
            return "Unable to reach the server"
        case .thrownError(let error):
            return "Error in \(#function) : \(error.localizedDescription) \n---\n \(error)"
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "There was an error trying to decode the data."
        }
    }
}// End of enum
