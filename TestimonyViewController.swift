//
//  TestimonyViewController.swift
//  globalstart
//
//  Created by Muluken on 3/8/17.
//  Copyright © 2017 globalstart. All rights reserved.
//

import UIKit
import Alamofire
//import Firebase
//import FirebaseDatabase

class TestimonyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var userDetail: UITextField!
    @IBOutlet weak var testimonyTitle: UITextField!
    @IBOutlet weak var detailTestmony: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    
    var picker = UIImagePickerController()
    let imageURL = "http://api.globalstart.agelgel.net/api/Testimony"
  //  let imageURL = "http://127.0.0.1:8000/api/donation_report"



    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        self.activityIndicator.isHidden = true

        detailTestmony.text = "story/idea/resource"
        detailTestmony.textColor = UIColor.lightGray

        self.detailTestmony.delegate = self

        
        // change backgrounf color of naviagtion bar
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.backgroundColor = UIColor(red: 38.0/255.0, green: 64.0/255.0, blue: 103.0/255.0, alpha: 1.0)
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

       
    }


    func textViewDidBeginEditing(_ textView: UITextView) {
        if detailTestmony.textColor == UIColor.lightGray {
            detailTestmony.text = nil
            detailTestmony.textColor = UIColor.black
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if detailTestmony.text.isEmpty {
            detailTestmony.text = "enter your story/idea/resource"
            detailTestmony.textColor = UIColor.lightGray
        }
        
    }
    
   
//    func showImagePicker() {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        imagePickerController.allowsEditing = false
//        imagePickerController.sourceType = .photoLibrary
//        present(imagePickerController, animated: true, completion: nil)
//    }
//
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = image
            imageButton.isHidden = true
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendTestimony(_ sender: Any) {
        
       
        
        // sendng testimony to firebase
    if let user = userDetail.text, let title = testimonyTitle.text, let detailTest = detailTestmony.text, (user.count > 0 && title.count > 0 && detailTest.count > 0) {
        
        let image = self.imageView.image
        let params: Parameters = ["title": title, "body": detailTest, "address": user ]
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if let imageData = UIImageJPEGRepresentation(image!, 0.6) {
                multipartFormData.append(imageData, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
            }
            for (key, value) in params
            {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: imageURL, method: .post ,headers:nil)
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON
                    { response in
                        //print response.result
                        if response.result.value != nil
                        {
                            print(response)
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            self.imageView.image = nil
                            self.imageButton.isHidden = false
                            
                            let alert1 = UIAlertController(title: "Sent!", message: "Your Testimony is Succesfully Sent", preferredStyle: .alert)
                            alert1.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert1, animated: true, completion: nil)
                            
                            let presentingViewController: UIViewController! = self.presentingViewController
                            
                            self.dismiss(animated: true) {
                                // go back to MainMenuView as the eyes of the user
                                presentingViewController.dismiss(animated: true, completion: nil)
                            }
                        }
                }
            case .failure(let encodingError):
                print("error:\(encodingError)")
                let alert1 = UIAlertController(title: "Error!", message: "Your Testimony is not Sent please try again!", preferredStyle: .alert)
                alert1.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert1, animated: true, completion: nil)
                
                let presentingViewController: UIViewController! = self.presentingViewController
                
                self.dismiss(animated: true) {
                    // go back to MainMenuView as the eyes of the user
                    presentingViewController.dismiss(animated: true, completion: nil)
                }
                
                break
            }
        }
        
        
        
    } else {
            let alert = UIAlertController(title: "All Fields are Required!", message: "Please fill all the required spaces before sending your testimony!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func uploadImage(_ sender: Any) {
       // showImagePicker()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }


}






