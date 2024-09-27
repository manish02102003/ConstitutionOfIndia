//
//  NoticationTVC.swift
//  ConstitutionOfIndia
//
//  Created by Jon Snow on 08/01/24.
//

import UIKit

class NoticationTVC: UITableViewCell {
    @IBOutlet weak var notifactonDescription: UILabel!
    
    @IBOutlet weak var notIdlabel: UILabel!
    @IBOutlet weak var notIdpart: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
