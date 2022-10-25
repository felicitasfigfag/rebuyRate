//
//  NetworkService.swift
//  rebuyRateImg
//
//  Created by Felicitas Figueroa Fagalde on 22.10.22.
//

import Foundation

enum RateImgService {
    
    static let manager = NetworkManager(baseURL: baseURL)
    
    static let baseURL = "https://dummyjson.com/"
    
}

