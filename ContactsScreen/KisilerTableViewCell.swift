//
//  KisilerTableViewCell.swift
//  ContactsScreen
//
//  Created by serhat yaroglu on 9.10.2020.
//

import UIKit

class KisilerTableViewCell: UITableViewCell {

 
    @IBOutlet weak var _check: UIImageView!
    
    @IBOutlet weak var _phoneNumber: UILabel!
    
    @IBOutlet weak var _nameL: UILabel!

   
    @IBOutlet weak var _ImageP: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _ImageP.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
