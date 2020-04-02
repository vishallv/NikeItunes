//
//  AlbumCell.swift
//  NikeItunes
//
//  Created by Vishal Lakshminarayanappa on 4/1/20.
//  Copyright © 2020 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit

private let albumImageDimension : CGFloat = 50

class AlbumCell : UITableViewCell{
    
    
    //MARK: Properties
    
    var album : Album? {
        didSet{
            guard let album = album else {return}
            
            albumLabel.text = album.name
            artistLabel.text = album.artistName
            
            self.albumImageView.loadImage(imageUrl: album.artworkUrl100)
                        
        }
    }
    
    private var albumImageView : CustomImageView = {
        let iv = CustomImageView()
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = albumImageDimension/2
        return iv
        
    }()
    
    private var albumLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
        
    }()
    
    private var artistLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
        
    }()
    
    
    //MARK: Life Cycles
    

    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        configureView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Selectors
    
    //MARK: Helper Functions
    
    func configureView(){
        
        addSubview(albumImageView)
        albumImageView.centerY(inView: self)
        albumImageView.anchor(left : leftAnchor,paddingLeft: 10,
                              width: albumImageDimension,height: albumImageDimension)
        
        let stack = UIStackView(arrangedSubviews: [albumLabel,artistLabel])
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 5
        
        addSubview(stack)
        stack.centerY(inView: self)
        stack.anchor(left : albumImageView.rightAnchor, paddingLeft: 10,
                     width: self.frame.width - 20 - albumImageDimension,height: 50)
        
    }
    
    
}
