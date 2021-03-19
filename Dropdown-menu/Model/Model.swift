//
//  Model.swift
//  Dropdown-menu
//
//  Created by Dhruvil Patel on 3/19/21.
//  Copyright © 2021 Dhruvil Patel. All rights reserved.
//

import Foundation

struct Result:Codable {
    var sales = [ResultItem]()
}
struct ResultItem:Codable {
    let prod : String
    let country:String
    let price:Int
}
