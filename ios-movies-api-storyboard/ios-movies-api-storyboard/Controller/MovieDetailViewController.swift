//
//  MovieDetailViewController.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 19/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let safeMovie = movie {
            movieImage.downloaded(from: safeMovie.image)
            movieTitle.text = safeMovie.title
            movieOverview.text = safeMovie.overview
        }
        
    }
}
