//
//  CrayonDetailTableViewController.swift
//  AC-iOS-Unit2Final
//
//  Created by C4Q on 11/10/17.
//  Copyright © 2017 Karen Fuentes. All rights reserved.
//

import UIKit

class CrayonDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var colorNameLabel: UILabel!
    
    var defaultColor: Crayon!
    var userSelectedColor: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = (red: CGFloat(1), green: CGFloat(1), blue: CGFloat(1), alpha: 1) {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    //Color Code
    @IBOutlet weak var colorCodeSegmentedControl: UISegmentedControl!
    
//    var currentColorCode =
    
    @IBAction func colorCodeValueChanged(_ sender: UISegmentedControl) {
        //changesColorCode
    }
    
    //Red Value
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    
//    var currentRedColor =
    
    @IBAction func redSliderValueChanged(_ sender: UISlider) {
    }
    
    //Green Value
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var greenSlider: UISlider!
    
    //    var currentGreenColor =
    
    @IBAction func greenSliderValueChanged(_ sender: UISlider) {
    }
    
    //Blue Value
    @IBOutlet weak var blueValueLabel: UILabel!
    @IBOutlet weak var blueSlider: UISlider!
    
    //    var currentBlueColor =
    
    @IBAction func blueSliderValueChanged(_ sender: UISlider) {
    }
    
    //Alpha Value
    @IBOutlet weak var alphaValueLabel: UILabel!
    @IBOutlet weak var alphaSlider: UISlider!
    
    //    var currentAlphaColor =
    
    @IBAction func alphaSliderValueChanged(_ sender: UISlider) {
    }
    
    //Reset
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        loadColor()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadColor()
    }
    
    func loadColor() {
        userSelectedColor.red = CGFloat(defaultColor.red / 255)
        userSelectedColor.green = CGFloat(defaultColor.green / 255)
        userSelectedColor.blue = CGFloat(defaultColor.blue / 255)
        userSelectedColor.alpha = 1
        
        colorNameLabel.text = defaultColor.name
        self.tableView.backgroundColor = UIColor(displayP3Red: userSelectedColor.red, green: userSelectedColor.green, blue: userSelectedColor.blue, alpha: 1)
        
        //red
        redValueLabel.text = userSelectedColor.red.description
        redSlider.value = Float(userSelectedColor.red)
        
        
        //green
        greenValueLabel.text = userSelectedColor.green.description
        greenSlider.value = Float(userSelectedColor.green)
        
        //blue
        blueValueLabel.text = userSelectedColor.blue.description
        blueSlider.value = Float(userSelectedColor.blue)
        
        //alpha
        alphaValueLabel.text = String(1)
        alphaSlider.value = 1
    }

}

//Changing table view section text
extension CrayonDetailTableViewController {
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView, let headerViewText = headerView.textLabel else {
            return
        }
        
        let oppositeRed = (1 - userSelectedColor.red) / 1.35
        let oppositeGreen = (1 - userSelectedColor.green) / 1.35
        let oppositeBlue = (1 - userSelectedColor.blue) / 1.35
        
        headerViewText.textColor = UIColor(displayP3Red: oppositeBlue, green: oppositeGreen, blue: oppositeRed, alpha: 1)
    }
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        <#code#>
//    }
}
