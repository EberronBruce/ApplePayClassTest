//
//  ViewController.swift
//  StickerCove
//
//  Created by Bruce Burgess on 12/24/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var pictures : [Picture] = Picture.createPictures()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell") as! PictureTableViewCell? {
            
            let picture = self.pictures[indexPath.row]
            
            cell.nameLabel.text = picture.name
            cell.priceLabel.text = "$\(picture.price)"
            cell.pictureView.image = picture.image
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let picture = self.pictures[indexPath.row]
        self.performSegue(withIdentifier: "detailSegue", sender: picture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? PictureDetailViewController {
            if sender != nil {
                if let pic = sender as? Picture {
                    detailVC.picture = pic
                }
            }
        }
    }


}

