//
//  DetailViewController.swift
//  ContactsScreen
//
//  Created by serhat yaroglu on 22.12.2020.
//

import Foundation
import UIKit
import MessageUI
class DetailViewController: UIViewController,MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var DetailFirstName: UILabel!
    
    @IBOutlet weak var DetailProfilImg: UIImageView!
    
    @IBOutlet weak var DetailImgLabelName: UILabel!
  
    @IBOutlet weak var DetailInfoLabel: UILabel!
    
    @IBOutlet weak var phoneLabel1: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    
    @IBOutlet weak var containerPhone: UIView!
    @IBOutlet weak var containerProfil: UIView!
    @IBOutlet weak var phoneLabel2: UILabel!
    fileprivate let application = UIApplication.shared
    var Nesne : Contact?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let current = Nesne{
            let firtsNameChar = String(Array(current.firstName)[0])
            let lastNameChar = String(Array(current.lastName)[0])
            DetailFirstName.text = current.firstName + " " +  current.lastName
            if current.photo.isEmpty  {
                   DetailImgLabelName.text = firtsNameChar + lastNameChar
            }
            else{
                   //  cell.imageLabel = nil
                DetailImgLabelName.isHidden = true
                   DetailProfilImg.image = UIImage(url: URL(string: current.photo))
            }
            phoneLabel1.text = current.number
            phoneLabel2.text = current.number
        }
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
       
        //applyView()
    }
   /*
    func applyView(){
        
        guard let contact = contact else{return}
        self.DetailInfoLabel.text = contact.firstName
        self.DetailImgLabelName.text = contact.lastName
        print(contact.firstName)
        let firtsNameChar = String(Array(contact.firstName)[0])
   
        if contact.photo.isEmpty  {
            DetailImgLabelName.text = firtsNameChar
        }
        else{
               //  cell.imageLabel = nil
            DetailImgLabelName.isHidden = true
            DetailProfilImg.image = UIImage(url: URL(string: contact.photo))
        }
    }
    
    */
    @IBAction func DetailCallButton(_ sender: Any) {
        let url:NSURL = URL(string: (Nesne!.number))! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
    
    @IBAction func DetailEMail(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
     
        mail.setToRecipients(["abc@gmail.com","xyz@gmail.com"])
        mail.setMessageBody("<h1>mesajinizi buraya girin.<h1>", isHTML: true)
        present(mail, animated: true)
        } else {
        print("mesajiniz gonderilemedi")
        }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        }
    }
    
    
    @IBAction func DetailSms(_ sender: Any) {
        if (MFMessageComposeViewController.canSendText()) {
        let controller = MFMessageComposeViewController()
        controller.body = "serhat"
            controller.recipients = [String(Nesne!.number)]
        controller.messageComposeDelegate = self as? MFMessageComposeViewControllerDelegate
        self.present(controller, animated: true, completion: nil)
        }
      
        else{
        print("mesajiniz gonderilemedi")
        }
        func messageComposeViewController(controller:
        MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        //Displaying the message screen with animation.
        self.dismiss(animated: true, completion: nil)
        }
    }
    }
    
    
  


