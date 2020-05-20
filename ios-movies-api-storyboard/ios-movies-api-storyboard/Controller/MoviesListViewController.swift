//
//  MoviesListViewController.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 17/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import UIKit

class MoviesListViewController: UITableViewController {
    
    var movies = [Movie]()
    
    var movieSelected: Movie?
    
    var networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Catalog"
        
        networkManager.delegate = self
        self.tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieReusableCell")
        
        loadMovies()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieReusableCell", for: indexPath) as! MovieCell
        cell.movieTitle.text = movie.title
        cell.voteAverage.text = "\(movie.vote_average)/10"
        
        cell.movieImage.downloaded(from: movie.image)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = movies[indexPath.row]
        self.performSegue(withIdentifier: "goToMovieDetail", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMovieDetail" {
            let destination = segue.destination as! MovieDetailViewController
            destination.movie = movieSelected
        }
    }
    
    func loadMovies() {
        networkManager.fetchPopularMovies()
    }
}

//MARK: -NetworkManagerDelegate
extension MoviesListViewController: NetworkManagerDelegate {
    
    func success(data: [Movie]) {
        self.movies = data
        self.tableView.reloadData()
    }
    
    func error(error: Error) {
        print(error)
    }
    
    
}
