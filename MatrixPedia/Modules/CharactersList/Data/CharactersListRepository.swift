//
//  CharactersListRepository.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

// Input protocol
protocol CharactersRepository {
    func retrieveCharacters()
}

// Output protocol
protocol CharactersRepositoryOutput: class {
    func onCharactersSuccess(_ characters: [MatrixCharacter])
    func onCharactersError(_ error: NSError?)
}

class CharactersRepositoryImpl: CharactersRepository {
    var networkDataSource: CharactersNetworkDataSource
    weak var output: CharactersRepositoryOutput?
    
    init(networkDataSource: CharactersNetworkDataSource) {
        self.networkDataSource = networkDataSource
    }
    
    func retrieveCharacters() {
        networkDataSource.retrieveCharacters { [weak self] (characters, error) in
            guard error == nil, let characters = characters else {
                self?.output?.onCharactersError(error)
                return
            }
            
            self?.output?.onCharactersSuccess(characters)
        }
    }
}
