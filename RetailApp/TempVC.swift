//
//  TempVC.swift
//  RetailApp
//
//  Created by Praveen k G on 26/01/22.
//

import UIKit

class TempVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "tempCellReuseIdentifier")!
//        let prods = self.categories[indexPath.section].products
//        cell.textLabel?.text = prods[indexPath.row].name
        return cell
    }
}
