//
//  NotesVc.swift
//  ConstitutionOfIndia
//
//  Created by Jon Snow on 08/01/24.
//

import UIKit

class NotesVc: UIViewController {
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var userData = [UserItem](){
        didSet{
            tableview.reloadData()
        }
    }
    @IBOutlet weak var TextFiled: UITextField!
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableview.dataSource = self
        tableview.delegate = self
        activityLoader.stopAnimating()
       
    }
    
    @IBAction func SaveBtn(_ sender: UIButton) {
       
        guard let note = TextFiled.text , note != "" else {return}
        let context = appDelegate.persistentContainer.viewContext
        let userDetail = UserItem(context:context)
        userDetail.detail = note
        appDelegate.saveContext()
        userData.append(userDetail)
        TextFiled.text = ""
    }
    func fetchData(){
        let context = appDelegate.persistentContainer.viewContext
        do{
            userData = try context.fetch(UserItem.fetchRequest()) as! [UserItem]
        }catch{
            print("error")
        }
    }
    
   
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension NotesVc:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTVC", for: indexPath) as! NotesTVC
        cell.notesLabel.text = userData[indexPath.row].detail
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let deleteObj = userData[indexPath.row]
        let context = appDelegate.persistentContainer.viewContext
        context.delete(deleteObj)
        userData.remove(at: indexPath.row)
        appDelegate.saveContext()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
