//
//  CaseStudyAPIVC.swift
//  ConstitutionOfIndia
//
//  Created by Jon Snow on 07/01/24.
//

import UIKit

class CaseStudyAPIVC: UIViewController {
  
    var data:CaseStudyModel?
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
      
       
        textView.text = data?.small_description
        titleLabel.text = data?.title
        
        
    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
