//
//  ProductDetailsViewController.swift
//  RetailApp
//
//  Created by Hritesh on 21/01/22.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var incrementQuantityButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var decrementQuantityButton: UIButton!
    @IBOutlet weak var viewCart: UIButton!
    var product: Product? = nil
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    override func viewDidLoad() {
        self.categoryNameLabel.text = product?.category
        self.productNameLabel.text = product?.name
        if let price = product?.price {
            self.unitPrice.text = "\(String(describing: price))"
        }
        self.incrementQuantityButton.addTarget(self, action: #selector(incrementQuanity), for: .touchUpInside)
        self.decrementQuantityButton.addTarget(self, action: #selector(decrementQuantity), for: .touchUpInside)
        if let cartProduct = CartManager.sharedInstance.getProduct(productId: product!.productId) {
            
                self.quantityLabel.text = "\(String(describing: cartProduct.quantity))"
            
        } else {
            self.quantityLabel.text = "0"
        }
        
        self.viewCart.addTarget(self, action: #selector(viewCartClicked), for: .touchUpInside)
        CartManager.sharedInstance.getProducts()
    }
    
    @objc func incrementQuanity(_ sender: UIButton) {
        print("incrementQuanity")
        CartManager.sharedInstance.addProductToCart(product: product!)
    }
    
    @objc func decrementQuantity(_ sender: UIButton) {
        print("decrementQuanity")
    }
    
    @objc func viewCartClicked(_ sender: UIButton) {
        print("viewCartClicked")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
