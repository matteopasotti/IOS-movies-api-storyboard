//
//  ImageDownloading.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 19/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func imageDownload(from url: String) {
        guard let url = URL(string: url) else { return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: UIImage(named: "placeholder_dark"), options: [
        .scaleFactor(UIScreen.main.scale),
        .transition(.fade(1)),
        .cacheOriginalImage], progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
    }
}
