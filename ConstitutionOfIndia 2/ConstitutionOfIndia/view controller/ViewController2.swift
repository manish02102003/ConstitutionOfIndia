//
//  ViewController2.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 12/12/23.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func navi3(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "DashBoardViewController") as! DashBoardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
