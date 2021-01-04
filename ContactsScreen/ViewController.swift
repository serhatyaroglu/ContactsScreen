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
class ViewController: UIViewController{
       @IBOutlet weak var searchBarTextField: UITextField!
       @IBOutlet weak var ButtonRadius: UIButton!
       @IBOutlet weak var SearchIcon: UIButton!
       @IBOutlet weak var tableview: UITableView!
       var Contacts = [Contact]()
       var originalArr = [Contact]();
       var searchArrRes = [[String:Any]]()
       var searching:Bool = false
       //  var contacts : [Contact] = ContactSource.contacts
       // var sectionContacs : [[Contact]] = ContactRequest.
       var apiResult : ApiResult? = nil
       var searchedKey:String = ""
       var dataList : [Contact] = [Contact]()
       
       var  CheckIcon = UIImage(named: "check")
       var  CheckIconNon = UIImage(named: "checknon")
       override func viewWillAppear(_ animated: Bool) {
              getContacts()
              print(self.Contacts)
       }
       override func viewDidLoad() {
              super.viewDidLoad()
              /*
               let grouped = Dictionary(grouping: Contacts){
               (Contacts) -> Character in
               return Contacts.firstName.first!
               }
               var groupedFirstName = [Contacts]
               let keys = grouped.keys.sorted()
               keys.forEach {(key) in
               groupedFirstName.append(grouped[key]!)
               }
               groupedFirstName.forEach({
               $0.forEach({print($0)})
               tableview.reloadData()
               })
               */
              for contactsSearch in [Contacts] {
                     Contacts.append(contentsOf: contactsSearch)
              }
              //  getContacts()
              //   print(self.Contacts)
         
              // get the keys and sort them
              //let keys = groupedDictionary.keys.sorted()
              // map the sorted keys to a struct
              //  sections = keys.map{ Section(letter: $0, names: groupedDictionary[$0]!.sorted()) }
              
             // originalArr = Contacts
              
              tableview.reloadData()
              tableview.delegate = self
              tableview.dataSource = self
              ButtonRadius.layer.cornerRadius = 12
              tableview.layer.cornerRadius = 12
              searchBarTextField.delegate = self
              self.view.layoutMargins = UIEdgeInsets.zero
              ButtonRadius.translatesAutoresizingMaskIntoConstraints = false
              searchBarTextField.translatesAutoresizingMaskIntoConstraints = false
              searchBarTextField.widthAnchor.constraint(equalToConstant: 293).isActive = true
              searchBarTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
              searchBarTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55).isActive = true
              searchBarTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
              ButtonRadius.widthAnchor.constraint(equalToConstant: 343).isActive = true
              ButtonRadius.heightAnchor.constraint(equalToConstant: 48).isActive = true
               
              ButtonRadius.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
              ButtonRadius.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
              ButtonRadius.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -37).isActive = true
       }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              let indeks = sender as? Int
              let currentcontact = Contacts
              if segue.identifier == "ToDetail"{
                  let gidilecekVC = segue.destination as! DetailViewController
                   

                     if indeks != nil {
                            gidilecekVC.Nesne = currentcontact[indeks!]
                     }
                  
                  //   let str = currentcontact[indeks].firstName
                     
              }
             
       }
       
      /* struct ContactRequest {
        let resourceURL:URL
        let API_KEY = "dd30918e"
        init(contactCode:String) {
            let resourceString = "https://api.mocki.io/v1/\(API_KEY)"
            guard let resourceURL = URL(string: resourceString) else {fatalError()}
            self.resourceURL = resourceURL
        }
 }
 func AllPersonTake(){
        AF.request("https://api.mocki.io/v1/dd30918e",method: .pos).responseJSON{
               response in
               if let data = response.data{
                      do{
                             let decoder = JSONDecoder()
                             let answer = try decoder.decode(PersonAnswer.self, from: data)
                             if let gelenKisiListesi = cevap.Contact{
                                 self.Contacts = gelenKisiListesi
                             }else{
                                 self.Contacts = [Contact]()
                             }
                             DispatchQueue.main.async {
                                 self.tableview.reloadData()
                             }
                      }
               }
              }
 }
  */
       func getContacts() {
              AF.request("https://api.mocki.io/v1/dd30918e")
                     .validate()
                     .responseDecodable(of: ApiResult.self) {
                            (response) in
                            guard let apiResultFromResponse = response.value else{return}
                            self.Contacts = apiResultFromResponse.response.contacts
                            print(self.Contacts)
                            //print( self.apiResult!.metas.code )
                     }
       }
       // func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       //      return sections.map{$0.letter}
       //}
       //func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       //     return sections[section].letter
       //}
       
       override func didReceiveMemoryWarning() {
              super.didReceiveMemoryWarning()
       }
       
}
extension ViewController:UITextFieldDelegate{
       
       /*
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        //input text
        let searchText  = textField.text! + string
        //add matching text to arrya
        searchArrRes = self.originalArr.filter({(($0[originalArr.first?.firstName] as! String).localizedCaseInsensitiveContains(searchText))})
        
        if(searchArrRes.count == 0){
        searching = false
        }else{
        searching = true
        }
        self.tableView.reloadData();
        
        return true
        }
        */
       
       func textFieldShouldClear(_ textField: UITextField) -> Bool{
              searchBarTextField.resignFirstResponder()
              searchBarTextField.text = Contacts.first?.firstName
              self.Contacts.removeAll()
              for contactsSearch in [Contacts] {
                     Contacts.append(contentsOf: contactsSearch)
              }
              
              tableview.reloadData()
              return false
       }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool{
              
              if searchBarTextField.text?.count != 0 {
                     self.Contacts.removeAll()
                     for contactsSearch in Contacts {
                            let range = searchedKey.description.range(of: (textField.text)!, options: .caseInsensitive, range: nil, locale: nil)
                            //.firstName.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                            
                            if range != nil{
                                   self.Contacts.append(contactsSearch)
                            }
                     }
              }
              tableview.reloadData()
              return true
       }
}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
              let verticalPadding: CGFloat = 8
              let maskLayer = CALayer()
              maskLayer.cornerRadius = 12    //if you want round edges
              maskLayer.backgroundColor = UIColor.black.cgColor
              maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 1, dy: verticalPadding/6)
              cell.layer.mask = maskLayer
              let oldFrame = cell.contentView.frame
              cell.contentView.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.size.width + 10, height: oldFrame.size.height)
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
              cell._nameL.text = currentContact.firstName + " " + currentContact.lastName
              
              cell._phoneNumber?.text = currentContact.number
              cell.contentView.layer.cornerRadius = 12
              cell.contentView.layer.borderWidth = 3
              cell.contentView.layer.shadowColor = UIColor(red: 0.84, green: 0.85, blue: 0.86, alpha: 1.00).cgColor
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
              let apiNumberEmpty = "-"
              if currentContact.number.isEmpty  {
                     cell._phoneNumber.text = apiNumberEmpty
                     cell._check.image = CheckIconNon
              }
              else{
                     cell._check.image = CheckIcon
              }
              
              // let groupByCategory = Dictionary(grouping: currentContact.firstName, by: [currentContact.firstName(String ($0))])
              // let groupByCategory = Dictionary(grouping: currentContact.firstName{String ($0)})
              // let dictionary = Dictionary(grouping: currentContact.firstName, by: { (element: Contact) in
              //  return element.name
              //})
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
             /* let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
              let currentContact = Contacts[indexPath.row]

              vc?.Nesne = currentContact.firstName
              self.navigationController?.pushViewController(vc!, animated: true)*/
              let rowid = indexPath.row
              performSegue(withIdentifier: "ToDetail", sender: rowid)
              //performSegue(withIdentifier: "ToDetail", sender: Contacts[indexPath.item])
       }
       func numberOfSections(in tableView: UITableView) -> Int {
              return 2
       }
       
     /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if segue.identifier == "showContact"{
                     if let indexPath = tableview.indexPathForSelectedRow{
                            let selectedContact = Contacts[indexPath.row]
                            let detailContactViewController = navigationController?.topViewController as? DetailViewController
                            detailContactViewController?.contact = selectedContact
                            
                     }
              }
       }*/
       
}

