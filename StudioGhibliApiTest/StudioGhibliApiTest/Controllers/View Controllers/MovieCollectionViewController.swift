//
//  MovieCollectionViewController.swift
//  StudioGhibliApiTest
//
//  Created by Delstun McCray on 9/15/21.
//

import UIKit

class MovieCollectionViewController: UICollectionViewController {
    
    var films: [Film] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        fetchFilms()
        
        print(films.count)
        
        
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        collectionView.reloadData()
    }
    
    func fetchFilms() {
        StudioGhibliAPIController.fetchFilms { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let films):
                    self.films = films
                    self.collectionView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    //    override func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        print("Number of films in collections is \(films.count)")
    //        return films.count
    //    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("Number of films in collections is \(films.count)")
        return films.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        
        let film = films[indexPath.row]
        
        cell.film = film
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            guard let cell = sender as? MovieCollectionViewCell,
                  let indexPath = collectionView.indexPath(for: cell),
                  let destination = segue.destination as? MovieDetailViewController else { return }
            let filmToSend = films[indexPath.row]
            destination.film = filmToSend
        }
    }
    
}//end of class

//MARK: - Extensions
extension MovieCollectionViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = view.frame.width * 0.45
//
//        return CGSize(width: width, height: width * 4 / 3)
//    }//end of func
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let width = view.frame.width * 0.45
        
        let cellTotalWidth = width * 2
        
        let leftOverWidth = view.frame.width - cellTotalWidth
        
        let inset = leftOverWidth / 3
        
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
}


