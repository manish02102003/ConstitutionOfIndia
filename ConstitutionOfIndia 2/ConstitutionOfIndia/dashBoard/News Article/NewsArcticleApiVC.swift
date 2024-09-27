//
//  NewsArcticleApiVC.swift
//  ConstitutionOfIndia
//
//  Created by Jon Snow on 06/01/24.
//

import UIKit


class NewsArcticleApiVC: UIViewController {
  
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var data : NewsArticleModel?
    override func viewDidLoad() {
        super.viewDidLoad()

      
       
        textView.text = data?.small_description
        titleLabel.text = data?.title
        dateLabel.text = data?.date
       
    }
    
    
    @IBAction func backbtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
