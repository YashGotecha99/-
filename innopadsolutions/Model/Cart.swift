//
//  Cart.swift
//  innopadsolutions
//
//  Created by Yash.Gotecha on 30/05/24.
//

import Foundation

class Cart: ObservableObject {
    static let shared = Cart()
    @Published var products: [Products] = []
    
    func addToCart(product: Products) {
        products.append(product)
    }
    
    func removeFromCart(product: Products) {
        products.removeAll { $0.id == product.id }
    }
    
    func contains(product: Products) -> Bool {
        return products.contains { $0.id == product.id }
    }
    
    func toggleCartStatus(product: Products) {
        if contains(product: product) {
            removeFromCart(product: product)
        } else {
            addToCart(product: product)
        }
    }
}


