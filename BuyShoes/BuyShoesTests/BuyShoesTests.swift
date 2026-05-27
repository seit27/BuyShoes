//
//  BuyShoesTests.swift
//  BuyShoesTests
//

import XCTest
@testable import BuyShoes

final class BuyShoesTests: XCTestCase {
    
    // MARK: - CartManager Tests
    
    func testAddToCart() {
        let cartManager = CartManager()
        let product = Product.sampleProducts[0]
        cartManager.addToCart(product: product)
        XCTAssertEqual(cartManager.itemCount, 1)
    }
    
    func testAddMultipleToCart() {
        let cartManager = CartManager()
        let product = Product.sampleProducts[0]
        cartManager.addToCart(product: product)
        cartManager.addToCart(product: product)
        XCTAssertEqual(cartManager.itemCount, 2)
    }
    
    func testRemoveFromCart() {
        let cartManager = CartManager()
        let product = Product.sampleProducts[0]
        cartManager.addToCart(product: product)
        cartManager.removeFromCart(productId: product.id)
        XCTAssertEqual(cartManager.itemCount, 0)
    }
    
    func testUpdateQuantity() {
        let cartManager = CartManager()
        let product = Product.sampleProducts[0]
        cartManager.addToCart(product: product)
        cartManager.updateQuantity(productId: product.id, quantity: 5)
        XCTAssertEqual(cartManager.cartItems.first?.quantity, 5)
    }
    
    func testTotalPrice() {
        let cartManager = CartManager()
        let product1 = Product.sampleProducts[0]
        let product2 = Product.sampleProducts[1]
        cartManager.addToCart(product: product1)
        cartManager.addToCart(product: product2)
        let expectedTotal = 129.99 + 115.99
        XCTAssertEqual(cartManager.totalPrice, expectedTotal, accuracy: 0.01)
    }
    
    func testClearCart() {
        let cartManager = CartManager()
        let product = Product.sampleProducts[0]
        cartManager.addToCart(product: product)
        cartManager.clearCart()
        XCTAssertEqual(cartManager.itemCount, 0)
    }
    
    func testCartItemCountWithMultipleProducts() {
        let cartManager = CartManager()
        let product1 = Product.sampleProducts[0]
        let product2 = Product.sampleProducts[1]
        cartManager.addToCart(product: product1)
        cartManager.addToCart(product: product1)
        cartManager.addToCart(product: product2)
        XCTAssertEqual(cartManager.itemCount, 3)
    }
    
    // MARK: - Product Tests
    
    func testProductHasValidPrice() {
        let product = Product.sampleProducts[0]
        XCTAssertGreaterThan(product.price, 0)
    }
    
    func testProductHasValidName() {
        let product = Product.sampleProducts[0]
        XCTAssertFalse(product.name.isEmpty)
    }
    
    func testProductHasValidBrand() {
        let product = Product.sampleProducts[0]
        XCTAssertFalse(product.brand.isEmpty)
    }
    
    func testCartTotalPriceAfterRemove() {
        let cartManager = CartManager()
        let product = Product.sampleProducts[0]
        cartManager.addToCart(product: product)
        cartManager.removeFromCart(productId: product.id)
        XCTAssertEqual(cartManager.totalPrice, 0.0)
    }
}

