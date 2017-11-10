//
//  CrayonListViewController.swift
//  AC-iOS-Unit2Final
//
//  Created by C4Q on 11/10/17.
//  Copyright © 2017 Karen Fuentes. All rights reserved.
//

import UIKit

class CrayonListViewController: UIViewController {

    @IBOutlet weak var crayonListTableView: UITableView!
    
    //Data Source Variable
    var allCrayons: [Crayon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        crayonListTableView.delegate = self
        crayonListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        crayonListTableView.reloadData()
    }
    
    //Setup
    func loadData() {
        allCrayons = Crayon.allTheCrayons
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentCell = sender as? CrayonTableViewCell, let destinationVC = segue.destination as? CrayonDetailTableViewController {
            let currentCrayon = allCrayons[crayonListTableView.indexPath(for: currentCell)!.row]
            
            destinationVC.defaultColor = currentCrayon
        }
    }
}

//MARK: - Table View Methods
extension CrayonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        performSegue(withIdentifier: "detailedSegue", sender: selectedCell)
    }
    
    //Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCrayons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "crayonCell", for: indexPath)
        let currentCrayon = allCrayons[indexPath.row]
        let currentRed = CGFloat(currentCrayon.red/255)
        let currentGreen = CGFloat(currentCrayon.green/255)
        let currentBlue = CGFloat(currentCrayon.blue/255)
        
        let oppositeRed = (1 - currentRed) / 1.35
        let oppositeGreen = (1 - currentGreen) / 1.35
        let oppositeBlue = (1 - currentBlue) / 1.35
        
        if let crayonCell = cell as? CrayonTableViewCell {
            
            crayonCell.colorNameLabel.text = currentCrayon.name
            crayonCell.colorNameLabel.textColor = UIColor(displayP3Red: oppositeBlue, green: oppositeGreen, blue: oppositeRed, alpha: 1)
            crayonCell.crayonImageView.image = #imageLiteral(resourceName: "transparentCrayon")
            crayonCell.backgroundColor = UIColor(displayP3Red: currentRed, green: currentGreen, blue: currentBlue, alpha: 1)
            
            //if hex
            crayonCell.decimalHexLabel.text = "Hex: \(currentCrayon.hex)"
            
            //if decimal
//            crayonCell.decimalHexLabel.text = "Decimal: (\(currentCrayon.red), \(currentCrayon.green), \(currentCrayon.blue))"
            
            crayonCell.decimalHexLabel.textColor = UIColor(displayP3Red: oppositeBlue, green: oppositeGreen, blue: oppositeRed, alpha: 1)
            
            return crayonCell
        }
        
        return cell
    }
    
}
