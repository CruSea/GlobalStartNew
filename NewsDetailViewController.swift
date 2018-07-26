//
//  NewsDetailViewController.swift
//  globalstart
//
//  Created by Muluken on 3/20/17.
//  Copyright © 2017 globalstart. All rights reserved.
//

import UIKit
import SDWebImage

class NewsDetailViewController: UIViewController {
    
   
    @IBOutlet weak var detailtitle: UILabel!
    
 
    @IBOutlet weak var imagedetail: UIImageView!
    
    @IBOutlet weak var detaildesc: UITextView!
    
    @IBOutlet weak var pubdate: UILabel!
    
    
    var SentData1:String!
    var SentData2:String!
    var SentData3:String!
    var SentData4:String!
    var SentData5:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.backgroundColor = UIColor(red: 38.0/255.0, green: 64.0/255.0, blue: 103.0/255.0, alpha: 1.0)
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.orange]
        configureCell()
        
      
   }
    func configureCell(){
        
        self.detailtitle.text = SentData1

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let pastDate = dateFormatter.date(from: SentData2)!
        let realData = pastDate.timeAgoDisplay()
        self.pubdate.text = realData

        
        
        self.detaildesc.text = SentData4

        let imageURL = SentData3

        
        self.imagedetail.sd_setImage(with: URL(string: "http://api.globalstart.agelgel.net/\(imageURL!)"), placeholderImage: UIImage(named: "global_start"))
        print(self.imagedetail)

    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
