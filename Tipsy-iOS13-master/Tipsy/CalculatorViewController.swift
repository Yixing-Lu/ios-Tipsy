//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    var result = "0.0"
    var tip = 0.10
    var numberOfPeople = 2
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        switch sender.titleLabel?.text {
        case "0%":
            deactivateButtons()
            zeroPctButton.isSelected = true
        case "10%":
            deactivateButtons()
            tenPctButton.isSelected = true
        case "20%":
            deactivateButtons()
            twentyPctButton.isSelected = true
        default:
            deactivateButtons()
            zeroPctButton.isSelected = true
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
        numberOfPeople = Int(sender.value)
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        if zeroPctButton.isSelected {
            tip = 0.0
        } else if tenPctButton.isSelected {
            tip = 0.1
        } else if twentyPctButton.isSelected {
            tip = 0.2
        }
        print(splitNumberLabel.text!)
        
        print(billTextField.text ?? 0)

        result = String(format: "%.2f",(billTextField.text! as NSString).floatValue * (1 + Float(tip)) /  Float(numberOfPeople))
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func deactivateButtons(){
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = result
            destinationVC.split = numberOfPeople
            destinationVC.tip = Int(tip * 100)
        }
    }
}

