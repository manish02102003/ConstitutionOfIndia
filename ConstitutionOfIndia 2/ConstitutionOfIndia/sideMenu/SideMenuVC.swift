//
//  SideMenuVC.swift
//  ConstitutionOfIndia
//
//  Created by Jon Snow on 05/01/24.
//

import UIKit
import StoreKit
struct SideMenuDetail:Codable{
    var name:String
    var image:String
}
protocol DarkModeToggleDelegate:AnyObject{
    func toggleDarkMode(isDarkModeEnable: Bool )
    
}
class SideMenuVC: UIViewController {
    let SideMenuDash:[SideMenuDetail] = [
       
        SideMenuDetail(name: "Home", image: "home"),
        SideMenuDetail(name: "Notification", image: "notification"),
        SideMenuDetail(name: "Notes", image: "notes"),

        SideMenuDetail(name: "Rate us", image: "rate us"),
        SideMenuDetail(name: "Share App", image: "share"),
        SideMenuDetail(name: "About", image: "about")
        
    ]
   
     var darkModeDelegate : DarkModeToggleDelegate?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
   }
}
extension SideMenuVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideMenuDash.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTVC", for: indexPath)
        as! SideMenuTVC
        cell.imageSide.image = UIImage(named: SideMenuDash[indexPath.row].image)
        cell.imageSide.tintColor = UIColor.white
        cell.sideMenuLabel.text = SideMenuDash[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            dismiss(animated: true, completion: nil)
        
        case 1:
            let vc = storyboard?.instantiateViewController(identifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = storyboard?.instantiateViewController(identifier: "NotesVc") as! NotesVc
            self.navigationController?.pushViewController(vc, animated: true)
//
        case 3:
            if #available(iOS 17.0, *) {
                       SKStoreReviewController.requestReview()
                   } else {
                       // Fallback for older iOS versions (you can redirect the user to the App Store)
                       if let appStoreURL = URL(string: "https://itunes.apple.com/app/idYOUR_APP_ID") {
                           UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                       }
                   }
        case 4:
            let shareText = "Check out this amazing app!"
                   let shareURL = URL(string: "https://yourappwebsite.com")!

                   // Create an array of items to share
                   let items: [Any] = [shareText, shareURL]

                   // Create an activity view controller
                   let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)

                   // Exclude some activities from the list (optional)
                   activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop]

                   // Present the activity view controller
                   present(activityViewController, animated: true, completion: nil)
        case 5:
            let vc = storyboard?.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("error")
        }
       
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
