//
//  WinViewController.swift
//  globalstart
//
//  Created by Muluken on 2/24/17.
//  Copyright © 2017 globalstart. All rights reserved.
//

import UIKit

class WinViewController: UIViewController {


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

   
    @IBAction func winTakeAction(_ sender: Any) {
        let text = "\n1. Write down as many target groups among teenagers that you know about. " + "\n\n2. Think of ways that you would be able to connect with students from those target groups. " + "\n\n3. Think of creative ways that you can gather each target group and share the gospel with them. " + "\n\n4. Don’t forget to involve Christian high school students to help plan the event, gather their friends, and share their testimonies or the gospel."
        let Alert = UIAlertController(title: "Take Action", message: text, preferredStyle: .alert)
        
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
