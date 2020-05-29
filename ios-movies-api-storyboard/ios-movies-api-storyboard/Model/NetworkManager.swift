//
//  NetworkManager.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 17/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import Foundation
import RealmSwift

class NetworkManager {
    
    let apiKey = "d0ac984349d63f4af1bbea3359b8fdbc"
    
    var delegate: NetworkManagerDelegate?
    
    let realm = try! Realm()
    
    var movies : Results<Movie>?
    
    let userDefaults = UserDefaults.standard
    
    let dateFormat = "dd/MM/yyyy"
    
    func fetchPopularMovies() {
        
        let lastDateSync = userDefaults.string(forKey: "lastDateSync")
        
        if lastDateSync != nil && lastDateSync == getCurrentDate() {
            movies = getMoviesFromDB()
            DispatchQueue.main.async {
                let moviesArray = self.movies!.toArray(ofType: Movie.self) as [Movie]
                self.delegate?.success(data: moviesArray)
            }
        } else {
            getMoviesFromAPI()
        }
        
    }
    
    func getMoviesFromAPI() {
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        if  let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let items = try decoder.decode(Movies.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                self.deleteMoviesFromDB()
                                self.userDefaults.setValue(self.getCurrentDate(), forKey: "lastDateSync")
                                self.saveMoviesIntoDB(movies: items.results)
                                self.delegate?.success(data: items.results)
                            }
                        } catch {
                            self.delegate?.error(error: error)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    
    func getMoviesFromDB() -> Results<Movie>? {
        return realm.objects(Movie.self)
    }
    
    func saveMoviesIntoDB(movies: [Movie]) {
        do {
            try realm.write {
                realm.add(movies)
            }
        } catch {
            print("Error saving movies, \(error)")
        }
        
    }
    
    func deleteMoviesFromDB() {
        do {
            
            let allMovies = realm.objects(Movie.self)
            
            try realm.write {
                realm.delete(allMovies)
            }
        } catch {
            print("Error deleting movies, \(error)")
        }
    }
    
    func getCurrentDate() -> String {
        let df = DateFormatter()
        df.dateFormat = dateFormat
        return df.string(from: Date())
    }
   
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
