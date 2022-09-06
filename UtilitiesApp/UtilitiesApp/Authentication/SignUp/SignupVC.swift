//
//  SignupVC.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 04.05.2022.
//

import UIKit

class SignupVC: AuthenticationVC {

    @IBOutlet private weak var name:UITextField!
    @IBOutlet private weak var repeatPassword:UITextField!
    @IBOutlet private weak var inputErrorLabel:UILabel!

    @IBAction override func switchScreen(_ sender: UIButton?){
        navigationController?.viewControllers = [LoginVC()]
    }
    
    @IBAction override func authenticate(_ sender:UIButton?) {
        showErrorMessage(nil)
        if isInputDataValid() {
            let user = getUser()
            if user.isDuplicate() {
                showErrorMessage(SignupErrorMessage.emailInUse.rawValue)
            } else {
                user.save(addToAllUsers: true)
                navigationController?.viewControllers = [HomeScreenVC()]
            }
        }
    }

    override func getUser() -> User {
        let user = User()
        user.name = name.text ?? ""
        user.email = email.text ?? ""
        user.password = password.text ?? ""
        return user
    }

    private func isInputDataValid() -> Bool {
        var validData = false
        if name.text == "" || email.text == "" || password.text == "" || repeatPassword.text == "" {
            showErrorMessage(SignupErrorMessage.emptyField.rawValue)
        } else if let email = email.text {
            if email.isValidEmail() {
                if password.text == repeatPassword.text{
                    validData = true
                } else {
                    showErrorMessage(SignupErrorMessage.passwordMismatch.rawValue)
                }
            } else {
                showErrorMessage(SignupErrorMessage.invalidEmail.rawValue)
            }
        }
        return validData
    }

    override func showErrorMessage(_ message: String?) {
        if let message = message {
            inputErrorLabel.alpha = 1.0
            inputErrorLabel.text = message
        } else {
            inputErrorLabel.alpha = 0.0
            inputErrorLabel.text = nil
        }
    }

}

//MARK: - Text Field Delegate

extension SignupVC {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == name){
            email.becomeFirstResponder()
        } else if(textField == email){
            password.becomeFirstResponder()
        }else if textField == password{
            repeatPassword.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
}
