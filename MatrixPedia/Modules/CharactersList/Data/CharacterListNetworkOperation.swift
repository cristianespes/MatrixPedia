//
//  CharacterListNetworkOperation.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

class CharacterListNetworkOperation: MatrixNetworkOperation {
    var characters: [MatrixCharacter]? = nil
    var error: NSError? = nil
    var endPoint: String {
        return "/characters"
    }
    
    func finish(with data: Data?) {
        let decoder = JSONDecoder()
        guard let charactersData = data, let newCharacters = try? decoder.decode([MatrixCharacter].self, from: charactersData), newCharacters.count > 0 else {
            error = getError()
            return
        }
        
        self.characters = newCharacters
    }
}

extension CharacterListNetworkOperation {
    func getError() -> NSError {
        return NSError(domain: "CharacterListNetworkOperation", code: 1, userInfo: [NSLocalizedDescriptionKey : "Error parsing characters"])
    }
}
