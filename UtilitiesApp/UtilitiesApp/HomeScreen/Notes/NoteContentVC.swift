//
//  NoteContentVC.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 22.05.2022.
//

import UIKit

class NoteContentVC: UIViewController {
    var note:Note
    @IBOutlet private var noteContent:UITextView!
    @IBOutlet private var titleLabel:UILabel!
    
    init(note:Note){
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = note.title
        noteContent.text = note.content
    }
    
    @IBAction func goBack(_ sender: UIButton?){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save(_ sender: UIButton?){
        note.content = noteContent.text
        User.current?.addNote(note)
        goBack(nil)
    }
}
