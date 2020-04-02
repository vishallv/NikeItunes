//
//  CustomImageView.swift
//  NikeItunes
//
//  Created by Vishal Lakshminarayanappa on 4/1/20.
//  Copyright © 2020 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit


 private var imageCache = [String:UIImage]()
class CustomImageView : UIImageView{
    
    var latestImageURl: String?
    
    
    func loadImage(imageUrl url: String){

        
        latestImageURl = url
        
        guard let imageRequest = URL(string: url) else {return}
        
        
        
        if let image : UIImage = imageCache[imageRequest.absoluteString]{

                self.image = image

            return
        }
        
        
        
        URLSession.shared.dataTask(with: imageRequest) { (data, response, error) in
            
            guard let imageData = data , let image = UIImage(data: imageData) else {return}
            
            
            if self.latestImageURl == url{
                DispatchQueue.main.async {
                    self.image = image
                }
                
                imageCache[imageRequest.absoluteString] = image
            }
            
            
            
        }.resume()

        
    }
    
    
}
