//
//  SingleAlbumController.swift
//  NikeItunes
//
//  Created by Vishal Lakshminarayanappa on 4/1/20.
//  Copyright © 2020 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit

class SingleAlbumController : UIViewController{
    
    
    
    
    //MARK: Properties
    
    var singleAlbum : Album
    
    private lazy var albumLabel : UILabel = {
        return UILabel().generateLabel(labelText: singleAlbum.name , fontSize: 20, weight: .bold)
    }()
    
    private lazy var artistLabel : UILabel = {
        return UILabel().generateLabel(labelText: singleAlbum.artistName , fontSize: 15, weight: .regular)
    }()
    
    private lazy var copyRightLabel : UILabel = {
        return UILabel().generateLabel(labelText: singleAlbum.copyright , fontSize: 15, weight: .regular)
    }()
    
    private lazy var releaseDateLabel : UILabel = {
           return UILabel().generateLabel(labelText: singleAlbum.releaseDate , fontSize: 15, weight: .regular)
       }()
    
    private lazy var genreLabel : UILabel = {
        var message = ""
        
        for (i,genre) in singleAlbum.genres.enumerated(){
            
            if i == singleAlbum.genres.count - 1{
                message += "\(genre.name)"
            }
            else{
                message += "\(genre.name)/"
            }
        }
        
        return UILabel().generateLabel(labelText: message , fontSize: 15, weight: .regular)
    }()
    
    private lazy var albumImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.loadImage(imageUrl: singleAlbum.artworkUrl100)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
        
    }()
    
    
    
    private let itunesButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("Go to itunes store", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        button.addTarget(self, action: #selector(handleItunesButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    //MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
    }
    
    
    init(singleAlubum album : Album) {
        self.singleAlbum = album
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Selectors
    @objc func handleItunesButtonPressed(){
        
        let ituneStoreLink = singleAlbum.url        
        guard let itunesUrl = URL(string: ituneStoreLink), UIApplication.shared.canOpenURL(itunesUrl) else {
            print("errorr")
            return}

        UIApplication.shared.open(itunesUrl, options: [:]) { (success) in
            if success{
                print(success)
            }
        }
    }
    
    //MARK: Helper Functions
    
    func configureUI(){
        view.addSubview(albumImageView)
        albumImageView.centerX(inView: view)
        albumImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor,left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 20,paddingLeft: 20,paddingRight: 20,
                              height: 350)
        
        view.addSubview(copyRightLabel)
        copyRightLabel.centerX(inView: view)
        copyRightLabel.anchor(top:albumImageView.bottomAnchor,left: view.leftAnchor,
                              right: view.rightAnchor, paddingTop: 5,paddingLeft: 20,paddingRight: 20)
        
        view.addSubview(itunesButton)
               itunesButton.centerX(inView: view)
               itunesButton.anchor(left : view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,
                                   paddingLeft: 20,paddingBottom: 20,paddingRight: 20,
                                   height: 60)
        
        let stack = UIStackView(arrangedSubviews: [albumLabel,artistLabel,releaseDateLabel,genreLabel])
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        
        view.addSubview(stack)
        stack.centerX(inView: view)
        stack.anchor(top:copyRightLabel.bottomAnchor,left: view.leftAnchor,bottom: itunesButton.topAnchor,
                     right: view.rightAnchor, paddingTop: 10,paddingLeft: 20,paddingBottom: 80,paddingRight: 20)
        
        
       
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = singleAlbum.name
        navigationController?.navigationBar.tintColor = .black
        
    }
}
