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
    let name:String
    let number:String
    let photo:String
    
}

struct Meta : Decodable {
    let code:Int
}

