//
//  Movie.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 17/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import Foundation
import RealmSwift


struct Movies : Decodable {
    let results: [Movie]
}

class Movie: Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var title: String
    @objc dynamic var overview: String
    @objc dynamic var poster_path: String?
    @objc dynamic var vote_average: Double
    @objc dynamic var image: String {
        if poster_path != nil {
            return "http://image.tmdb.org/t/p/w780\(poster_path!)"
        } else {
            return ""
        }
        
    }
}
