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
    
    var selectedColor: (forRed: CGFloat, forGreen: CGFloat, forBlue: CGFloat, forAlpha: CGFloat) = (forRed: CGFloat(1), forGreen: CGFloat(1), forBlue: CGFloat(1), forAlpha: 1) {
        didSet {
            self.tableView.backgroundColor = UIColor(displayP3Red: selectedColor.forRed, green: selectedColor.forGreen, blue: selectedColor.forBlue, alpha: selectedColor.forAlpha)
            
            switch DisplayColorCode.selectedColorCode {
            case .hex:
                break
            case .decimal:
                redValueLabel.text = selectedColor.forRed.description
                greenValueLabel.text = selectedColor.forGreen.description
                blueValueLabel.text = selectedColor.forBlue.description
                
                alphaValueLabel.text = selectedColor.forAlpha.description
            }
            
            self.tableView.reloadSections(IndexSet(integersIn: 0..<7), with: UITableViewRowAnimation(rawValue: 5)!)
        }
    }
    
    //Color Code
    @IBOutlet weak var colorCodeSegmentedControl: UISegmentedControl!
    
    var currentColorCode = DisplayColorCode.selectedColorCode {
        didSet {
            DisplayColorCode.selectedColorCode = currentColorCode
        }
    }
    
    @IBAction func colorCodeValueChanged(_ sender: UISegmentedControl) {
        guard let selectedColorCode = DisplayColorCode.ColorCode(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        
        currentColorCode = selectedColorCode
    }
    
    //Red Value
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBAction func redSliderValueChanged(_ sender: UISlider) {
        selectedColor.forRed = CGFloat(sender.value)
    }
    
    //Green Value
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var greenSlider: UISlider!
    @IBAction func greenSliderValueChanged(_ sender: UISlider) {
        selectedColor.forGreen = CGFloat(sender.value)
    }
    
    //Blue Value
    @IBOutlet weak var blueValueLabel: UILabel!
    @IBOutlet weak var blueSlider: UISlider!
    @IBAction func blueSliderValueChanged(_ sender: UISlider) {
        selectedColor.forBlue = CGFloat(sender.value)
    }
    
    //Alpha Value
    @IBOutlet weak var alphaValueLabel: UILabel!
    @IBOutlet weak var alphaStepper: UIStepper!
    @IBAction func alphaSliderValueChanged(_ sender: UIStepper) {
        selectedColor.forAlpha = CGFloat(sender.value / 10)
    }
    
    //Reset
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        loadColors()
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadColors()
    }
    
    func loadColors() {
        colorNameLabel.text = defaultColor.name
        
        selectedColor.forRed = CGFloat(defaultColor.red / 255)
        selectedColor.forGreen = CGFloat(defaultColor.green / 255)
        selectedColor.forBlue = CGFloat(defaultColor.blue / 255)
        selectedColor.forAlpha = 1
        
        self.tableView.backgroundColor = UIColor(displayP3Red: selectedColor.forRed, green: selectedColor.forGreen, blue: selectedColor.forBlue, alpha: selectedColor.forAlpha)
        
        //color code
        colorCodeSegmentedControl.selectedSegmentIndex = currentColorCode.rawValue
        
        //red
        redValueLabel.text = selectedColor.forRed.description
        redSlider.value = Float(selectedColor.forRed)
        
        //green
        greenValueLabel.text = selectedColor.forGreen.description
        greenSlider.value = Float(selectedColor.forGreen)
        
        //blue
        blueValueLabel.text = selectedColor.forBlue.description
        blueSlider.value = Float(selectedColor.forBlue)
        
        //alpha
        alphaValueLabel.text = selectedColor.forAlpha.description
        alphaStepper.value = Double(selectedColor.forAlpha * 10)
    }
    
}

//Changing table view section text colors
extension CrayonDetailTableViewController {
    //header
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView, let headerViewText = headerView.textLabel else {
            return
        }
        
        let oppositeRed = (1 - selectedColor.forRed) / 1.35
        let oppositeGreen = (1 - selectedColor.forGreen) / 1.35
        let oppositeBlue = (1 - selectedColor.forBlue) / 1.35
        
        headerViewText.textColor = UIColor(displayP3Red: oppositeGreen, green: oppositeBlue, blue: oppositeRed, alpha: 1)
    }
    
    //footer
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let footerView = view as? UITableViewHeaderFooterView, let footerViewText = footerView.textLabel else {
            return
        }
        
        let oppositeRed = (1 - selectedColor.forRed) / 1.35
        let oppositeGreen = (1 - selectedColor.forGreen) / 1.35
        let oppositeBlue = (1 - selectedColor.forBlue) / 1.35
        
        footerViewText.textColor = UIColor(displayP3Red: oppositeGreen, green: oppositeBlue, blue: oppositeRed, alpha: 1)
    }
}

struct DisplayColorCode {
    enum ColorCode: Int {
        case hex = 0
        case decimal = 1
    }
    
    static var selectedColorCode: ColorCode = .decimal
}
