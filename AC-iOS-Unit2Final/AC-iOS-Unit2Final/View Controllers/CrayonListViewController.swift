//
//  CrayonListViewController.swift
//  AC-iOS-Unit2Final
//
//  Created by C4Q on 11/10/17.
//  Copyright © 2017 Karen Fuentes. All rights reserved.
//

import UIKit

class CrayonListViewController: UIViewController {

    var crayonListTableView: UITableView = UITableView()
    
    //Data Source Variable
    var allCrayons: [Crayon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Crayons"
        loadData()
        self.view.addSubview(crayonListTableView)
        setUpConstraints()
 
        crayonListTableView.estimatedRowHeight = 140
        crayonListTableView.rowHeight = UITableViewAutomaticDimension
        
        crayonListTableView.register(CrayonTableViewCell.self, forCellReuseIdentifier: "crayonCell")
        
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

    //Constraints
    func setUpConstraints() {
       crayonListTableView.translatesAutoresizingMaskIntoConstraints = false
        crayonListTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        crayonListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        crayonListTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
}

//MARK: - Table View Methods
extension CrayonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailedVC = CrayonDetailTableViewController()
        detailedVC.defaultColor = allCrayons[indexPath.row]
        
        self.navigationController?.pushViewController(detailedVC, animated: true)
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
            
            let colorName = currentCrayon.name
            let textColor = UIColor(displayP3Red: oppositeBlue, green: oppositeGreen, blue: oppositeRed, alpha: 1)

            let backgroundColor = UIColor(displayP3Red: currentRed, green: currentGreen, blue: currentBlue, alpha: 1)
            
            //if hex
            let decimalHexText = "Hex: \(currentCrayon.hex)"
            
            //if decimal
//            crayonCell.decimalHexLabel.text = "Decimal: (\(currentCrayon.red), \(currentCrayon.green), \(currentCrayon.blue))"
            
            crayonCell.configureCell(withColorName: colorName, textColor: textColor, backgroundColor: backgroundColor, andDecimalHexText: decimalHexText)
            
            return crayonCell
        }
        
        return cell
    }
    
}
