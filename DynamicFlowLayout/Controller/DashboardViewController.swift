//
//  DashboardViewController.swift
//  DynamicFlowLayout
//
//  Created by Shankar on 18/01/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit
import CoreData

class DashboardViewController: UIViewController {

    //Properties
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableviewDynamic: UITableView!
    
    lazy var players:[Players]? = {
        return DatabaseController.getAllPlayers()
    }()
    var playerImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        tableviewDynamic.register(UINib(nibName: "CellDynamic", bundle: nil), forCellReuseIdentifier: "CellDynamicID")
        tableviewDynamic.reloadData()
        loadAllImages()
    }

    func loadAllImages() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            if self.players?.count ?? 0 > 0 {
                for player in self.players! {
                    self.loadImage(url: player.imageUrl ?? "") { (thumbnail) in
                        self.playerImages.append(thumbnail)
                    }
                }
            }
            self.activityIndicator.stopAnimating()
        }
    }
    
    func loadImage(url: String, completionHandler completion:((_ image:UIImage) -> Void)?){
        if let URL = URL(string: url) {
            let request = URLRequest(url: URL)
           let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    if let imageData = data {
                        if let myImage:UIImage = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                // notify the completion handler if user wish to handle the downloaded image. Otherwise just load the image with alpha animation
                                completion!(myImage)
                            }
                        }
                    }
                }
            })
            task.resume()
        }
    }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DatabaseController.getAllPlayers().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellDynamicID", for: indexPath as IndexPath) as! CellDynamic
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        if players?.count ?? 0 > 0 {
            if let name = players?[indexPath.row].name {
                cell.labelProfileName.text = name
            }
            if let description = players?[indexPath.row].descriptions {
                cell.labelProfileDesc.text = description
            }
            cell.imageViewProfile.image = nil
            if let imageUrl = players?[indexPath.row].imageUrl {
                cell.imageViewProfile.loadImage(withURL: imageUrl, placeholderFor: "") { (thumbnailImage) in
                    cell.imageViewProfile.image = thumbnailImage
                }
            }
            cell.viewBox.layer.cornerRadius = 8
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionVC = CollectionViewController(nibName : "CollectionViewController", bundle : nil)
        collectionVC.playerImages = playerImages
        self.navigationController?.pushViewController(collectionVC, animated: true)
    }
}
