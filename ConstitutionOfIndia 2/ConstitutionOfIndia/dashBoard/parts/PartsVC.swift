//
//  PartsVC.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 13/12/23.
//
struct PartsListModel: Codable {
    var id: String?
    var title: String?
    var small_description: String?
}
var bn = true
struct ArticleModel: Codable {
    var id: String?
    var part_id: String?
    var title: String?
    var small_description: String?
    var description: String?
}
import UIKit


class PartsVC: UIViewController {
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var nodataLbl: UILabel!
    var PartsList = [PartsListModel]()
    var selectedPartIndex = 0
    var ArticelsList = [ArticleModel]()
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "PartsCVC", bundle: .main), forCellWithReuseIdentifier: "PartsCVC")
        collectionView.delegate = self
        collectionView.dataSource = self
        getPartsList()
        tableView.register(UINib(nibName: "ArticleTVC", bundle: .main), forCellReuseIdentifier: "ArticleTVC")
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PartsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PartsList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PartsCVC", for: indexPath) as! PartsCVC
        cell.holderView.layer.cornerRadius = cell.holderView.frame.height / 2
        cell.nameLabel.text = PartsList[indexPath.item].title
        if indexPath.item == selectedPartIndex {
            cell.holderView.layer.borderColor = UIColor.yellow.cgColor
            cell.holderView.layer.borderWidth = 2
        } else {
            cell.holderView.layer.borderColor = UIColor.clear.cgColor
            cell.holderView.layer.borderWidth = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = PartsList[indexPath.item]
        ArticelsList.removeAll()
        self.tableView.reloadData()
        getArticels(partId: data.id ?? "")
        descLabel.text = data.small_description ?? ""
        selectedPartIndex = indexPath.item
        collectionView.reloadData()
    }
    
    
}

extension PartsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.height - 20)
        let height = width
        return CGSize(width: width, height: height)
    }
}

extension PartsVC {
    
    
    func getPartsList() {
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/constitution_of_india/constitution_of_india_parts") else {return}
        activityLoader.startAnimating()
        let urlrequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlrequest){ data,response,error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let jsonData = try JSONDecoder().decode([PartsListModel].self, from: data)
                    self.PartsList = jsonData
                    self.getArticels(partId: jsonData.first?.id ?? "")
                    DispatchQueue.main.async {
                        self.descLabel.text = jsonData.first?.small_description ?? ""
                        self.activityLoader.stopAnimating()
                        self.collectionView.reloadData()
                    }
                }catch{
                    print("error in catch block")
                }
            }
           
        }.resume()
    }
    
    func getArticels(partId: String) {
        
        print("partIdpartId \(partId)")
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/constitution_of_india/constitution_of_india_articles?part_id=\(partId)") else {return}
        let urlrequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlrequest){ data,response,error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    
                    
                    let jsonnn = try JSONSerialization.jsonObject(with: data) as? [String]
                    print("jsonnnjsonnn \(jsonnn)")
                    
                    if let jsonnn = try JSONSerialization.jsonObject(with: data) as? [String], jsonnn[0] == "No data Found" {
                        DispatchQueue.main.async {
                            self.nodataLbl.isHidden = false
                        }
                        
                    } else {
                        
                        let jsonData = try JSONDecoder().decode([ArticleModel].self, from: data)
                        print("jsonDatajsonData \(jsonData)")
                        self.ArticelsList = jsonData
                        print("Found Articels \(self.ArticelsList)")
                        DispatchQueue.main.async {
                            self.nodataLbl.isHidden = true
                            self.collectionView.reloadData()
                            self.tableView.reloadData()
                        }
                    }
                }catch{
                    print("error in catch block")
                    
                }
            }
           
        }.resume()
    }
    
}

extension PartsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ArticelsList.count != 0 {
            return ArticelsList.count
            nodataLbl.isHidden = false
        } else {
            return ArticelsList.count
            nodataLbl.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTVC", for: indexPath) as! ArticleTVC
       
            cell.titleLabel.text = ArticelsList[indexPath.row].title ?? ""
            cell.messageLabel.text = ArticelsList[indexPath.row].small_description ?? ""
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = ArticelsList[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "ArticleVC") as! ArticleVC
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
        
    }
    
}
