//
//  CityTableViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 29/05/2022.
//

import UIKit

class CityTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.reloadData()
        
    }
    
    
    var test: [String] = [ "🇧🇬 Bulgarie", "🇨🇷 Costa Rica","🇸🇩 Dubaï", "🇪🇸 Espagne" ]
    var pays : [City.Type] = [Bulgarie.self,CostaRica.self,Espagne.self,Malte.self,Panama.self,Portugal.self]
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        let title = pays[indexPath.row]
        cell.textLabel?.text = "hello"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
   

}
