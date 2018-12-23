//
//  CharacterListPresenter.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import Foundation

// Input protocol
protocol CharacterListPresenter {
    func viewDidLoad()
    func userDidSelectCharacter(withId id: Int)
}

// Output protocol (protocol for view)
protocol CharacterListPresenterOutput: class {
    func loadCharacters(_ characters: [CharacterViewModel])
    func showError(message: String)
}

class CharacterListPresenterImpl {
    var interactor: CharacterListInteractor?
    weak var view: CharacterListPresenterOutput?
    var router: CharacterListRouter?
}

extension CharacterListPresenterImpl: CharacterListPresenter {
    func viewDidLoad() {
        interactor?.loadCharacters()
    }
    
    func userDidSelectCharacter(withId id: Int) {
        router?.openCharacter(withId: id)
    }
}

extension CharacterListPresenterImpl: CharacterListInteractorOutput {
    func loadedCharacters(_ characters: [MatrixCharacter]) {
        let charactersViewModel = characters.map { CharacterViewModel(id: $0.id, name: $0.alias, type: $0.type.rawValue)}
        
        view?.loadCharacters(charactersViewModel)
    }
    
    func failedLoadingCharacters() {
        view?.showError(message: "Characters couldn't be loaded")
    }
}
