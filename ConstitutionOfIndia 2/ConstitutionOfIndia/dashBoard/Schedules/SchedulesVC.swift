//
//  SchedulesVC.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 14/12/23.
//

import UIKit
import SDWebImage
import AVKit
struct SchcdulesModel: Codable {
    var id: String?
    var title: String?
    var small_description: String?
}


class SchedulesVC: UIViewController {
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    var schedule : SchcdulesModel?
    var SchudulesData = [SchcdulesModel]()
    @IBOutlet weak var collectionview: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.dataSource=self
        collectionview.delegate=self
        
        apiCalling()
            
    }
    func apiCalling(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/constitution_of_india/constitution_of_india_schedule") else {return}
        activityLoader.startAnimating()
        let urlrequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlrequest){ [self] data,response,error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let jsonData = try JSONDecoder().decode([SchcdulesModel].self, from: data)
                    self.SchudulesData = jsonData
                    
                    DispatchQueue.main.async {
                        self.activityLoader.stopAnimating()
                        self.collectionview.reloadData()
                        
                    }
                }catch{
                    print("error in catch block")
                }
            }
           
        }.resume()
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}
extension SchedulesVC:/*UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,*/UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SchudulesData.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SchudulesCVC", for: indexPath) as! SchudulesCVC
        cell.labelScdules.text = SchudulesData[indexPath.item].title ?? ""
        return cell
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 92
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = SchudulesData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "SchedulesApiVC") as! SchedulesApiVC
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
        }
    
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "headerTVC") as! headerTVC
//        cell.label2.text = "Schedules"
//        cell.backBtn.addTarget(self, action: #selector(trigger), for: .touchUpInside)
//        return cell
//    }
//    @objc func trigger(){
//        
//        self.navigationController?.popViewController(animated: true)
//    }
    
    
}
