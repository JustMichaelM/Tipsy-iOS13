//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    private(set) var stepperValue: Int!
    private(set) var tipPercentage: Double!
    private(set) var totalPerPerson: Double!
    
    @IBOutlet var percentageButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Lubie Placki")
        
        splitNumberLabel.text = "2"
        stepperValue = 2
        tipPercentage = 0.10
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        percentageButtons.forEach{$0.isSelected = false}
        sender.isSelected = true
        tipPercentage = Double(sender.tag) / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = "\(Int(sender.value))"
        stepperValue = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        var billTotal: Double?
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current

        if let number = formatter.number(from: billTextField.text ?? "0") {
            billTotal = number.doubleValue
        }
        
        totalPerPerson = (billTotal! * (1 + tipPercentage)) / Double(stepperValue)
        
        print(String(format: "%.2f", totalPerPerson))
        
        performSegue(withIdentifier: "toResults", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResults" {
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.totalPerPerson = totalPerPerson
            destinationVC.people = stepperValue
            destinationVC.tipPercentage = tipPercentage
            
        }
        
    }
}

