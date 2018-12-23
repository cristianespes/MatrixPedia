//
//  CharacterListInteractor.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

// Input protocol
protocol CharacterListInteractor {
    func loadCharacters()
}

// Output protocol
protocol CharacterListInteractorOutput: class {
    func loadedCharacters(_ characters: [MatrixCharacter])
    func failedLoadingCharacters()
}

class CharacterListInteractorImpl {
    weak var output: CharacterListInteractorOutput?
    var repository: CharactersRepository?
}

extension CharacterListInteractorImpl: CharacterListInteractor {
    func loadCharacters() {
        repository?.retrieveCharacters()
    }
}

extension CharacterListInteractorImpl: CharactersRepositoryOutput {
    func onCharactersSuccess(_ characters: [MatrixCharacter]) {
        output?.loadedCharacters(characters)
    }
    
    func onCharactersError(_ error: NSError?) {
        output?.failedLoadingCharacters()
    }
}
