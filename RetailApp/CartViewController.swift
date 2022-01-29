//
//  CartViewController.swift
//  RetailApp
//
//  Created by Hritesh on 23/01/22.
//

import UIKit

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
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cartCellReuseIdentifier")!
        let cartProduct = self.cartProducts[indexPath.row]
        print("product name \(cartProduct.product.name)")
        cell.textLabel?.text = cartProduct.product.name + " \(cartProduct.quantity)"
        return cell
    }
}
