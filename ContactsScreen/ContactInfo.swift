//
//  ContactInfo.swift
//  ContactsScreen
//
//  Created by serhat yaroglu on 6.11.2020.
//

import Foundation
import Alamofire

struct ApiResult : Decodable {
    let metas:Meta
    let response:Response
}

struct Response :Decodable
{
    let contacts:[Contact]
}

struct Contact:Decodable {
    let id:String 
    var firstName:String
    let number:String
    let photo:String 
    let lastName:String
    
    init(id:String,firstName:String,number:String,photo:String,lastName:String) {
        self.id = id
        self.firstName = firstName
        self.number = number
        self.photo = photo

        self.lastName = lastName

    }
    
}

struct Meta : Decodable {
    let code:Int
}

public func getStringText() -> String{
    return "\(Contact.self)"
  }
