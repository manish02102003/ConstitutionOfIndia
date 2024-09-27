//
//  PreambleVC.swift
//  ConstitutionOfIndia
//
//  Created by Vikas Hareram Shah on 13/12/23.
//

import UIKit
import AVKit
import SDWebImage

struct PreambleModel : Codable{
    var id : String?
    var title : String?
    var image : String?
    var description : String?
}

class PreambleVC: UIViewController {

//    var player = AVPlayer()
    
    var PreambleData = [PreambleModel]()
    let synthesizer = AVSpeechSynthesizer()

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        apiCalling()

        if let urlimaga = URL(string: "https://mapi.trycatchtech.com/uploads/constitution_of_india/00e76c27d34b87928d19778cced28bea.jpg"){
            imageView.sd_setImage(with: urlimaga,placeholderImage: UIImage(named: "placeholder.png"))
        }

        
    }
    
    func apiCalling(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/constitution_of_india/constitution_of_india_preamble") else {return}

        let urlrequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlrequest){ data,response,error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let jsondata = try JSONDecoder().decode([PreambleModel].self, from: data)
                    print(jsondata[0].image ?? "")
                    DispatchQueue.main.async {
                        self.textView.text = jsondata[0].description
                    }
                  
                }catch{
                    print("error in do block")
                }
               
                
            }
            
        }.resume()
    }

    @IBAction func preamblesongBtn(_ sender: UIButton) {
        guard let textToRead = textView.text else { return }
        let utterance = AVSpeechUtterance(string: textToRead)
               utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
               synthesizer.speak(utterance)
        
        
//        guard let url = URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3"
//                                ) else{return}
//        player = AVPlayer(url: url)
//        player.play()
//        
//        "https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3"
    }
    
    
    @IBAction func stopAudioBTN(_ sender: UIButton) {
        if synthesizer.isSpeaking {
               synthesizer.pauseSpeaking(at: .immediate)
           }

    }
    @IBAction func ResumeAudioBTN(_ sender: Any) {
        if synthesizer.isPaused {
                   synthesizer.continueSpeaking()
               }

    }
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
