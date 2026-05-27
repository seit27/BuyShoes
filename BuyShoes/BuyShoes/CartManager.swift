//
//  CartManager.swift
//  BuyShoes
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class CartManager: ObservableObject {
    @Published var cartItems: [CartItem] = []
    
    var totalPrice: Double {
        cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    var itemCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }
    
    func addToCart(product: Product) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, quantity: 1))
        }
    }
    
    func removeFromCart(productId: UUID) {
        cartItems.removeAll { $0.product.id == productId }
    }
    
    func updateQuantity(productId: UUID, quantity: Int) {
        if let index = cartItems.firstIndex(where: { $0.product.id == productId }) {
            if quantity <= 0 {
                cartItems.remove(at: index)
            } else {
                cartItems[index].quantity = quantity
            }
        }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}
