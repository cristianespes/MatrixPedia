//
//  CharactersNetworkDataSource.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

typealias CharactersNetworkDataSourceCompletionHandler = (_ characters: [MatrixCharacter]?, _ error: NSError?) -> Void

// Input protocol
protocol CharactersNetworkDataSource {
    func retrieveCharacters(_ completion: @escaping CharactersNetworkDataSourceCompletionHandler)
}

class CharactersNetworkDataSourceImpl: CharactersNetworkDataSource {
    private var networkDataManager: NetworkDataManager
    
    init(networkDataManager: NetworkDataManager) {
        self.networkDataManager = networkDataManager
    }
    
    func retrieveCharacters(_ completion: @escaping CharactersNetworkDataSourceCompletionHandler) {
        let operation = CharacterListNetworkOperation()
        networkDataManager.execute(operation) { _ in
            completion(operation.characters, operation.error)
        }
    }
}
