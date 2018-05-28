//
//  SendViewController.swift
//  globalstart
//
//  Created by Muluken on 2/24/17.
//  Copyright © 2017 globalstart. All rights reserved.
//

import UIKit

class SendViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.backgroundColor = UIColor(red: 38.0/255.0, green: 64.0/255.0, blue: 103.0/255.0, alpha: 1.0)
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.orange]
        
    }


    @IBAction func back(_ sender: Any) {
    
        self.dismiss(animated: true, completion: nil)

    }
    
    

    @IBAction func takeAction(_ sender: Any) {
        let text = "1. What are ways that students can take ownership of the ministry and develop into multipliers of the faith? " +
        "\n\n2. What can you do to help develop students to be the leaders God desires them to be; leaders who will go into all the world and make disciples?"
        let Alert = UIAlertController(title: "Take Action", message: text , preferredStyle: .alert)
        
        let DismissButton = UIAlertAction(title: "Close", style: .cancel, handler: {
            
            (alert: UIAlertAction!) -> Void in
            
        })
        
        Alert.addAction(DismissButton)
        //text alignmnnt in take action view
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.left
        
        let messageText = NSMutableAttributedString(
            string: text,
            attributes: [
                NSAttributedStringKey.paragraphStyle: paragraphStyle,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13.0)
            ]
        )
        Alert.setValue(messageText, forKey: "attributedMessage")
        
        self.present(Alert, animated: true, completion: nil)

    }
  

}
