//
//  AliSherVC.swift
//  Socket
//
//  Created by StarsDev on 11/01/2024.
//

import UIKit

class AliSherVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func userIDBtnOne(_ sender: UIButton) {
        if let RaoCV = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC {
            RaoCV.accessToken = "4041afa70851c6a3bdbe81dc032c3105d62c57a80e544de7cb69ec02a8c0aa7c218ccfc172444021bc05ca60f2f0d67d0525f41d1d8f8717"
            RaoCV.userName = "alisher"
            RaoCV.sendMessagetoID = "31137"
            RaoCV.messageSenderName = "Rao Ahmad"
            navigationController?.pushViewController(RaoCV, animated: true)
        }
    }
    @IBAction func userIDBtnTwo(_ sender: UIButton) {
        if let RaoCV = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC {
            RaoCV.accessToken = "4041afa70851c6a3bdbe81dc032c3105d62c57a80e544de7cb69ec02a8c0aa7c218ccfc172444021bc05ca60f2f0d67d0525f41d1d8f8717"
            RaoCV.userName = "alisher"
            RaoCV.sendMessagetoID = "31173"
            RaoCV.messageSenderName = "Usman"
            navigationController?.pushViewController(RaoCV, animated: true)
        }
    }

}
