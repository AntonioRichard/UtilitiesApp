//
//  AppDelegate.swift
//  UtilitiesApp
//
//  Created by Paul-Daniel DOBREA on 04.05.2022.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        checkLoginStatusAndStartApp()

        print("\n\n\n\n")

        UserEntity.deleteAll()

        for i in 0...100 {
            UserEntity.addNewUser(age: Double(arc4random() % 100), name: "User\(i)", email: "test\(i)@test.com", password: "testTest")
        }

        let users = UserEntity.allUsers()
        for user in users {
            print("\(user)")
        }

        CoreDataManager.shared.saveContext()

        print("\n\n\n\n")

        return true
    }

    private func checkLoginStatusAndStartApp() {
        if User.current != nil {
            buildAppView(withViewController: HomeScreenVC())
        } else {
            buildAppView(withViewController: LoginVC())
        }
    }

    private func buildAppView(withViewController viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
    }
}


