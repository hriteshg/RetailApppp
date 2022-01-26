//
//  CartManager.swift
//  RetailApp
//
//  Created by Hritesh on 23/01/22.
//

import Foundation

final class CartManager: NSObject {
    static let sharedInstance = CartManager()
    var cartProducts: [Int: CartProduct] = [:]
     private override init() { }

    func addProductToCart(product: Product) {
        print("addProductToCart \(product.productId)")
        if (cartProducts[product.productId] == nil) {
            cartProducts[product.productId] = CartProduct(product: product, quantity: 1)
        } else {
            let cartProduct = cartProducts[product.productId]
            cartProduct?.quantity = cartProduct!.quantity + 1
        }
    }
    
    func deleteProductFromCart(product: Product) {
        cartProducts.removeValue(forKey: product.productId)
    }
    
    func getProducts() -> [CartProduct] {
        var result: [CartProduct] = []
        print("getProducts \(cartProducts.keys)")
        for value in cartProducts.values {
            print("getProducts \(value.product.productId)")
            print("getProducts \(value.product.name)")
            result.append(value)
        }
        return result
    }
}
