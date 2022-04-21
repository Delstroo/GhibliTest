//
//  MovieCollectionViewCell.swift
//  StudioGhibliApiTest
//
//  Created by Delstun McCray on 9/15/21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    //this is to hepl with github
    
    var movie: Movie?
    var film: Film? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    func updateViews() {
        self.movieImageView.image = UIImage(named: "placeholder")

        guard let film = film else { return }
        
        MovieAPIController.fetchMovies(with: film.originalTitle) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.fetchPoster(for: movie[0])
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }//end of func
    
    func fetchPoster(for movie: Movie) {
        MovieAPIController.fetchMoviePoster(with: movie.posterImage) { [weak self]result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.movieImageView.image = image
                    self?.movieImageView.contentMode = .scaleAspectFill
                case .failure(_):
                    self?.movieImageView.image = UIImage(systemName: "square")
                 
                }
            }
        }
    }//end of func
    
}//end of class
