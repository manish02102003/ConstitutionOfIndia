//
//  AmendmentsApiVC.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 16/12/23.
//

import UIKit
import AVKit

class AmendmentsApiVC: UIViewController {
   
    var data:AmendentsModel?

    
    @IBOutlet weak var imageView: UIImageView!
    
   
    @IBOutlet weak var textView: UITextView!
    
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
