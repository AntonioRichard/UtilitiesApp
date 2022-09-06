//
//  RandomTaskVC.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 11.05.2022.
//

import UIKit

class RandomTaskVC: UIViewController {
    @IBOutlet private weak var taskLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var participantsLabel: UILabel!
    var activity:String!
    var type:String!
    var participants:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://www.boredapi.com/api/activity/"
        getData(from: url)
    }

    private func getData(from url: String){
        DownloadManager.getObject(ofType: MyResult.self, fromURL: URL(string: url)) { success, object in
            if success, let object = object {
                self.activity = object.activity
                self.type = object.type
                self.participants = String(object.participants)
            }
        }
    }
    
    @IBAction func newActivity(_ sender: UIButton?){
        let url = "http://www.boredapi.com/api/activity/"
        getData(from: url)
        self.taskLabel.text = "Activity: \(self.activity ?? "")"
        self.typeLabel.text = "Type: \(self.type ?? "")"
        self.participantsLabel.text = "Participants: \(self.participants ?? "")"
    }
    
    @IBAction func goBack(_ sender: UIButton?){
        navigationController?.popViewController(animated: true)
    }
}

struct MyResult: Codable {
    let activity: String
    let type: String
    let participants: Int
}
