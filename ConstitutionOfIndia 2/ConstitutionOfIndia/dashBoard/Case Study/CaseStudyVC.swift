//
//  CaseStudyVC.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 15/12/23.
//

import UIKit
struct CaseStudyModel: Codable {
    var id: String?
    var title: String?
    var small_description: String?
}

class CaseStudyVC: UIViewController {
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    var CaseStudyData = [CaseStudyModel]()
    @IBOutlet weak var collectionview: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.dataSource=self
        collectionview.delegate=self
        apiCalling()
        
    }
    func apiCalling(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/constitution_of_india/constitution_of_india_case_study") else {return}
        let urlrequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlrequest){ [self] data,response,error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let jsonData = try JSONDecoder().decode([CaseStudyModel].self, from: data)
                    self.CaseStudyData = jsonData
                    
                    DispatchQueue.main.async {
                        
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


extension CaseStudyVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CaseStudyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CaseStudyCVC", for: indexPath) as! CaseStudyCVC
        cell.labelStudyCase.text = CaseStudyData[indexPath.item].title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = CaseStudyData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "CaseStudyAPIVC") as! CaseStudyAPIVC
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
        }
    
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20)
        let height = width/3
        return CGSize(width: width, height: height)
    }
    
}


