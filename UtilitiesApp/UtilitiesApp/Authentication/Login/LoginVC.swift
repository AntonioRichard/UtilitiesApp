//
//  LoginVC.swift
//  UtilitiesApp
//
//  Created by Paul-Daniel DOBREA on 04.05.2022.
//

import UIKit

class LoginVC: AuthenticationVC {

    @IBAction override func switchScreen(_ sender: UIButton?){
        navigationController?.viewControllers = [SignupVC()]
    }
    
    @IBAction override func authenticate(_ sender: UIButton?) {
        let result = isInputDataValid()
        if result.isValid {
            result.user?.retrieveName()
            result.user?.save(addToAllUsers: false)
            navigationController?.viewControllers = [HomeScreenVC()]
        }
    }

    override func getUser() -> User {
        let user = User()
        user.email = email.text ?? ""
        user.password = password.text ?? ""
        return user
    }

    private func isInputDataValid() -> (isValid: Bool, user: User?) {
        var isValid = false
        var user: User?
        if email.text == "" || password.text == ""{
            showErrorMessage(LoginErrorMessage.emptyField.rawValue)
        } else {
            let currentUser = getUser()
            if currentUser.isDuplicate() {
                if currentUser.credentialsAreValid() {
                    isValid = true
                    user = currentUser
                } else {
                    showErrorMessage(LoginErrorMessage.wrongPassword.rawValue)
                }
            } else {
                showErrorMessage(LoginErrorMessage.userDoesNotExist.rawValue)
            }
        }
        return (isValid, user)
    }

    override func showErrorMessage(_ message: String?) {
        guard let message = message else {
            return
        }
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}

//MARK: - Text Field Delegate

extension LoginVC {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == email){
            password.becomeFirstResponder()
        }else{
        textField.resignFirstResponder()
        }
        return true
    }
}
