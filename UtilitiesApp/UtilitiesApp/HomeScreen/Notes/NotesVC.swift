//
//  NotesVC.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 19.05.2022.
//

import UIKit

class NotesVC: UIViewController {
    
    var noteTitle: String = ""
    var isTableEditable: Bool = false
    var userNotes: [Note] = User.current?.currentUserNotes ?? []
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noNotesLabel: UILabel!
    @IBOutlet var editButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NotesCell")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        if User.current?.currentUserNotes.count == 0{
            noNotesLabel.alpha = 1.0
        }else{
            noNotesLabel.alpha = 0.0
        }
    }
    
    @IBAction func goBack(_ sender: UIButton?){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func edit(_ sender: UIButton?){
        isTableEditable.toggle()
        tableView.setEditing(isTableEditable, animated: true)
        editButton.setTitle(isTableEditable ? "done" : "edit", for: .normal)
    }
    
    @IBAction func addNote(_ sender: UIButton?) {
        let alertNote = UIAlertController(title: "Add note", message: "Insert the title of your note", preferredStyle: .alert)
        alertNote.addTextField { (textField) in
            textField.placeholder = "Title"
            textField.returnKeyType = UIReturnKeyType.done;
        }
        alertNote.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alertNote] (_) in
            guard let textField = alertNote?.textFields?[0], let userText = textField.text else { return }
            let note = Note()
            self.noteTitle = userText
            note.title = self.noteTitle
            if User.current!.currentUserNotes.firstIndex(of: note) != nil {
                self.showExistingNoteAlert()
            } else {
                self.navigationController?.pushViewController(NoteContentVC(note: note), animated: true)
                self.tableView.reloadData()
            }
        }))
        alertNote.addAction(UIAlertAction(title: "Cancel", style: .default))
        present(alertNote, animated: true, completion: nil)
    }

    private func showExistingNoteAlert() {
        let alertExistingNote = UIAlertController(title: "Existing note", message: "A note with that title already exists! Do you want to replace it?", preferredStyle: .alert)
        alertExistingNote.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let note = Note()
            note.title = self.noteTitle
            self.navigationController?.pushViewController(NoteContentVC(note: note), animated: true)
            self.tableView.reloadData()
        }))
        alertExistingNote.addAction(UIAlertAction(title: "No", style: .default))
        present(alertExistingNote, animated: true, completion: nil)
    }
}

extension NotesVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            userNotes.remove(at: indexPath.row)
            saveNewNotesArray()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

        let aux: Note = userNotes[sourceIndexPath.row]
        userNotes.remove(at: sourceIndexPath.row)
        userNotes.insert(aux, at: destinationIndexPath.row)
        
        saveNewNotesArray()
    }
    
    func saveNewNotesArray(){
        guard let notesKey = User.current?.notesKey else { return }
        saveObjects(userNotes, atKey: notesKey)
        tableView.reloadData()
    }
}

extension NotesVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.current?.currentUserNotes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = User.current?.currentUserNotes[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let note = User.current?.currentUserNotes[indexPath.row]{
            navigationController?.pushViewController(NoteContentVC(note: note), animated: true)
        }
    }
}
