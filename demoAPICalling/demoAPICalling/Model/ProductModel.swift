//
//  ProductModel.swift
//  demoAPICalling
//
//  Created by apple on 03/02/24.
//

import Foundation
// MARK: - Welcome
struct Product: Codable {
    let products: [ProductDetails]
    let total, skip, limit: Int
}

// MARK: - Product
struct ProductDetails: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
