//
//  LaunchViewController.swift
//  DynamicFlowLayout
//
//  Created by Shankar on 18/01/20.
//  Copyright © 2020 Shankar. All rights reserved.
//

import UIKit
import CoreData

class LaunchViewController: UIViewController {
    var player: [NSManagedObject] = []
    lazy var endPoint: String = { return "https://api.myjson.com/bins/t533e" }()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var newPlayers:PlayersC? {
        didSet {
            // Remove all Previous Records
            DatabaseController.deleteAllPlayers()
            // Add the new spots to Core Data Context
            self.addNewPlayersToCoreData(self.newPlayers!)
            // Save them to Core Data
            DatabaseController.saveContext()
            self.redirectToDashboard()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchPlayerDetails()
    }
    
    func redirectToDashboard() {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let dashboardVC = DashboardViewController(nibName : "DashboardViewController", bundle : nil)
            let navigationController: UINavigationController = UINavigationController(rootViewController: dashboardVC)
            //navigationController.isNavigationBarHidden = true
            
            appDelegate.window?.rootViewController = navigationController
        }
    }
    
    func fetchPlayerDetails() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        guard let url = URL(string: endPoint) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                guard error == nil else { return }
                guard let data = data else { return }
                do {
                    self.newPlayers = try JSONDecoder().decode(PlayersC.self, from: data)
                } catch let error {
                    print(error)
                }
            }
            
        }.resume()
    }
    
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: title, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addNewPlayersToCoreData(_ players: PlayersC) {
        for player in players.player {
            let entity = NSEntityDescription.entity(forEntityName: "Players", in: DatabaseController.getContext())
            let newPlayer = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())
            // Set the data to the entity
            newPlayer.setValue(player.name, forKey: "name")
            newPlayer.setValue(player.descriptions, forKey: "descriptions")
            newPlayer.setValue(player.imageUrl, forKey: "imageUrl")
        }
    }
}
