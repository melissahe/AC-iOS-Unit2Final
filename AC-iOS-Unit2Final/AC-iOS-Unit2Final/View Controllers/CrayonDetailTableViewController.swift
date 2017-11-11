//
//  CrayonDetailTableViewController.swift
//  AC-iOS-Unit2Final
//
//  Created by C4Q on 11/10/17.
//  Copyright © 2017 Karen Fuentes. All rights reserved.
//

import UIKit

//Changing hex to decimal, vice versa - too small to be its own file
struct DisplayColorCode {
    enum ColorCode: Int {
        case hex = 0
        case decimal = 1
    }
    
    static var selectedColorCode: ColorCode = .decimal
}

class CrayonDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var colorNameLabel: UILabel!
    
    var defaultColor: Crayon!
    
    var manuallyChangingColor: Bool = false
    
    var selectedColor: (forRed: Int, forGreen: Int, forBlue: Int, forAlpha: CGFloat) = (forRed: 255, forGreen: 255, forBlue: 255, forAlpha: 1) {
        didSet {
            displayColors()
            
            self.tableView.reloadSections(IndexSet(integersIn: 0..<7), with: UITableViewRowAnimation(rawValue: 5)!)
        }
    }
    
    //Color Code
    @IBOutlet weak var colorCodeSegmentedControl: UISegmentedControl!
    
    var currentColorCode = DisplayColorCode.selectedColorCode {
        didSet {
            DisplayColorCode.selectedColorCode = currentColorCode
            displayColors()
            tableView.reloadData()
        }
    }
    
    @IBAction func colorCodeValueChanged(_ sender: UISegmentedControl) {
        guard let selectedColorCode = DisplayColorCode.ColorCode(rawValue: sender.selectedSegmentIndex) else {
            return
        }
        currentColorCode = selectedColorCode
    }
    
    //Red Value
    @IBOutlet weak var redValueTextField: UITextField!
    var redText: String = "" {
        didSet {
            redValueTextField.text = redText
            
            switch currentColorCode {
            case .decimal:
                guard let numRedText = Int(redText), numRedText <= 255 else {
                    return
                }
                
                selectedColor.forRed = numRedText
            case .hex:
                guard redText.count <= 2 else {
                    return
                }
                
                let decimalHex = Crayon(hex: redText)
        
                selectedColor.forRed = Int(decimalHex.red)
            }
        }
    }
    @IBOutlet weak var redSlider: UISlider!
    
    @IBAction func redSliderValueChanged(_ sender: UISlider) {
        selectedColor.forRed = Int(CGFloat(sender.value) * 255)
    }
    
    //Green Value
    @IBOutlet weak var greenValueTextField: UITextField!
    var greenText: String = "" {
        didSet {
            greenValueTextField.text = greenText
            
            switch currentColorCode {
            case .decimal:
                guard let numGreenText = Int(greenText), numGreenText <= 255 else {
                    return
                }
                
                selectedColor.forGreen = numGreenText
            case .hex:
                guard greenText.count <= 2 else {
                    return
                }
                
                let decimalHex = Crayon(hex: greenText)
                
                selectedColor.forGreen = Int(decimalHex.green)
            }
        }
    }
    @IBOutlet weak var greenSlider: UISlider!
    @IBAction func greenSliderValueChanged(_ sender: UISlider) {
        selectedColor.forGreen = Int(CGFloat(sender.value) * 255)
    }
    
    //Blue Value
    @IBOutlet weak var blueValueTextField: UITextField!
    var blueText: String = "" {
        didSet {
            blueValueTextField.text = blueText
            
            switch currentColorCode {
            case .decimal:
                guard let numBlueText = Int(blueText), numBlueText <= 255 else {
                    return
                }
                
                selectedColor.forBlue = numBlueText
            case .hex:
                guard blueText.count <= 2 else {
                    return
                }
                
                let decimalHex = Crayon(hex: blueText)
                
                selectedColor.forBlue = Int(decimalHex.blue)
            }
        }
    }
    @IBOutlet weak var blueSlider: UISlider!
    @IBAction func blueSliderValueChanged(_ sender: UISlider) {
        selectedColor.forBlue = Int(CGFloat(sender.value) * 255)
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
        displayColors()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadColors()
        displayColors()
        redValueTextField.delegate = self
        greenValueTextField.delegate = self
        blueValueTextField.delegate = self
    }
    
    func loadColors() {
        colorNameLabel.text = defaultColor.name
        
        selectedColor.forRed = Int(defaultColor.red)
        selectedColor.forGreen = Int(defaultColor.green)
        selectedColor.forBlue = Int(defaultColor.blue)
        selectedColor.forAlpha = 1
        
    }
    
    func displayColors() {
        self.tableView.backgroundColor = UIColor(displayP3Red: CGFloat(Double(selectedColor.forRed) / 255), green: CGFloat(Double(selectedColor.forGreen) / 255), blue: CGFloat(Double(selectedColor.forBlue) / 255), alpha: selectedColor.forAlpha)
        
        //color code
        colorCodeSegmentedControl.selectedSegmentIndex = currentColorCode.rawValue
        
        if manuallyChangingColor {
            //red
            redValueTextField.text = (currentColorCode == .decimal) ? (selectedColor.forRed.description) : redValueTextField.text
            redSlider.value = Float(selectedColor.forRed) / 255
            
            //green
            greenValueTextField.text = (currentColorCode == .decimal) ? (selectedColor.forGreen.description) : greenValueTextField.text
            greenSlider.value = Float(selectedColor.forGreen) / 255
            
            //blue
            blueValueTextField.text = (currentColorCode == .decimal) ? (selectedColor.forBlue.description) : blueValueTextField.text
            blueSlider.value = Float(selectedColor.forBlue) / 255
        } else {
        //red
        redValueTextField.text = (currentColorCode == .decimal) ? (selectedColor.forRed.description) : (convertDecimalToHex(selectedColor.forRed))
        redSlider.value = Float(selectedColor.forRed) / 255
        
        //green
        greenValueTextField.text = (currentColorCode == .decimal) ? (selectedColor.forGreen.description) : (convertDecimalToHex(selectedColor.forGreen))
        greenSlider.value = Float(selectedColor.forGreen) / 255
        
        //blue
        blueValueTextField.text = (currentColorCode == .decimal) ? (selectedColor.forBlue.description) : (convertDecimalToHex(selectedColor.forBlue))
        blueSlider.value = Float(selectedColor.forBlue) / 255
        }
        
        //alpha
        alphaValueLabel.text = selectedColor.forAlpha.description
        alphaStepper.value = Double(selectedColor.forAlpha * 10)
    }
    
    func convertDecimalToHex(_ decimal: Int) -> String {
        var decimal = decimal
        var convertedHex: String = ""
        
        var firstDigit: String = ""
        var lastDigit: String = ""
        
        let hexadecimalDictionary: [Int: String] = [10 : "A",
                                                    11 : "B",
                                                    12 : "C",
                                                    13 : "D",
                                                    14 : "E",
                                                    15 : "F"]
        
        for number in 0..<2 {
            let remainder = decimal % 16
            decimal /= 16
            if remainder < 10 {
                if number == 0 {
                    lastDigit = remainder.description
                } else {
                    firstDigit = remainder.description
                }
            } else if let hexadecimal = hexadecimalDictionary[remainder] {
                if number == 0 {
                    lastDigit = hexadecimal
                } else {
                    firstDigit = hexadecimal
                }
            }
        }
        
        convertedHex = firstDigit + lastDigit
        
        return convertedHex
    }
}

//MARK: - Text Field Delegate Methods
extension CrayonDetailTableViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        manuallyChangingColor = true
        
        if string == "" {
            if textField == redValueTextField {
                var newText = textField.text!
                newText.removeLast()
                redText = newText
            } else if textField == greenValueTextField {
                var newText = textField.text!
                newText.removeLast()
                greenText = newText
            } else if textField == blueValueTextField {
                var newText = textField.text!
                newText.removeLast()
                blueText = newText
            }
            return false
        }
        
        guard "0123456789abcdef".contains(string.lowercased()) else {
            return false
        }
        
        guard let text = textField.text, text.count < 3 else {
            return false
        }
        
        if textField == redValueTextField {
            var redTextArray = Array(redText).map{String($0)}
            redTextArray.insert(string, at: range.lowerBound)
            redText = redTextArray.joined()
        } else if textField == greenValueTextField {
            var greenTextArray = Array(greenText).map{String($0)}
            greenTextArray.insert(string, at: range.lowerBound)
            greenText = greenTextArray.joined()
        } else if textField == blueValueTextField {
            var blueTextArray = Array(blueText).map{String($0)}
            blueTextArray.insert(string, at: range.lowerBound)
            blueText = blueTextArray.joined()
        }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        manuallyChangingColor = false
    }
    
}

//Changing table view section text colors
extension CrayonDetailTableViewController {
    //header
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView, let headerViewText = headerView.textLabel else {
            return
        }
        
        let oppositeRed = CGFloat(255 - selectedColor.forRed) / 344
        let oppositeGreen = CGFloat(255 - selectedColor.forGreen) / 344
        let oppositeBlue = CGFloat(255 - selectedColor.forBlue) / 344
        
        headerViewText.textColor = UIColor(displayP3Red: oppositeGreen, green: oppositeBlue, blue: oppositeRed, alpha: 1)
    }
    
    //footer
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        guard let footerView = view as? UITableViewHeaderFooterView, let footerViewText = footerView.textLabel else {
            return
        }
        
        let oppositeRed = CGFloat(255 - selectedColor.forRed) / 344
        let oppositeGreen = CGFloat(255 - selectedColor.forGreen) / 344
        let oppositeBlue = CGFloat(255 - selectedColor.forBlue) / 344
        
        footerViewText.textColor = UIColor(displayP3Red: oppositeGreen, green: oppositeBlue, blue: oppositeRed, alpha: 1)
    }
}

