//
//  HeroStats.swift
//  Dota2Heroes
//
//  Created by Golduck Brittany on 12/7/21.
//  Copyright © 2021 Ilnur Mustafin. All rights reserved.
//

import UIKit

struct HeroStats: Decodable, Hashable {
    let localizedName: String
    let primaryAttr: String
    let attackType: String
    let legs: Int
    let img: String
    
    enum CodingKeys: String, CodingKey {
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case legs
        case img
    }
    
    var primaryAttribute: PrimaryAttribute {
        return PrimaryAttribute(rawValue: primaryAttr) ?? .unknown
    }
}

