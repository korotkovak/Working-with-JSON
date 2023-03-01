//
//  File.swift
//  Working with JSON
//
//  Created by Kristina Korotkova on 01/03/23.
//

import Foundation

struct Cards: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let name: String
    let manaCost: String?
    let cmc: Double
    let type: String
    let set: String
    let setName: String
    let subtypes: [String]?
}
