//
//  AuthenticationVC.swift
//  UtilitiesApp
//
//  Created by Paul-Daniel DOBREA on 22.06.2022.
//

import UIKit

class AuthenticationVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email:UITextField!
    @IBOutlet weak var password:UITextField!

    @IBAction func switchScreen(_ sender: UIButton?){
        // do nothing - overridden by children
    }

    @IBAction func authenticate(_ sender: UIButton?){
        // do nothing - overridden by children
    }

    func getUser() -> User {
        // do nothing - overridden by children
        return User()
    }

    func showErrorMessage(_ message: String?) {
        // do nothing - overridden by children
    }

}
