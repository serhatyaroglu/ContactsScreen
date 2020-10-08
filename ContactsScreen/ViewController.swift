//
//  ViewController.swift
//  ContactsScreen
//
//  Created by serhat yaroglu on 6.10.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ButtonRadius: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ButtonRadius.layer.cornerRadius = 12
    }


}

