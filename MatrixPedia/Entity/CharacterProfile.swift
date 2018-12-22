//
//  CharacterProfile.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 22/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

class CharacterProfile {
    let id: Int
    let characterId: Int
    let alias: String
    let name: String
    let description: String
    let coverURL: String
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
        let characterId = json["characterId"] as? Int,
        let alias = json["alias"] as? String,
        let name = json["name"] as? String,
        let description = json["description"] as? String,
        let coverURL = json["coverURL"] as? String else { return nil }
        
        self.id = id
        self.characterId = characterId
        self.alias = alias
        self.name = name
        self.description = description
        self.coverURL = coverURL
    }
}
