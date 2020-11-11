//
//  ViewController.swift
//  ContactsScreen
//
//  Created by serhat yaroglu on 6.10.2020.
//

import UIKit
import Alamofire
struct Section {
    let letter : String
    let names : [String]
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
       @IBOutlet weak var searchBarTextField: UITextField!
       @IBOutlet weak var ButtonRadius: UIButton!
       @IBOutlet weak var SearchIcon: UIButton!
       @IBOutlet weak var tableview: UITableView!
       
       var Contacts = [Contact]()
       var apiResult : ApiResult? = nil
       
       var searchedArray:[String] = Array()
       var sections = [Section]()
       
       override func viewWillAppear(_ animated: Bool) {
              getContacts()
              print(self.Contacts)
       }
       
       override func viewDidLoad() {
              super.viewDidLoad()
              
              
             for str in [Contacts] {
searchedArray.append("str")
              }
              //let groupedDictionary = Dictionary(grouping: kisiIsimleri, by: {String($0.prefix(1))})
              // get the keys and sort them
              //let keys = groupedDictionary.keys.sorted()
              // map the sorted keys to a struct
            //  sections = keys.map{ Section(letter: $0, names: groupedDictionary[$0]!.sorted()) }
              tableview.reloadData()
              tableview.delegate = self
              tableview.dataSource = self
              ButtonRadius.layer.cornerRadius = 12
              tableview.layer.cornerRadius = 12
              searchBarTextField.delegate = self
       }
       
       func getContacts() {
              AF.request("https://api.mocki.io/v1/64582eee")
                     .validate()
                     .responseDecodable(of: ApiResult.self) {
                            (response) in
                            guard let apiResultFromResponse = response.value else{return}
                            self.Contacts = apiResultFromResponse.response.contacts
                            print(self.Contacts)
                            //print( self.apiResult!.metas.code )
                            
                     }
       }
       
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
              tableView.separatorInset = UIEdgeInsets.zero
              tableView.layoutMargins = UIEdgeInsets.zero
              cell.preservesSuperviewLayoutMargins = false
              cell.layoutMargins = UIEdgeInsets.zero
              cell.separatorInset = UIEdgeInsets.zero
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return Contacts.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! KisilerTableViewCell
             // let section = sections[indexPath.section]
              //let Section = section.names[indexPath.row]
              
              
              //TO DO : use contact request and get data from api at here
              //ContactRequest.getContacts(<#T##self: ContactRequest##ContactRequest#>)
              
              let currentContact = Contacts[indexPath.row]
              
              cell._nameL?.text = currentContact.name
              cell._phoneNumber?.text = currentContact.number
             // if !currentContact.photo.isEmpty{
                     //cell._ImageP?. = currentContact.name
                     // to do : url image nasil yuklenecegini arastirip duzelt.
                     
                     
            //  }else{
                     // fotograf yoktur ve texti al 
            //  }
              
              let oldFrame = cell.contentView.frame
              cell.contentView.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.size.width + 10, height: oldFrame.size.height)
              cell.backgroundColor = .clear // very important
              cell.frame.size.width = tableView.frame.size.width
              tableView.separatorInset = UIEdgeInsets.zero
              tableView.layoutMargins = UIEdgeInsets.zero
              cell.layoutMargins = UIEdgeInsets.zero
              cell.layer.masksToBounds = false
              cell.layer.shadowOpacity = 0.23
              cell.layer.shadowRadius = 4
              cell.layer.shadowOffset = CGSize(width: 0, height: 0)
              cell.layer.shadowColor = UIColor.black.cgColor
              //cell._phoneNumber.text = Contacts[indexPath.row].number
                    // print(indexPath.row)
              //              if indexPath.row==10{
              //                     cell._nameL.text = self.kisiIsimleri[indexPath.row]
              //              }
              //              if indexPath.row==1 {
              //                     cell._ImageP.image = kisiResimleri[indexPath.row]
              //              }
              //              if indexPath.row<2 {
              //                     cell._check.image = kisiIcon[indexPath.row]
              //              }
              
              return cell
              
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              performSegue(withIdentifier: "ContactInfo", sender: Contacts[indexPath.row])
          }
       
       func numberOfSections(in tableView: UITableView) -> Int {
              return 1
       }
    
       func sectionIndexTitles(for tableView: UITableView) -> [String]? {
              return sections.map{$0.letter}
       }
       
      // func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      //        return sections[section].letter
      // }
       func textFieldShouldClear(_ textField: UITextField) -> Bool{
              searchBarTextField.resignFirstResponder()
              searchBarTextField.text = ""
              self.searchedArray.removeAll()
              for str in [Contacts] {
                     searchedArray.append("str")
              }
              tableview.reloadData()
              return false
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool{
              if searchBarTextField.text?.count != 0 {
                     self.searchedArray.removeAll()
                     
              }
              tableview.reloadData()
              return true
       }
       override func didReceiveMemoryWarning() {
              super.didReceiveMemoryWarning()
       }
}
