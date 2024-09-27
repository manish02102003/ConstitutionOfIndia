//
//  SchedulesApiVC.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 16/12/23.
//
var small_description: String?

import UIKit
import AVKit

class SchedulesApiVC: UIViewController {
   
    var data : SchcdulesModel?
    var player = AVPlayer()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    //    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        textView.text = data?.small_description
        if let urlimaga = URL(string: "https://mapi.trycatchtech.com/uploads/constitution_of_india/00e76c27d34b87928d19778cced28bea.jpg"){
            imageView.sd_setImage(with: urlimaga,placeholderImage: UIImage(named: "placeholder.png"))
            
        }
      
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
