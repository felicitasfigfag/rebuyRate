//
//  NetworkManager.swift
//  rebuyRateImg
//
//  Created by Felicitas Figueroa Fagalde on 22.10.22.
//

import UIKit

final class NetworkManager {
    enum NetworkManagerError : Error {
        case invalidURL
    }
    
    let baseUrl : String
    
    init(baseURL: String){
        self.baseUrl = baseURL
    }
    
    func sendRequest <D: Decodable>(route: Routable, decodeTo: D.Type) async throws -> D? {
        
        guard var baseURL = URL(string: self.baseUrl) else {
            throw NetworkManagerError.invalidURL
        }
        
        baseURL.appendPathComponent(route.path)
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw NetworkManagerError.invalidURL
        }
        components.queryItems = route.queryItems

        guard let endpointURL = components.url else {
            throw NetworkManagerError.invalidURL
        }
        
        var request = URLRequest(url: endpointURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = route.httpMethod
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(D.self, from: data)
        
        return result
    }
    
}
