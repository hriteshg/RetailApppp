//
//  ProductDetailsViewController.swift
//  RetailApp
//
//  Created by Hritesh on 21/01/22.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var viewCart: UIButton!
    var product: Product? = nil
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    override func viewDidLoad() {
        self.categoryNameLabel.text = product?.category
        self.productNameLabel.text = product?.name
        self.unitPrice.text = "\(String(describing: product?.price))" 
        self.addToCart.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
        self.viewCart.addTarget(self, action: #selector(viewCartClicked), for: .touchUpInside)
    }
    
    @objc func didButtonClick(_ sender: UIButton) {
        print("onAddToCartClicked")
        CartManager.sharedInstance.addProductToCart(product: product!)
    }
    
    @objc func viewCartClicked(_ sender: UIButton) {
        print("viewCartClicked")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
