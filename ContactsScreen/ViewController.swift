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

extension UIImage {
       convenience init?(url: URL?) {
              guard let url = url else { return nil }
              do {
                     self.init(data: try Data(contentsOf: url))
              } catch {
                     print("Cannot load image from url: \(url) with error: \(error)")
                     return nil
              }
       }
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
              self.view.layoutMargins = UIEdgeInsets.zero
              
            
              
              
       }
       func getContacts() {
              AF.request("https://api.mocki.io/v1/63168fa6")
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
              let verticalPadding: CGFloat = 8
              
              let maskLayer = CALayer()
              maskLayer.cornerRadius = 12    //if you want round edges
              maskLayer.backgroundColor = UIColor.black.cgColor
              maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/4)
              cell.layer.mask = maskLayer
       let oldFrame = cell.contentView.frame
              cell.contentView.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.size.width + 10, height: oldFrame.size.height)
              cell.indentationLevel = 2;
            
              
              
              
              
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
              cell._nameL?.text = currentContact.firstName + " " + currentContact.lastName
              cell._phoneNumber?.text = currentContact.number
              cell.contentView.layer.cornerRadius = 12
              cell.contentView.layer.borderWidth = 3
              cell.contentView.layer.borderColor = UIColor(red: 0.84, green: 0.85, blue: 0.86, alpha: 1.00).cgColor
              let firtsNameChar = String(Array(currentContact.firstName)[0])
              let lastNameChar = String(Array(currentContact.lastName)[0])
              
              
              if currentContact.photo.isEmpty  {
                     cell.imageLabel.text = firtsNameChar + lastNameChar
              }
              else{
                     //  cell.imageLabel = nil
                     cell.imageLabel.isHidden = true
                     cell.imagePhoto.image = UIImage(url: URL(string: currentContact.photo))
              }
              
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
            //  for str in [Contacts] {
                  //   searchedArray.append("str")
              //}
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
