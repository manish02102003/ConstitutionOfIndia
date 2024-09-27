//
//  AboutVC.swift
//  ConstitutionOfIndia
//
//  Created by Jon Snow on 08/01/24.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Constitution of India \n By Manish Singh"
        descriptionLabel.text = "Empowering knowledge on India's Constitition: You go-to app for a comprehensive understanding of our rights,laws, and democratic principles. Explore,learn, and celebrate our constitutional heritage.together,let's uphold justice,equality,and freedom."
        versionLabel.text = "Version 1.0"
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
   

}
