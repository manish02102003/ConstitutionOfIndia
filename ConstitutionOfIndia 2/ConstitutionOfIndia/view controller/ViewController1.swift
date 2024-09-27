//
//  ViewController1.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 12/12/23.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func navi2(_ sender: UIButton) {let vc = storyboard?.instantiateViewController(identifier: "ViewController2") as! ViewController2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
}
