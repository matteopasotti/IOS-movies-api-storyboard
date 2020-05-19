//
//  NetworkManagerDelegate.swift
//  ios-movies-api-storyboard
//
//  Created by Matteo Pasotti on 19/05/2020.
//  Copyright © 2020 Matteo Pasotti. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate {
    func success(data: [Movie])
    func error(error: Error)
}
