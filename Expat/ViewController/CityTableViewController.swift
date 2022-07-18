//
//  CityTableViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 29/05/2022.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    //    MARK: - Properties
    
    var listCountry = ListOfCountry()
    var arrayCountry = [String]()
    var nameCountry = String()
    
    // MARK: - ViewLife cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveCountry()
        tableView.reloadData()
      
    }
    
    
    // MARK: - Methods
    
    func receiveCountry() {
        listCountry.getList { resultat in
            switch resultat {
            case.failure(_):
                print("error")
            case.success(let resultat):
                DispatchQueue.main.async { [weak self] in
                    
                    // boucle pour utiliser les infos et les mettres dans un array
                    for data in resultat.data {
                        
                        self?.arrayCountry.append(data.collection)
                    
                    }
                    self?.tableView.reloadData()
                }
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayCountry.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        let title = arrayCountry[indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  met dans une variable le pays de la cell selectionné
        nameCountry = arrayCountry[indexPath.row]
        performSegue(withIdentifier: "segueToCountry", sender: nil)
        
    }
    
    //MARK: - Prepare
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // envoi le nom selectionné à l'ecran suivant
        if segue.identifier == "segueToCountry" {
            let vcDestination = segue.destination as? CityViewController
            vcDestination?.city = nameCountry
        }
    }
    
}
