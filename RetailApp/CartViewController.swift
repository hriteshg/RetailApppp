//
//  CartViewController.swift
//  RetailApp
//
//  Created by Hritesh on 23/01/22.
//

import UIKit


class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var cartProducts: [CartProduct] = []
    override func viewDidLoad() {
        print("CartViewController")
        super.viewDidLoad()
        self.cartProducts = CartManager.sharedInstance.getProducts()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.cartProducts = CartManager.sharedInstance.getProducts()
        self.tableView.reloadData()
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CartTableViewCell = ((self.tableView.dequeueReusableCell(withIdentifier: "cartCellReuseIdentifier") as? CartTableViewCell)!)
        let cartProduct = self.cartProducts[indexPath.row]
        print("product name \(cartProduct.product.name)")
        cell.productTitle?.text = cartProduct.product.name + " \(cartProduct.quantity)"
        cell.productDescription?.text = "This is decription"
        cell.productPrice?.text = "$ 100"
        return cell
    }
}


