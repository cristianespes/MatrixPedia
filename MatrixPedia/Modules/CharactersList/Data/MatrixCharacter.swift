//
//  MatrixCharacter.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 22/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

enum MatrixCharacterType: String, Codable {
    case resistance, programs, exiles, potentials, truce
}

struct MatrixCharacter: Codable {
    let id: Int
    let alias: String
    let type: MatrixCharacterType
}
