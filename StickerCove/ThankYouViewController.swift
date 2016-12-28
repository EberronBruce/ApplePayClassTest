//
//  ThankYouViewController.swift
//  StickerCove
//
//  Created by Bruce Burgess on 12/27/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class ThankYouViewController: UIViewController {

    @IBOutlet weak var thankYouLabel: UILabel!
    
    var email = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.thankYouLabel.text = "Your order has been completed and a receipt has been sent to \(self.email). Thank you for your purchase! 🤗"
        
        //let confettieView = SAConfettiView(frame: self.view.bounds)
       //self.view.addSubview(confettieView)
        //confettieView.stopConfetti()
    }

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
