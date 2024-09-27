//
//  AmendentsVC.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 15/12/23.
//

import UIKit
import SDWebImage
import AVKit
struct AmendentsModel: Codable {
    var id: String?
    var title: String?
    var small_description: String?
}

class AmendentsVC: UIViewController {
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    var AmendentsData = [AmendentsModel]()
    @IBOutlet weak var collectionview: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.dataSource=self
        collectionview.delegate=self
        apiCalling()
        
        
    }
    func apiCalling(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/constitution_of_india/constitution_of_india_amendments") else {return}
        activityLoader.startAnimating()
        let urlrequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlrequest){ [self] data,response,error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let jsonData = try JSONDecoder().decode([AmendentsModel].self, from: data)
                    self.AmendentsData = jsonData
                    
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
extension AmendentsVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AmendentsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmendentsCVC", for: indexPath) as! AmendentsCVC
        cell.labelAmendents.text=AmendentsData[indexPath.item].title ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = AmendentsData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "AmendmentsApiVC") as! AmendmentsApiVC
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
        }
    

    
}


   
