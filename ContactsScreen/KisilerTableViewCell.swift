//
//  KisilerTableViewCell.swift
//  ContactsScreen
//
//  Created by serhat yaroglu on 9.10.2020.
//

import UIKit

class KisilerTableViewCell: UITableViewCell {
   
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var _check: UIImageView!
    
    @IBOutlet weak var _phoneNumber: UILabel!
    
    @IBOutlet weak var imagePhoto: UIImageView!
    
    
    @IBOutlet weak var _nameL: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imagePhoto.layer.cornerRadius = 10
        imageLabel.layer.cornerRadius = 10
        
        
    }
   
    
 
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
