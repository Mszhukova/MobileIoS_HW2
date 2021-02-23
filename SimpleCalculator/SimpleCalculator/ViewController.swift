//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Казарян Давид on 23.02.21.
//  Copyright © 2021 Maria Zhukova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ResultLabel: UILabel!
    var stillTyping = false
    var sign: String = ""
    var dotDetected = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var transformInput: Double {
        get{
            return Double(ResultLabel.text!)!
        }
        set{
            let value = "\(newValue)"
            let arrValue = value.components(separatedBy: ("."))
            if arrValue[1] == "0"{
                ResultLabel.text = "\(arrValue[0])"
            } else {
                ResultLabel.text = "\(newValue)"
            }
            stillTyping = false;
        }
    }

    @IBAction func number0(_ sender: UIButton) {
        let inputNumber = sender.currentTitle!
        if stillTyping {
            if ResultLabel.text!.characters.count < 20 {
                ResultLabel.text = ResultLabel.text! + inputNumber
            }
        } else {
        ResultLabel.text = inputNumber
        stillTyping = true
        }
    }
    @IBAction func twoParamOperation(_ sender: UIButton) {
        sign = sender.currentTitle!
        firstOperand = transformInput
        stillTyping = false
        dotDetected = false
    }
    func operaionWithTwoOperands(operation: (Double, Double) -> Double){
        transformInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func resultOperation(_ sender: UIButton) {
        if stillTyping {
            secondOperand = transformInput
        }
        dotDetected = false
        switch sign{
        case "+":
            operaionWithTwoOperands{$0 + $1}
        case "-":
            operaionWithTwoOperands{$0 - $1}
        case "✕":
            operaionWithTwoOperands{$0 * $1}
        case "÷":
            operaionWithTwoOperands{$0 / $1}
        default: break
        }
    }
    @IBAction func ClearButton(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        transformInput = 0
        ResultLabel.text = "0"
        stillTyping = false
        sign = ""
        dotDetected = false
    }
    
    @IBAction func SelectSignButton(_ sender: UIButton) {
        transformInput = -transformInput
    }
    
    @IBAction func percentButton(_ sender: UIButton) {
        if firstOperand == 0 {
            transformInput = transformInput / 100
        } else {
            secondOperand = firstOperand * transformInput / 100
        }
        stillTyping = false
    }
    
    @IBAction func sqrtButton(_ sender: UIButton) {
        transformInput = sqrt(transformInput)
    }
    
    
    @IBAction func dotButton(_ sender: UIButton) {
        if stillTyping && !dotDetected {
            ResultLabel.text = ResultLabel.text! + "."
            dotDetected = true
        } else if !stillTyping && !dotDetected {
            ResultLabel.text = "0."
        }
    }
}

