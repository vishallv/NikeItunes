//
//  AlbumController.swift
//  NikeItunes
//
//  Created by Vishal Lakshminarayanappa on 4/1/20.
//  Copyright © 2020 Vishal Lakshminarayanappa. All rights reserved.
//

import UIKit


private let albumReuseIdentifier = "albumCellReuseIdentifier"

class AlbumController : UITableViewController {
    
    
    //MARK: Properties
    
    private var albumResults  : [Album] = [] {
        didSet{
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureTableView()
        configureNavigationBar()
        retreiveAlbumInfo()
        
    }
    
    //MARK: Selectors
    
    //MARK: Helper Functions
    
    func retreiveAlbumInfo(){
        
        let url : String = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
        
        Service.shared.getAlbumFromApi(apiURL: url) {[weak self] (result) in
            switch result{
                
            case .failure(_):
                
                DispatchQueue.main.async {
   
                let actionController = UIAlertController(title: "Error", message: "Issue with network. Please try again!", preferredStyle: .alert)
                
                actionController.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { [weak self](_) in
                        self?.retreiveAlbumInfo()

                }))
                    self?.present(actionController, animated: true, completion: nil)
                
                }
                
                
            case .success(let albums):
                self?.albumResults = albums
                
            }
            
            
        }
    }
    
    func configureTableView(){
        
        view.backgroundColor = .white
        tableView.rowHeight = 70
        tableView.register(AlbumCell.self, forCellReuseIdentifier: albumReuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    func configureNavigationBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Top Albums"
    }
    
    //MARK: UITableViewDataSource UITableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumResults.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: albumReuseIdentifier, for: indexPath) as! AlbumCell
        
        cell.album = albumResults[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let album = albumResults[indexPath.row]
        let controller = SingleAlbumController(singleAlubum: album)
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
}


//On launch, the user should see a UITableView showing one album per cell. Each cell should display the name of the
//album, the artist, and the album art (thumbnail image). Tapping on a cell should push another view controller onto
//the navigation stack where we see a larger image at the top of the screen and the same information that was
//shown on the cell, plus genre, release date, and copyright info below the image. A button should also be included
//on this second view that when tapped fast app switches to the album page in the iTunes store. The button should
//be centered horizontally and pinned 20 points from the bottom of the view and 20 points from the leading and
//trailing edges of the view. Unlike the first one, this “detail” view controller should NOT use a UITableView for
//layout.
