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
    
    var characters: [MatrixCharacter] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
        loadCharacters()
    }
    
    func tableViewSetup() {
        title = "Characters"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
    }
    
    func loadCharacters() {
        Alamofire.request("http://127.0.0.1/characters").responseJSON { [weak self] (response) in
            
            if let data = response.data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                let characters = jsonData as? [[String: Any]] {
                var newCharacters = [MatrixCharacter]()
                
                for character in characters {
                    guard let newCharacter = MatrixCharacter(json: character) else { continue }
                    
                    newCharacters.append(newCharacter)
                }
                
                self?.characters = newCharacters
                self?.tableView.reloadData()
            }
        }
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
        cell.textLabel?.text = character.alias
        cell.detailTextLabel?.text = character.type.rawValue.capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterSelected = characters[indexPath.row]
        let characterProfileVC = CharacterProfileViewController(withCharacterId: characterSelected.id)
        
        navigationController?.pushViewController(characterProfileVC, animated: true)
        
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }
}
