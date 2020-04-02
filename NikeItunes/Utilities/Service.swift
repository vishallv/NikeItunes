//
//  Service.swift
//  NikeItunes
//
//  Created by Vishal Lakshminarayanappa on 4/1/20.
//  Copyright © 2020 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit


enum AlbumError : Error {
    
    case noData
    case cannotParseData
}

struct Service {
    
    static let shared = Service()
    
    
    func getAlbumFromApi(apiURL url : String,completion : @escaping(Result<[Album],AlbumError>) -> Void){
        
        guard let requestURl = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: requestURl) { (data, _, _) in
            
            guard let jsonData = data else {
                completion(.failure(.noData))
                return}
            
            do{
                let feed = try JSONDecoder().decode(Feed.self, from: jsonData)
                
                let albums = feed.feed.results
                
                completion(.success(albums))
                
            }
            catch{
                print(error.localizedDescription)
                
                completion(.failure(.cannotParseData))
                
            }
            
            
        }.resume()
        
    }
    
}



