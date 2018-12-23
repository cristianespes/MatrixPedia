//
//  CharactersTableViewController.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 22/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit
import Alamofire

class CharactersTableViewController: UITableViewController {
    
    var characters: [CharacterViewModel] = []
    var presenter: CharacterListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
        presenter?.viewDidLoad()
    }
    
    func tableViewSetup() {
        title = "Characters"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell") else {
                return UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "characterCell")
            }
            
            return cell
        }()
        
        let character = characters[indexPath.row]
        cell.textLabel?.text = character.name
        cell.detailTextLabel?.text = character.type
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        let characterSelected = characters[indexPath.row]
        
        presenter?.userDidSelectCharacter(withId: characterSelected.id)
    }
}

extension CharactersTableViewController: CharacterListPresenterOutput {
    func loadCharacters(_ characters: [CharacterViewModel]) {
        self.characters = characters
        tableView.reloadData()
    }
    
    func showError(message: String) {
        showErrorAlert(message: message)
    }
}
