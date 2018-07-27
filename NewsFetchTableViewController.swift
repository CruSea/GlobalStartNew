//
//  NewsFetchTableViewController.swift
//  globalstart
//
//  Created by Buty on 7/7/18.
//  Copyright © 2018 globalstart. All rights reserved.
//


import UIKit
import SDWebImage
import SystemConfiguration

class NewsFetchTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let apiUrl = "http://api.globalstart.agelgel.net/api/news"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!


    
    var titleArray = [String]()
    var descArray = [String]()
    var imageArray = [String]()
    var dateArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.backgroundColor = UIColor(red: 38.0/255.0, green: 64.0/255.0, blue: 103.0/255.0, alpha: 1.0)
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.orange]
        
        self.tableView.isHidden = true
        self.loading.isHidden = true
        
        checkInternet()
        
    }
    
    func checkInternet() {
        if isInternetAvailable() {
            getJsonFromUrl()

        } else {
            let alertController = UIAlertController(title: "Please Connect To internet", message: "Turn on cellular data or use Wi-Fi to access data.", preferredStyle: UIAlertControllerStyle.alert)
            let buttonCancel = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel) { (action) -> Void in
                print("Cancel Button Pressed")
            }
            let buttonOne = UIAlertAction(title: "Settings", style: UIAlertActionStyle.default, handler: { (action) -> Void in
                
                if let url = URL(string: UIApplicationOpenSettingsURLString){
                    if #available(iOS 10.0, *){
                        UIApplication.shared.open(url, completionHandler: nil)
                    } else{
                        UIApplication.shared.openURL(url)
                    }
                }
            })
            
            alertController.addAction(buttonCancel)
            alertController.addAction(buttonOne)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func getJsonFromUrl() {
        
        self.loading.isHidden = false
        self.loading.startAnimating()
        guard let url = URL(string: apiUrl) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data , _, _) in
            guard let data = data else { return }
            
            do {
                let items = try JSONDecoder().decode(News.self, from: data)
                
                for item in items.news.data {
                    self.titleArray.append(item.title)
                    self.descArray.append(item.description)
                    self.imageArray.append(item.image)
                    self.dateArray.append(item.created_at)
                    
                    DispatchQueue.main.async {
                        self.loading.stopAnimating()
                        self.loading.isHidden = true
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                    }
                }
            } catch {}
        }
        task.resume()
    }
    
    
    // MARK: - Table view data source
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleArray.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell", for: indexPath) as! UsersTableViewCell
        
        // Configure the cell...
        cell.summarynews.text = descArray[indexPath.row]
        cell.titlenews.text = titleArray[indexPath.row]
        let images = imageArray[indexPath.row]
        cell.newsimage.sd_setImage(with: URL(string: "http://localhost:9090/\(images)"), placeholderImage: UIImage(named: "global_start"))
        
        let isoDate = dateArray[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let pastDate = dateFormatter.date(from:isoDate)!
        let realData = pastDate.timeAgoDisplay()
        cell.pubdatenews.text = realData
        
        
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "newsDetail") {
            print("in")
            
            let VC = segue.destination as! NewsDetailViewController
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = titleArray[indexpath.row] as String
                print("title: \(Title)")
                VC.titleData = Title
                
                let pubdate = dateArray[indexpath.row] as String
                print("date: \(pubdate)")

                VC.dateData = pubdate
                
                let Imageview = imageArray[indexpath.row] as String
                print("image: \(Imageview)")

                VC.imageData = Imageview
                let detailDesc = descArray[indexpath.row] as String
                print("body: \(detailDesc)")

                VC.bodyData = detailDesc
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }

    
    
}
extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let days = 48 * hour
        let week = 7 * day
        let month = 30 * day
        let year = 12 * month
        
        if secondsAgo < minute {
            return "\(secondsAgo) seconds ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) minutes ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hours ago"
        }else if secondsAgo < days {
            return "\(secondsAgo / day) day ago"
        }
        else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        } else if secondsAgo < month {
            return "\(secondsAgo / week) weeks ago"
        }
            
        else if secondsAgo < year {
            return "\(secondsAgo / month) months ago"
        }
        
        return "\(secondsAgo / year) years ago"
    }
}


