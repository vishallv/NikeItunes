//
//  AlbumInfo.swift
//  NikeItunes
//
//  Created by Vishal Lakshminarayanappa on 4/1/20.
//  Copyright © 2020 Vishal Lakshminarayanappa. All rights reserved.
//

import Foundation


struct Feed  : Decodable{
    var feed : CompleteAlbum
}

struct CompleteAlbum : Decodable {
    var results : [Album]
}

struct Album : Decodable{
    var name : String
    var artistName : String
    var artworkUrl100 : String
    var url : String
    var copyright : String
    var releaseDate : String
    var genres : [GenresName]
    
    
}

struct GenresName : Decodable {
    var name : String
}
