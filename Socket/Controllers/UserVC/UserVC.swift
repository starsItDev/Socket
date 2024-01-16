//
//  UserVC.swift
//  Socket
//
//  Created by StarsDev on 26/12/2023.

import UIKit

class UserVC: UIViewController {
    
    @IBOutlet weak var userIDOne: UIButton!
    @IBOutlet weak var userIDTwo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func userIDBtnOne(_ sender: UIButton) {
        if let RaoCV = storyboard?.instantiateViewController(withIdentifier: "RaoVC") as? RaoVC {
//            RaoCV.accessToken = "682e083c135e4f119240899840800f0ae6a6e4deba1aad88a26e8d9dbd38d06a25a72c344410839146c67bed153cfbe02079aa014f3d6387"
//            RaoCV.userName = "raoahmad"
//            RaoCV.sendMessagetoID = "31136"
//            RaoCV.messageSenderName = "Ali Sher"
            navigationController?.pushViewController(RaoCV, animated: true)
        }
    }
    @IBAction func userIDBtnTwo(_ sender: UIButton) {
        if let AliCV = storyboard?.instantiateViewController(withIdentifier: "AliSherVC") as? AliSherVC {
//            AliCV.accessToken = "b0ba1d94d931c06123731a46f285dc1aabf4810ec941a08f446d5bc18bd98c1bb0efc983510960943f9e3767ef3b10a0de4c256d7ef9805d"
//            AliCV.userName = "alisher"
//            AliCV.sendMessagetoID = "31137"
//            AliCV.messageSenderName = "Rao Ahmad"
            navigationController?.pushViewController(AliCV, animated: true)
        }
    }
    @IBAction func userIDBtnThree(_ sender: UIButton) {
        if let UsmanCV = storyboard?.instantiateViewController(withIdentifier: "UsmanVC") as? UsmanVC {
//            UsmanCV.accessToken = "93e1551d2394be08fa0c19d8a50cbdc6d6140e6696ef34a54adb11e4949dbb065ca522ac42929682f1b8b7b3ceb65c188dcdc0851634cadf"
//            UsmanCV.userName = "usmanahmad"
//            UsmanCV.sendMessagetoID = "31136"
            navigationController?.pushViewController(UsmanCV, animated: true)
        }
    }

}
