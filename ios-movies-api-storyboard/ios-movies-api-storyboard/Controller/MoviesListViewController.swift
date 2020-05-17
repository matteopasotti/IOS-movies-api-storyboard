//
//  MoviesListViewController.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 17/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import UIKit

class MoviesListViewController: UITableViewController {
    
    var movies = ["Batman", "Jumanji", "Avengers"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieReusableCell")
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = movies[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieReusableCell", for: indexPath) as! MovieCell
        cell.movieTitle.text = title
        
        return cell
        
    }
}
