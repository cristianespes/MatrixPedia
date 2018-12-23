//
//  CharacterListRouter.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 23/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit

protocol CharacterListRouter {
    func openCharacter(withId id: Int)
}

class CharacterListRouterImpl {
    var mainRouter: MainRouter
    
    init(mainRouter: MainRouter) {
        self.mainRouter = mainRouter
    }
}

extension CharacterListRouterImpl {
    static func create(withNetworkDataManager networkDataManager: NetworkDataManager) -> UIViewController {
        let serviceLocator = UIApplication.serviceLocator
        let networkDataManager = serviceLocator.networkDataManager
        let interactor = CharacterListInteractorImpl()
        let networkDataSource = CharactersNetworkDataSourceImpl(networkDataManager: networkDataManager)
        let repository = CharactersRepositoryImpl(networkDataSource: networkDataSource)
        let presenter = CharacterListPresenterImpl()
        let view = CharactersTableViewController()
        let mainRouter = serviceLocator.mainRouter
        let router = CharacterListRouterImpl(mainRouter: mainRouter)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        interactor.repository = repository
        repository.output = interactor
        
        return view
    }
}

extension CharacterListRouterImpl: CharacterListRouter {
    func openCharacter(withId id: Int) {
        let profileController = CharacterProfileRouterImpl.create(characterId: id)
        mainRouter.present(controller: profileController)
    }
}
