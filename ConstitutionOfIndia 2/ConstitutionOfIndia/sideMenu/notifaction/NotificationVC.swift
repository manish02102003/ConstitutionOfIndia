//
//  NotificationVC.swift
//  ConstitutionOfIndia
//
//  Created by Jon Snow on 08/01/24.
//

import UIKit
struct NoticationModel:Codable{
    var id: String
    var title: String
    var small_description:String
}

class NotificationVC: UIViewController,DarkModeToggleDelegate{
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    var NotificationData = [NoticationModel]()
    @IBOutlet weak var taleViewnot: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        taleViewnot.dataSource = self
        taleViewnot.delegate = self
       apiCalling()
        applyDarkMode(isDarkModeEnable: false)
    }
    func toggleDarkMode(isDarkModeEnable: Bool) {
        applyDarkMode(isDarkModeEnable: isDarkModeEnable)
    }
   
    @IBAction func BackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    private func applyDarkMode(isDarkModeEnable : Bool){
        if isDarkModeEnable{
            overrideUserInterfaceStyle = .dark
            
        }else{
            overrideUserInterfaceStyle = .light
        }
    }
    func apiCalling(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/constitution_of_india/constitution_of_india_notification") else {return}
        activityLoader.startAnimating()
        let urlrequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlrequest){ [self] data,response,error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let jsonData = try JSONDecoder().decode([NoticationModel].self, from: data)
                    self.NotificationData = jsonData
                    
                    DispatchQueue.main.async {
                        self.activityLoader.stopAnimating()
                        self.taleViewnot.reloadData()
                        
                    }
                }catch{
                    print("error in catch block")
                }
            }
           
        }.resume()
    }


}
extension NotificationVC: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotificationData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taleViewnot.dequeueReusableCell(withIdentifier: "NoticationTVC", for: indexPath) as! NoticationTVC
        cell.notIdlabel.text = NotificationData[indexPath.row].id
        cell.notIdpart.text = NotificationData[indexPath.row].title
        cell.notifactonDescription.text = NotificationData[indexPath.row].small_description
        
        return cell
        
    }
}
