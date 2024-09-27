//
//  ArticleVC.swift
//  ConstitutionOfIndia
//
//  Created by Jon Snow on 06/01/24.
//

import UIKit
import AVKit
import SDWebImage


class ArticleVC: UIViewController {

   

    var data : ArticleModel?


       
        var PreambleData = [PreambleModel]()
        
        @IBOutlet weak var imageView: UIImageView!
        
    @IBOutlet weak var textView: UITextView!
    
    
        override func viewDidLoad() {
            super.viewDidLoad()

            textView.text = data?.description
            if let urlimaga = URL(string: "https://mapi.trycatchtech.com/uploads/constitution_of_india/00e76c27d34b87928d19778cced28bea.jpg"){
                imageView.sd_setImage(with: urlimaga,placeholderImage: UIImage(named: "placeholder.png"))
            }

        }
        
 
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

  

