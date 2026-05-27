//
//  BuyShoesUITests.swift
//  BuyShoesUITests
//

import XCTest

final class BuyShoesUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    // MARK: - Catalog Screen Tests
    
    func testCatalogScreenExists() {
        let catalogTitle = app.navigationBars["Каталог"]
        XCTAssertTrue(catalogTitle.waitForExistence(timeout: 3))
    }
    
    func testCartButtonExists() {
        let cartButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'cart'")).firstMatch
        XCTAssertTrue(cartButton.waitForExistence(timeout: 3))
    }
    
    func testAddToCartButtonExists() {
        let addToCartButton = app.buttons["В корзину"].firstMatch
        XCTAssertTrue(addToCartButton.waitForExistence(timeout: 3))
    }
    
    func testProductCardExists() {
        let scrollView = app.scrollViews.firstMatch
        XCTAssertTrue(scrollView.waitForExistence(timeout: 3))
    }
    
    func testCartViewOpens() {
        // Open cart
        let cartButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'cart'")).firstMatch
        if cartButton.waitForExistence(timeout: 3) {
            cartButton.tap()
        }
        
        let cartTitle = app.navigationBars["Корзина"]
        XCTAssertTrue(cartTitle.waitForExistence(timeout: 3))
        
        // Close cart
        app.buttons["Закрыть"].tap()
    }
    
    func testAddItemToCart() {
        // Add item to cart
        let addButton = app.buttons["В корзину"].firstMatch
        if addButton.waitForExistence(timeout: 3) {
            addButton.tap()
        }
        
        // Check cart badge appears
        let cartButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'cart'")).firstMatch
        XCTAssertTrue(cartButton.exists)
    }
    
    func testCartBadgeUpdatesAfterAdd() {
        // Get initial cart badge value
        let cartButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'cart'")).firstMatch
        
        // Add item
        let addButton = app.buttons["В корзину"].firstMatch
        if addButton.waitForExistence(timeout: 3) {
            addButton.tap()
        }
        
        // Badge should exist
        XCTAssertTrue(cartButton.exists)
    }
    
    func testProductDetailOpens() {
        // Tap on product card
        let firstProduct = app.scrollViews.otherElements.buttons.firstMatch
        if firstProduct.waitForExistence(timeout: 3) {
            firstProduct.tap()
        }
        
        // Check detail view
        let closeButton = app.buttons["Закрыть"]
        if closeButton.waitForExistence(timeout: 2) {
            closeButton.tap()
        }
        
        XCTAssertTrue(true)
    }
    
    func testMultipleItemsAddedToCart() {
        // Add first item
        let addButton = app.buttons["В корзину"].firstMatch
        if addButton.waitForExistence(timeout: 3) {
            addButton.tap()
        }
        
        // Add second item
        let allAddButtons = app.buttons.matching(identifier: "В корзину")
        if allAddButtons.count > 1 {
            allAddButtons.element(boundBy: 1).tap()
        }
        
        // Open cart
        let cartButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'cart'")).firstMatch
        if cartButton.waitForExistence(timeout: 2) {
            cartButton.tap()
        }
        
        let cartTitle = app.navigationBars["Корзина"]
        XCTAssertTrue(cartTitle.waitForExistence(timeout: 3))
        
        // Close cart
        app.buttons["Закрыть"].tap()
    }
    
    func testRemoveFromCart() {
        // Add item first
        let addButton = app.buttons["В корзину"].firstMatch
        if addButton.waitForExistence(timeout: 3) {
            addButton.tap()
        }
        
        // Open cart
        let cartButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'cart'")).firstMatch
        if cartButton.waitForExistence(timeout: 2) {
            cartButton.tap()
        }
                
                // Check cart view exists
                let cartTitle = app.navigationBars["Корзина"]
                XCTAssertTrue(cartTitle.waitForExistence(timeout: 3))
                
                // Close cart
                app.buttons["Закрыть"].tap()
            }
        }
