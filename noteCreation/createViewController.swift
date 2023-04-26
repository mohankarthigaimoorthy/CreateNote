//
//  createViewController.swift
//  noteCreation
//
//  Created by Mohan K on 02/03/23.
//

import UIKit

class createViewController: UIViewController {
    
    @IBOutlet weak var titTxt: UITextField!
    @IBOutlet weak var bdyTxt: UITextView!
    var data : NotesData?
    public var completion: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titTxt.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didSave))
        
    }
    
    @objc func didSave() {
        if let text = titTxt.text, !text.isEmpty, !bdyTxt.text.isEmpty {
            completion?(text, bdyTxt.text)
        }
    }

    
}
