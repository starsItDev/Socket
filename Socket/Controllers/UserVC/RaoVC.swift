//
//  RaoVC.swift
//  Socket
//
//  Created by StarsDev on 11/01/2024.
//

import UIKit

class RaoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func userIDBtnOne(_ sender: UIButton) {
        if let RaoCV = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC {
            RaoCV.accessToken = "2a5b7d1b0f6a4ff9341d60d1eb2cef12c7be12d00e9be368a6afb6f9a044c9cd83f58619323925141ce4fe042832e6bd7d06697a43055373"
            RaoCV.userName = "raoahmad"
            RaoCV.sendMessagetoID = "31136"
            RaoCV.messageSenderName = "Ali Sher"
            navigationController?.pushViewController(RaoCV, animated: true)
        }
    }
    @IBAction func userIDBtnTwo(_ sender: UIButton) {
        if let RaoCV = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC {
            RaoCV.accessToken = "2a5b7d1b0f6a4ff9341d60d1eb2cef12c7be12d00e9be368a6afb6f9a044c9cd83f58619323925141ce4fe042832e6bd7d06697a43055373"
            RaoCV.userName = "raoahmad"
            RaoCV.sendMessagetoID = "31188"
            RaoCV.messageSenderName = "SomeOne"
            navigationController?.pushViewController(RaoCV, animated: true)
        }
    }

}
