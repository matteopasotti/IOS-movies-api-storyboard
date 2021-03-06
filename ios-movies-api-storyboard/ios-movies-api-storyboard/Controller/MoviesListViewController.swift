//
//  MoviesListViewController.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 17/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesListViewController: UITableViewController {
    
    var movies = [Movie]()
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Catalog"
        
        networkManager.delegate = self
        
        tableView.register(CodeMovieCell.self,
        forCellReuseIdentifier: String(describing: CodeMovieCell.self))
        
        loadMovies()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CodeMovieCell.self)) as! CodeMovieCell
        
        cell.titleLabel.text = movie.title
        cell.avgLabel.text = "\(movie.vote_average)/10"
        cell.movieImage.imageDownload(from: movie.image)
        
        return cell
        
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToMovieDetail", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as! MovieDetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.movie = movies[indexPath.row]
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
