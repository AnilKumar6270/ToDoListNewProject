//
//  item.swift
//  ToDoListNewProject
//
//  Created by Anil on 12/08/19.
//  Copyright © 2019 ModeFin Server. All rights reserved.
//

import Foundation
//Encodable ,Decodable
class itemDataModel : Codable {
    var itemTitle : String = ""
    var done : Bool = false
}
