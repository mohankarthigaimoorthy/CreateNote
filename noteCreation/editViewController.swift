//
//  editViewController.swift
//  noteCreation
//
//  Created by Mohan K on 02/03/23.
//

import UIKit

protocol NoteDelegate {
    func noteUpdated(_ note: NotesData)
}

class editViewController: UIViewController {

    @IBOutlet weak var editText: UITextField!
    
    @IBOutlet weak var editBdy: UITextView!
   
    public var noteTitle: String = ""
    public var bodie: String = ""
    
    var data : NotesData?
  
    var delegate : NoteDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        editText.text = noteTitle
        editBdy.text = bodie
//        print("data : \(data)")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editNote))
    }
    
    @objc private func editNote() {
        delegate?.noteUpdated(NotesData(heading: editText.text ?? "",
                                        content: editBdy.text ?? "",
                                        id: data?.id ?? 0))
        self.navigationController?.popViewController(animated: true)
//        print("NotesData : \(NotesData.self)")
    }

}
