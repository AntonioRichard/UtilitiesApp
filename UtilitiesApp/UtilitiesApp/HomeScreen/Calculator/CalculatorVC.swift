//
//  CalculatorVC.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 11.05.2022.
//

import UIKit

enum CalculatorOperation {
    case none
    case sum
    case substraction
    case division
    case multiplication
}

class CalculatorVC: UIViewController {
    @IBOutlet private weak var result:UILabel!
    @IBOutlet private weak var backspace:UIButton!
    @IBOutlet private weak var clear:UIButton!
    private var isFloat:Bool = false
    private var firstNumber:Float!
    private var secondNumber:Float!
    private var currentOperation: CalculatorOperation = .none
    let backspaceFill = UIImage(systemName: "delete.left.fill")
    let backspaceNotFilled = UIImage(systemName: "delete.left")

    //TODO: clean up overall
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
    @IBAction func backspaceTouchDown(_ sender:UIButton?){
        backspace.setImage(backspaceFill, for: .normal)
    }
    
    @IBAction func backspace(_ sender:UIButton?){
        if var string = result.text{
            if string.count > 1{
                string.remove(at: string.index(before: string.endIndex))
                result.text = string
            }else{
                result.text = "0"
                isFloat = false
            }
        }
        backspace.setImage(backspaceNotFilled, for: .normal)
    }
    
    @IBAction func clear(_ sender:UIButton?){
        if clear.title(for: .normal) == "C"{
            result.text = "0"
        } else {
            result.text = "0"
            firstNumber = 0
            clear.setTitle("C", for: .normal)
        }
        isFloat = false
        currentOperation = .none
    }

    @IBAction private func digit(_ sender: UIButton) {
        if result.text == "0" || result.text == "0.0" {
            result.text = "\(sender.tag)"
        } else if var string = result.text {
            string = string + "\(sender.tag)"
            result.text = string
        }
    }
    
    @IBAction func float(_ sender: UIButton?){
        if !isFloat{
            if var string = result.text{
                string = string + "."
                result.text = string
            }
            isFloat = true
        }
    }
    
    @IBAction func plus(_ sender: UIButton?){
        getFirstNumber()
        currentOperation = .sum
    }
    
    @IBAction func minus(_ sender: UIButton?){
        getFirstNumber()
        currentOperation = .substraction
    }
    
    @IBAction func divide(_ sender: UIButton?){
        getFirstNumber()
        currentOperation = .division
    }
    
    @IBAction func multiply(_ sender: UIButton?){
        getFirstNumber()
        currentOperation = .multiplication
    }
    
    @IBAction func equal(_ sender: UIButton?){
        var finalResult:Float = 0
        if let result = result.text {
            secondNumber = Float(result)
        }
        switch currentOperation {
        case .none:
            break
        case .sum:
            finalResult = firstNumber + secondNumber
        case .substraction:
            finalResult = firstNumber - secondNumber
        case .division:
            finalResult = firstNumber / secondNumber
        case .multiplication:
            finalResult = firstNumber * secondNumber
        }
        result.text = String(finalResult)
        isFloat = false
        clear.setTitle("C", for: .normal)
        firstNumber = finalResult
    }
    
    @IBAction func goBack(_ sender: UIButton?){
        navigationController?.viewControllers = [HomeScreenVC()]
    }
    
    func getFirstNumber(){
        if currentOperation == .none, let result = result.text {
            firstNumber = Float(result)
        }
        result.text = "0"
        isFloat = false
        clear.setTitle("AC", for: .normal)
    }
}
