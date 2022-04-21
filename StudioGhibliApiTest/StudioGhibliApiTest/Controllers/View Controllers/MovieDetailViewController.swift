//
//  MovieDetailViewController.swift
//  StudioGhibliApiTest
//
//  Created by Delstun McCray on 9/15/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    //MARK: - Properties
    var film: Film?
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        blur()
        
    }
    
    func updateViews() {
        
        guard let film = film else { return }
        let underlineAttriString = NSAttributedString(string: film.title,
                                                  attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
            filmTitleLabel.attributedText = underlineAttriString
        releaseDateLabel.text = film.releaseDate
        synopsisLabel.text = film.filmDescription
        
        MovieAPIController.fetchMovies(with: film.originalTitle) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movie):
                    self.fetchPoster(for: movie[0])
                case .failure(_):
                    self.filmImageView.image = UIImage(named: "placeholder")

                  
                }
            }
        }
    }//end of func
    
    func fetchPoster(for movie: Movie) {
        
        MovieAPIController.fetchMoviePoster(with: movie.posterImage) { [weak self]result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.view.backgroundColor = UIColor(patternImage: image)
                    self?.view.contentMode = .scaleAspectFill
                    self?.filmImageView.image = image
                    self?.filmImageView.contentMode = .scaleAspectFill
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }//end of func
    
    func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blueEffectView = UIVisualEffectView(effect: blurEffect)
        
        blueEffectView.frame = view.bounds
        blueEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blueEffectView, at: 0)
        
        
        
    }
    
    
}
