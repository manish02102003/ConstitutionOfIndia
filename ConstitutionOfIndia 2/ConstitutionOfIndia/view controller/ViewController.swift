//
//  ViewController.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 12/12/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func navi1BTn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ViewController1") as! ViewController1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

