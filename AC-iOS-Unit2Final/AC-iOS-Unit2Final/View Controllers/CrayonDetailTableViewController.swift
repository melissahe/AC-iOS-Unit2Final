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
    
    //Color Code - Decimal or Hex
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
    
    //RGB Labels
        //red
    @IBOutlet weak var redValueTextField: UITextField!
    var redText: String = "" {
        didSet {
            redValueTextField.text = redText
            changeColor(using: redText)
        }
    }

        //green
    @IBOutlet weak var greenValueTextField: UITextField!
    var greenText: String = "" {
        didSet {
            greenValueTextField.text = greenText
            changeColor(using: greenText)
        }
    }
    
        //blue
    @IBOutlet weak var blueValueTextField: UITextField!
    var blueText: String = "" {
        didSet {
            blueValueTextField.text = blueText
            changeColor(using: blueText)
        }
    }
    
    //RGB Slider Values
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBAction func colorSliderValueChanged(_ sender: UISlider) {
        switch sender {
        case redSlider:
            selectedColor.forRed = Int(CGFloat(sender.value) * 255)
        case greenSlider:
            selectedColor.forGreen = Int(CGFloat(sender.value) * 255)
        case blueSlider:
            selectedColor.forBlue = Int(CGFloat(sender.value) * 255)
        default:
            return
        }
    }
    
    //Alpha Value
    @IBOutlet weak var alphaValueLabel: UILabel!
    @IBOutlet weak var alphaStepper: UIStepper!
    @IBAction func alphaSliderValueChanged(_ sender: UIStepper) {
        selectedColor.forAlpha = CGFloat(sender.value / 10)
    }
    
    //Reset Color
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
        //background
        let cgFloatRed = CGFloat(Double(selectedColor.forRed) / 255)
        let cgFloatGreen = CGFloat(Double(selectedColor.forGreen) / 255)
        let cgFloatBlue = CGFloat(Double(selectedColor.forBlue) / 255)
        
        self.tableView.backgroundColor = UIColor(displayP3Red: cgFloatRed, green: cgFloatGreen, blue: cgFloatBlue, alpha: selectedColor.forAlpha)
        
        //color values - decimal or hex
        colorCodeSegmentedControl.selectedSegmentIndex = currentColorCode.rawValue
        
        //rgb textfields
        switch currentColorCode {
        case .decimal:
            redValueTextField.text = selectedColor.forRed.description
            greenValueTextField.text = selectedColor.forGreen.description
            blueValueTextField.text = selectedColor.forBlue.description
        case .hex:
            if manuallyChangingColor {
                break
            } else {
                redValueTextField.text = convertDecimalToHex(selectedColor.forRed)
                greenValueTextField.text = convertDecimalToHex(selectedColor.forGreen)
                blueValueTextField.text = convertDecimalToHex(selectedColor.forBlue)
            }
        }
        
        //rgb sliders
        redSlider.value = Float(selectedColor.forRed) / 255
        greenSlider.value = Float(selectedColor.forGreen) / 255
        blueSlider.value = Float(selectedColor.forBlue) / 255
        
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
        
        //decimal-to-hex conversion
        for loopNumber in 0..<2 {
            let remainder = decimal % 16
            decimal /= 16
            if remainder < 10 {
                if loopNumber == 0 {
                    lastDigit = remainder.description
                } else {
                    firstDigit = remainder.description
                }
            } else if let hexadecimal = hexadecimalDictionary[remainder] {
                if loopNumber == 0 {
                    lastDigit = hexadecimal
                } else {
                    firstDigit = hexadecimal
                }
            }
        }
        
        convertedHex = firstDigit + lastDigit
        
        return convertedHex
    }
    
    func changeColor(using colorText: String) {
        switch currentColorCode {
        case .decimal:
            guard let numColorText = Int(colorText), numColorText <= 255 else {
                return
            }
            
            if colorText == redText {
                selectedColor.forRed = numColorText
            } else if colorText == greenText {
                selectedColor.forGreen = numColorText
            } else if colorText == blueText {
                selectedColor.forBlue = numColorText
            }
        case .hex:
            guard colorText.count <= 2 else {
                return
            }
            
            let decimalHex = Crayon(hex: colorText.uppercased())
            
            if colorText == redText {
                selectedColor.forRed = Int(decimalHex.red)
            } else if colorText == greenText {
                selectedColor.forGreen = Int(decimalHex.green)
            } else if colorText == blueText {
                selectedColor.forBlue = Int(decimalHex.blue)
            }
        }
    }
}

//MARK: - Text Field Delegate Methods
extension CrayonDetailTableViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        manuallyChangingColor = true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard string.count <= 1 else {
            return false
        }
        
        //if deleting
        if string == "" {
            var changedText = Array(textField.text!).map{String($0)}
            changedText.remove(at: range.lowerBound)
            
            if textField == redValueTextField {
                redText = changedText.joined()
            } else if textField == greenValueTextField {
                greenText = changedText.joined()
            } else if textField == blueValueTextField {
                blueText = changedText.joined()
            }
            return false
        }
        
        guard "0123456789abcdef".contains(string.lowercased()) else {
            return false
        }
        
        guard let text = textField.text, text.count < 3 else {
            return false
        }
        
        //if typing
        let addTextTo = {(colorText: String) -> String in
            var colorTextArray = Array(colorText).map{String($0)}
            colorTextArray.insert(string, at: range.lowerBound)
            return colorTextArray.joined()
        }
        
        if textField == redValueTextField {
            redText = addTextTo(redText)
        } else if textField == greenValueTextField {
            greenText = addTextTo(greenText)
        } else if textField == blueValueTextField {
            blueText = addTextTo(blueText)
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
        changeTextColor(for: view)
    }
    
    //footer
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        changeTextColor(for: view)
    }
    
    func changeTextColor(for view: UIView) {
        guard let headerFooterView = view as? UITableViewHeaderFooterView, let headerFooterText = headerFooterView.textLabel else {
            return
        }
        
        let oppositeRed = CGFloat(255 - selectedColor.forRed) / 344
        let oppositeGreen = CGFloat(255 - selectedColor.forGreen) / 344
        let oppositeBlue = CGFloat(255 - selectedColor.forBlue) / 344
        
        headerFooterText.textColor = UIColor(displayP3Red: oppositeGreen, green: oppositeBlue, blue: oppositeRed, alpha: 1)
    }
}

