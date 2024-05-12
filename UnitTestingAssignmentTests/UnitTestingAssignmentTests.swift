//
//  UnitTestingAssignmentTests.swift
//  UnitTestingAssignmentTests
//
//  Created by Bakar Kharabadze on 5/12/24.
//

import XCTest
@testable import UnitTestingAssignment

final class UnitTestingAssignmentTests: XCTestCase {
    
    var cartViewModel: CartViewModel!
    
    override func setUpWithError() throws {
        cartViewModel = CartViewModel()
    }
    
    override func tearDownWithError() throws {
        cartViewModel = nil
    }
    
    // Mark - Testing Functions
    func testSelectedItemsQuantity() {
        
        // Given
        let product1 = Product(id: 1, title: "Product 1", description: "First product", price: 10.0, selectedQuantity: 2)
        let product2 = Product(id: 2, title: "Product 2", description: "Second product", price: 20.0, selectedQuantity: 3)
        cartViewModel.selectedProducts = [product1, product2]
        
        // When
        let result = cartViewModel.selectedItemsQuantity
        
        // Then
        XCTAssertEqual(result, 5)
        
    }
    
    func testTotalPrice() {
        
        // Given
        let product1 = Product(id: 1, title: "product 1", description: "first product", price: 10.0, selectedQuantity: 2)
        let product2 = Product(id: 2, title: "Product 2", description: "Second product", price: 20.0, selectedQuantity: 3)
        cartViewModel.selectedProducts = [product1, product2]
        
        // When
        let result = cartViewModel.totalPrice
        
        // Then
        XCTAssertEqual(result, 80)
    }
    
    func testAddProductWithId() {
        
        // Given
        let product1 = Product(id: 100, title: "product 1", description: "first product", price: 10.0, selectedQuantity: 2)
        cartViewModel.allproducts = [product1]
    
        // When
        cartViewModel.addProduct(withID: 100)
        
        // Then
        XCTAssertNotNil(cartViewModel.selectedProducts.first(where: { $0.id == product1.id }))
    }
    
    func testAddProductWithProduct() {
        
        // Given
        let product1 = Product(id: 55, title: "product 1", description: "first product", price: 10.0, selectedQuantity: 2)
        
        // When
        cartViewModel.addProduct(product: product1)
        
        // Then
        XCTAssertEqual(cartViewModel.selectedProducts.count, 1)
        XCTAssertNotNil(cartViewModel.selectedProducts.first(where: { $0.id == product1.id }))
    }
    
    func testAddRandomProduct() {
        
        // Given
        let product1 = Product(id: 55, title: "product 1", description: "first product", price: 10.0, selectedQuantity: 2)
        let product2 = Product(id: 100, title: "product 2", description: "second product", price: 10.0, selectedQuantity: 2)
        cartViewModel.allproducts = [product1, product2]
        
        // When
        cartViewModel.addRandomProduct()
        
        // Then
        XCTAssertFalse(cartViewModel.selectedProducts.isEmpty)
        XCTAssertTrue(cartViewModel.allproducts!.contains { $0.id == cartViewModel.selectedProducts.first?.id })
    }
    
    func testRemoveProduct() {
        
        // Given
        let product1 = Product(id: 55, title: "product 1", description: "first product", price: 10.0, selectedQuantity: 2)
        let product2 = Product(id: 100, title: "product 2", description: "second product", price: 10.0, selectedQuantity: 2)
        cartViewModel.selectedProducts = [product1, product2]
        
        // When
        cartViewModel.removeProduct(withID: 55)
        
        // Then
        XCTAssertFalse(cartViewModel.selectedProducts.contains { $0.id == 55 })
        XCTAssertTrue(cartViewModel.selectedProducts.contains { $0.id == 100 })
    }
    
    func testClearCart() {
        
        // Given
        let product1 = Product(id: 55, title: "product 1", description: "first product", price: 10.0, selectedQuantity: 2)
        let product2 = Product(id: 100, title: "product 2", description: "second product", price: 10.0, selectedQuantity: 2)
        let product3 = Product(id: 003, title: "product 3", description: "third product", price: 10.0, selectedQuantity: 2)
        let product4 = Product(id: 230, title: "product 4", description: "forth product", price: 10.0, selectedQuantity: 2)
        cartViewModel.selectedProducts = [product1, product2, product3, product4]
        
        // When
        cartViewModel.clearCart()
        
        // Then
        XCTAssertTrue(cartViewModel.selectedProducts.isEmpty)
        
    }
    
    func testFetchProducts() {
           // Given
           let expectation = XCTestExpectation(description: "Fetch products")
           
           // When
           cartViewModel.fetchProducts()
           
           // Then
           DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               XCTAssertNotNil(self.cartViewModel.allproducts)
               XCTAssertFalse(self.cartViewModel.allproducts?.isEmpty ?? true)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 2.0)
       }
}
