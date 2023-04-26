//
//  ViewController.swift
//  noteCreation
//
//  Created by Mohan K on 02/03/23.
//

import UIKit
struct NotesData {
    var heading: String
    var content: String
    var id : Int
}
class ViewController: UIViewController{
  
    @IBOutlet weak var createNote: UITableView!
   
    var data : [NotesData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Notes"
        setup()
    }

    @IBAction func addedNote(_ sender: Any) {
      
        guard let vc = storyboard?.instantiateViewController(identifier: "newnote") as? createViewController else{return}
        vc.title = "NewNote"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { [self]
            noteTitle,
            note in self.navigationController?.popToRootViewController(animated: true)
            self.data.insert(NotesData(heading: noteTitle, content: note, id: randomInt(min: 0, max: 20)),at: 0)

            self.createNote.isHidden = false
            self.createNote.reloadData()
        }
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    func rect () -> Int {
//        _ = Int.random(in: 1...20)
//        return Int()
//    }
    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    func setup() {
        createNote.dataSource = self
        createNote.delegate = self
        DispatchQueue.main.async {
            self.createNote.reloadData()
        }
    }
    
   
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell =   createNote.dequeueReusableCell(withIdentifier: "notecell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].heading
        cell.detailTextLabel?.text = data[indexPath.row].content
//        cell.rect() = data[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            data.remove(at: indexPath.row)
            createNote.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dat = data[indexPath.row]
        guard let VC = storyboard?.instantiateViewController(identifier: "edit") as? editViewController else{return}
        VC.data = dat
        VC.noteTitle = dat.heading
        VC.bodie = dat.content
        VC.delegate = self
//        VC.completion = { titlenote, note in
//
//            self.data.insert(Data(heading: dat.heading, content: dat.content, id: 0), at: 0)
//            self.createNote.reloadData()
//        }
        navigationController?.pushViewController(VC, animated: true)
    }
}

extension ViewController: NoteDelegate {
    
    func noteUpdated(_ note: NotesData) {
        if let ind = data.firstIndex(where: {$0.id == note.id}){
            data[ind] = note
        }
        DispatchQueue.main.async {
            self.createNote.reloadData()
        }
    }
}
