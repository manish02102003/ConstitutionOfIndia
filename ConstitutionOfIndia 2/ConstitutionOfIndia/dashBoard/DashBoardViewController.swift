//
//  DashBoardViewController.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 12/12/23.
//

import UIKit
import SideMenu



class DashBoardViewController: UIViewController {
    var dashboardArray = ["Preamable","Parts","Schedules","Amendments","New Articles","Case Studies"]
    let sideMenu = SideMenuManager()
    @IBOutlet weak var collectionview: UICollectionView!
    
//    var PreambleData = [PreambleModel]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionview.dataSource=self
//        collectionview.delegate=self
//        apiCalling()
        
        
        
        
    }
   
}
extension DashBoardViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCVC", for: indexPath) as! dashboardCVC
        cell.label1.text = dashboardArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = (collectionView.frame.width - 20)
        let height = (widht/3.8)
        return CGSize(width: widht, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(identifier: "PreambleVC") as! PreambleVC
            
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = storyboard?.instantiateViewController(identifier: "PartsVC") as! PartsVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = storyboard?.instantiateViewController(identifier: "SchedulesVC") as! SchedulesVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = storyboard?.instantiateViewController(identifier: "AmendentsVC") as! AmendentsVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = storyboard?.instantiateViewController(identifier: "NewsArcticleVC") as! NewsArcticleVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = storyboard?.instantiateViewController(identifier: "CaseStudyVC") as! CaseStudyVC
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("error")
        }
        
    }
//    func apiCalling(){
//        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/constitution_of_india/constitution_of_india_preamble") else {return}
//        let urlrequest = URLRequest(url: url)
//        URLSession.shared.dataTask(with: urlrequest){data, response, error in
//            
//            if let error = error{
//                print(error.localizedDescription)
//                return
//            }
//            
//            if let data = data{
//                do{
//                    let jsonData = try JSONDecoder().decode([PreambleModel].self, from: data)
//                    print(jsonData)
//                    DispatchQueue.main.async {
//                        self.collectionview.reloadData()
//                    }
//                }catch{
//                    print("error in catch block")
//                }
//            }
//        }.resume()
//    }
}
