//
//  PrimaryAttribute.swift
//  Dota2Heroes
//
//  Created by Golduck Brittany on 12/7/21.
//  Copyright © 2021 Ilnur Mustafin. All rights reserved.
//

import Foundation

enum PrimaryAttribute: String {
    case agility = "agi"
    case strenght = "str"
    case intellect = "int"
    case unknown
    
    var name: String {
        get { return String(describing: self) }
    }
}
