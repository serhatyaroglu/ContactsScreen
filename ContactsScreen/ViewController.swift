//
//  ViewController.swift
//  ContactsScreen
//
//  Created by serhat yaroglu on 6.10.2020.
//

import UIKit
struct Section {
    let letter : String
    let names : [String]
}


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{

    
    @IBOutlet weak var searchBarTextField: UITextField!
    
    @IBOutlet weak var ButtonRadius: UIButton!
    
    
    @IBOutlet weak var SearchIcon: UIButton!
    
    
    @IBOutlet weak var tableview: UITableView!
    
  
       
    var searchedArray:[String] = Array()
    
       var sections = [Section]()
    
    var kisiIsimleri = ["faruk yaroglu","batu ALi","saziye Fatma","kirca yaroglu","burak ALi","ozcan Fatma","seda yaroglu","yusuf ALi","deniz Fatma","kirali yaroglu","birol ALi","apple Fatma"]
       
 
    var kisiNumaralari = ["+934564519","+904453264519","+94234564519","+904564519","+90453264519","+90234564519","+904564519","+90453264519","+90234564519","+904564519","+90453264519","+90234564519"]
    var kisiResimleri = [UIImage(named: "duman"),UIImage(named: "duman2"),]
    
    var kisiIcon = [UIImage(named: "check"),UIImage(named: "check1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       for str in kisiIsimleri {
            searchedArray.append(str)
        }
           let groupedDictionary = Dictionary(grouping: kisiIsimleri, by: {String($0.prefix(1))})
           // get the keys and sort them
           let keys = groupedDictionary.keys.sorted()
           // map the sorted keys to a struct
           sections = keys.map{ Section(letter: $0, names: groupedDictionary[$0]!.sorted()) }
       
       
       
       tableview.reloadData()
        tableview.delegate = self
        tableview.dataSource = self
        ButtonRadius.layer.cornerRadius = 12
        tableview.layer.cornerRadius = 12
        searchBarTextField.delegate = self
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.separatorInset = UIEdgeInsets.zero
                tableView.layoutMargins = UIEdgeInsets.zero
                cell.preservesSuperviewLayoutMargins = false
                cell.layoutMargins = UIEdgeInsets.zero
                cell.separatorInset = UIEdgeInsets.zero
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       

       return sections[section].names.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! KisilerTableViewCell
         let section = sections[indexPath.section]
         let kisiIsimleri = section.names[indexPath.row]
       cell._nameL.text = kisiIsimleri
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
       
       
      
      
        cell._phoneNumber.text = self.kisiNumaralari[indexPath.row]
        print(indexPath.row)
       if indexPath.row==10{
              cell._nameL.text = self.kisiIsimleri[indexPath.row]
       }
        if indexPath.row==1 {
            cell._ImageP.image = kisiResimleri[indexPath.row]
        }
        if indexPath.row<2 {
            
            cell._check.image = kisiIcon[indexPath.row]
        }
      
        var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
        
        backgroundConfig.backgroundColor = nil
        
        cell.backgroundConfiguration = backgroundConfig
        
     
  
       
      
        return cell
        
        
    }
       func numberOfSections(in tableView: UITableView) -> Int {
           return sections.count
       }

       func sectionIndexTitles(for tableView: UITableView) -> [String]? {
           return sections.map{$0.letter}
       }

       func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return sections[section].letter
       }

    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        searchBarTextField.resignFirstResponder()
        searchBarTextField.text = ""
        self.searchedArray.removeAll()
        for str in kisiIsimleri {
            searchedArray.append(str)
        }
        tableview.reloadData()
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if searchBarTextField.text?.count != 0 {
            self.searchedArray.removeAll()
            for str in kisiIsimleri {
                let range = str.lowercased().range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil {
                    self.searchedArray.append(str)
                }
                
            }
        }
        tableview.reloadData()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}








