//
//  NetworkManager.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 17/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let apiKey = "d0ac984349d63f4af1bbea3359b8fdbc"
    
    var delegate: NetworkManagerDelegate?
    
    func fetchPopularMovies() {
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
    
   
}
