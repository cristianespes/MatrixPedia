//
//  CharacterProfileViewController.swift
//  MatrixPedia
//
//  Created by CRISTIAN ESPES on 22/12/2018.
//  Copyright © 2018 Cristian Espes. All rights reserved.
//

import UIKit
import Alamofire

class CharacterProfileViewController: UIViewController {
    let characterId: Int
    
    fileprivate lazy var scrollView: UIScrollView = { [unowned self] in
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    fileprivate lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        return stackView
    }()
    
    init(withCharacterId: Int) {
        self.characterId = withCharacterId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        loadProfile()
    }
    
    func setupView() {
        title = "Profile"
        
        setupScrollView()
        setupStackView()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setupStackView() {
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func loadProfile() {
        Alamofire.request("http://127.0.0.1/characters/\(characterId)/info").responseJSON { [weak self] (response) in
            if let data = response.data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments),
                let charactersInfo = jsonData as? [[String: Any]],
                let characterInfo = charactersInfo.first,
                let info = CharacterProfile(json: characterInfo) {
                self?.configureViewWith(info: info)
            } else {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func configureViewWith(info: CharacterProfile) {
        addCoverView(info.coverURL)
        addSectionView(with: "Alias", content: info.alias)
        addSectionView(with: "Name", content: info.name)
        addSectionView(with: "Description", content: info.description)
    }
    
    func addCoverView(_ urlString: String) {
        Alamofire.request(urlString).response { [weak self] dataResponse in
            
            guard dataResponse.error == nil, let data = dataResponse.data else { return }
            
            let view = UIView()
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            
            self?.stackView.insertArrangedSubview(view, at: 0)
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
            
            imageView.image = UIImage(data: data)
            
            UIView.animate(withDuration: 0.3, animations: {
                self?.stackView.layoutIfNeeded()
            })
        }
    }
    
    func addSectionView(with title: String, content: String) {
        addTitleSection(title)
        addContentSection(content)
    }
    
    func addTitleSection(_ title: String) {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 1
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .lightGray
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Helvetica", size: 23)
        stackView.addArrangedSubview(titleLabel)
    }
    
    func addContentSection(_ content: String) {
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.text = content
        contentLabel.font = UIFont(name: "Helvetica", size: 18)
        stackView.addArrangedSubview(contentLabel)
    }

}
