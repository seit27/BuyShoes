//
//  Models.swift
//  BuyShoes
//

import Foundation
import SwiftUI

// MARK: - User Model
struct User: Identifiable {
    let id = UUID()
    let email: String
    let password: String
}

// MARK: - Product Model
struct Product: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let brand: String
    let imageName: String
    let description: String
}

// MARK: - Cart Item Model
struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
}

// MARK: - Sample Data
extension Product {
    static let sampleProducts = [
        Product(
            name: "Nike Air Max 90",
            price: 129.99,
            brand: "Nike",
            imageName: "sneaker1",
            description: "Классические кроссовки с воздушной подушкой"
        ),
        Product(
            name: "Nike Dunk Low",
            price: 115.99,
            brand: "Nike",
            imageName: "sneaker2",
            description: "Стильные низкие кроссовки в ретро-стиле"
        ),
        Product(
            name: "Nike Air Force 1",
            price: 110.00,
            brand: "Nike",
            imageName: "sneaker3",
            description: "Легендарные кроссовки с безупречным дизайном"
        ),
        Product(
            name: "Nike Zoom Vomero 5",
            price: 159.99,
            brand: "Nike",
            imageName: "sneaker4",
            description: "Максимальная амортизация для комфорта"
        )
    ]
}
