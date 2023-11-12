//
//  Model.swift
//  insultApp
//
//  Created by Roman on 12.11.23.
//

import Foundation

struct Insult: Decodable {
    let number: String
    let language: String
    let insult: String
    let created: String
    let shown: String
    let createdby: String
    let active: String
    let comment: String
}
