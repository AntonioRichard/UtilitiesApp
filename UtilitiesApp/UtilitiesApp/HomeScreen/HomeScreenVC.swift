//
//  HomeScreenVC.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 10.05.2022.
//

import UIKit

enum Subsection: String {

    case notes = "Notes"
    case images = "Images"
    case calculator = "Calculator"
    case randomTask = "Random Task"

    static var all: [Subsection] = [.notes, .images, .calculator, .randomTask]

}

class HomeScreenVC: UIViewController {
    
    @IBOutlet var menuLeading: NSLayoutConstraint!
    @IBOutlet var toggleShadowButton: UIButton!
    @IBOutlet var greetingLabel:UILabel!
    @IBOutlet var tableView: UITableView!

    var isMenuClosed: Bool = true
    var isMenuRearrangeable: Bool = false
    let hour = Calendar.current.component(.hour, from: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "HomeScreenCell", bundle: Bundle.main), forCellReuseIdentifier: "HomeScreenCell")
        setGreetingMessage()
    }

    private func setGreetingMessage() {
        if let user = User.current {
            greetingLabel.text = TimedMessageGenerator.currentMessage(forName: user.name)
        }
    }
    
    @IBAction private func menuMethod(_ button:UIButton?){
            toggleSlidingMenu()
    }
    
    @IBAction private func rearrangeItems(_ sender: UIButton?){
        toggleSlidingMenu()
        isMenuRearrangeable.toggle()
        tableView.setEditing(isMenuRearrangeable, animated: true)
    }
    
    @IBAction private func goToNotesVC(_ sender: UIButton?){
        navigationController?.pushViewController(NotesVC(), animated: true)
    }
    
    @IBAction private func goToImagesVC(_ sender: UIButton?){
        navigationController?.pushViewController(ImagesVC(), animated: true)
    }
    
    @IBAction private func goToCalculatorVC(_ sender: UIButton?){
        navigationController?.pushViewController(CalculatorVC(), animated: true)
    }
    
    @IBAction private func goToRandomTaskVC(_ sender: UIButton?){
        navigationController?.pushViewController(RandomTaskVC(), animated: true)
    }
    
    @IBAction private func logOut(_ sender: UIButton?){
        navigationController?.viewControllers = [LoginVC()]
        User.logout()
    }
    
    private func toggleSlidingMenu(){
        isMenuClosed.toggle()
        if(isMenuClosed){
            UIView.animate(withDuration: 0.5) {
                self.menuLeading.constant = -240.0
                self.view.layoutIfNeeded()
                self.toggleShadowButton.alpha = 0.0
            } completion: { done in}
        }else{
            UIView.animate(withDuration: 0.5) {
                self.menuLeading.constant = 0.0
                self.view.layoutIfNeeded()
                self.toggleShadowButton.alpha = 0.75
            } completion: { done in}
        }
    }
}

extension HomeScreenVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //imagine sections are getting reordered here
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension HomeScreenVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenCell.identifier, for:indexPath) as? HomeScreenCell else {
            return UITableViewCell()
        }
        cell.configure(withSectionName: Subsection.all[indexPath.row].rawValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Subsection.all.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var viewController: UIViewController
        let selectedSubsection = Subsection.all[indexPath.row]
        switch selectedSubsection {
        case .notes:
            viewController = NotesVC()
        case .images:
            viewController = ImagesVC()
        case .calculator:
            viewController = CalculatorVC()
        case .randomTask:
            viewController = RandomTaskVC()
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
