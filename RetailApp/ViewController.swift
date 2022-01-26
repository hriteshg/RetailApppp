//
//  ViewController.swift
//  RetailApp
//
//  Created by Hritesh on 21/01/22.
//

import UIKit

class Product {
    let productId: Int
    let name: String
    let category: String
    let price: Int
    
    public init(name: String, category: String, productId: Int, price: Int) {
        self.name = name
        self.category = category
        self.productId = productId
        self.price = price
    }
}

class Category: Equatable {
    var name: String = ""
    var products: [Product] = []
    
    init(name: String) {
        self.name = name
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.name == rhs.name
    }
}

class CartProduct {
    var product: Product
    var quantity: Int
    
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
    
    func incrementQuantity() {
        self.quantity = self.quantity + 1
    }
}

class Cart {
    var products: [CartProduct] = []
}

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var categories: [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        readFile()
    }

    func readFile() {
        print("readFile")
        if let path = Bundle.main.path(forResource: "products", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  print("jsonResult \(jsonResult)")
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let products = jsonResult["products"] as? [AnyObject] {
                    print("products \(products)")
                    for prod in products {
                        let result = Product(name: prod["name"] as! String, category: prod["category"] as! String, productId: prod["id"] as! Int, price: prod["price"] as! Int)
                        let category = Category(name: result.category)
                        if let index = self.categories.firstIndex(of: category) {
                            let categoryToUpdate = self.categories[index]
                            categoryToUpdate.products.append(result)
                        } else {
                            category.products.append(result)
                            self.categories.append(category)
                        }
                    }
                    print("categories \(categories)")
                  }
              } catch {
                   // handle error
                    print("Unexpected error: \(error).")

              }
        }
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories[section].products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProductTableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as? ProductTableViewCell ?? nil)!
        let prods = self.categories[indexPath.section].products
        cell.productTitle?.text = prods[indexPath.row].name
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TempVC") as! TempVC
//        vc.product = self.categories[indexPath.section].products[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.categories[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categories.count
    }
}

