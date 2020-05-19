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
    
    var networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        self.tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieReusableCell")
        
        loadMovies()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = movies[indexPath.row].title
        let image = movies[indexPath.row].image
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieReusableCell", for: indexPath) as! MovieCell
        cell.movieTitle.text = title
        
        cell.movieImage.downloaded(from: image)
        
        return cell
        
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
