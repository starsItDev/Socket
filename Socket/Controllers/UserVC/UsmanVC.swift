//
//  UsmanVC.swift
//  Socket
//
//  Created by StarsDev on 11/01/2024.
//

import UIKit

class UsmanVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func userIDBtnOne(_ sender: UIButton) {
        if let RaoCV = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC {
            RaoCV.accessToken = "7c7e37396ad3c4b88c8db708b1c34cbea754760f5125c733b1e33594d9c8e9830464f47223063557e00944d55e6432ccf20f9fda2492b6fd"
            RaoCV.userName = "usmanahmad"
            RaoCV.sendMessagetoID = "31136"
            RaoCV.messageSenderName = "Ali Sher"
            navigationController?.pushViewController(RaoCV, animated: true)
        }
    }
    @IBAction func userIDBtnTwo(_ sender: UIButton) {
        if let RaoCV = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC {
            RaoCV.accessToken = "7c7e37396ad3c4b88c8db708b1c34cbea754760f5125c733b1e33594d9c8e9830464f47223063557e00944d55e6432ccf20f9fda2492b6fd"
            RaoCV.userName = "usmanahmad"
            RaoCV.sendMessagetoID = "31137"
            RaoCV.messageSenderName = "Rao Ahmad"
            navigationController?.pushViewController(RaoCV, animated: true)
        }
    }
}
