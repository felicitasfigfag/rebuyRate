//
//  Models.swift
//  rebuyRateImg
//
//  Created by Felicitas Figueroa Fagalde on 22.10.22.
//

import UIKit

struct Products: Codable{
    let products: [Product]
}
struct Product: Codable, Identifiable{
    let id: Int
    let title: String
    let images: [String]
}

protocol Routable {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var httpMethod: String { get }
}

enum ProductRoute: Routable {
    case allProducts
    case base([Filters])
    
    var path: String {
        switch self {
            case .allProducts:
                return "products"
            case .base(_):
                return "products"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .allProducts:
            return nil
        case .base(let filters):
            return filters.map { $0.queryItem() }
        }
    }
    
    var httpMethod: String {
        switch self {
            case .allProducts:
                return "GET"
            case .base:
                return "GET"
        }
    }

    static func getAllProducts() async throws -> Products? {
        return try await RateImgService.manager.sendRequest(route: Self.allProducts, decodeTo: Products.self)
    }
    
    static func searchWith(filters: [Filters]) async throws -> Products? {
        return try await RateImgService.manager.sendRequest(route: Self.base(filters), decodeTo: Products.self)

    }
}


enum Filters {
    case limit(Int)
    case page(String)

    func queryItem() -> URLQueryItem {
        switch self {
            case .limit(let limit):
                return URLQueryItem(name: "limit", value: "\(limit)")
            case .page(let page):
                return URLQueryItem(name: "page", value: "\(page)")

        }
    }
}

enum NetworkManagerError : Error {
    case downloadingError
}
