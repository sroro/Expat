//
//  CityTableViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 29/05/2022.
//

import UIKit

class CityTableViewController: UITableViewController,UISearchBarDelegate {
    
    
    //    MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    var listCountry = ListCountryService()
    var arrayCountry = [String]()
    var arrayContinent = [String]()
    var nameCountrySelected = String()
    var filteredCountry = [String]() //tableau des elements pour filter search bar
    
    var userDefaults = UserDefaults.standard
    
    // MARK: - ViewLife cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        receiveCountry()
        filteredCountry = arrayCountry
        tableView.reloadData()
        
    }
    
    
    // MARK: - Methods
    
    func receiveCountry() {
        listCountry.getList { resultat in
            switch resultat {
            case.failure(_):
                self.alertNoData()
            case.success(let resultat):
                DispatchQueue.main.async { [weak self] in
                    
            
                    // boucle pour utiliser les infos et les mettres dans un array
                    for data in resultat.data {
                        self?.arrayCountry.append(data.collection)
                        self?.arrayContinent.append(data.meta.note ?? "")
                    }
                    
                    self?.filteredCountry = self?.arrayCountry ?? [""] // rempli filtered country pour afficher la liste au lancement
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
        
        return filteredCountry.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        let country = filteredCountry[indexPath.row]
        let continent = arrayContinent[indexPath.row]
        cell.detailTextLabel?.text = continent
        cell.textLabel?.text = country
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  met dans une variable le pays de la cell selectionné
        nameCountrySelected = filteredCountry[indexPath.row]
        userDefaults.set(nameCountrySelected, forKey: "nameCountrySelected")
        performSegue(withIdentifier: "segueToCountry", sender: nil)
//        print(codeCountry[indexPath.row])
    }
    
    
    //MARK: - Prepare
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // envoi le nom selectionné à l'ecran suivant pour l'utiliser dans l'API
        if segue.identifier == "segueToCountry" {
            let vcDestination = segue.destination as? CityViewController
            vcDestination?.city = nameCountrySelected
        }
    }
    
    
    
    //     MARK: - SearchBar
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isFiltered: Bool {
        return searchController.isActive
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountry = []
        
        if searchText == "" {
            filteredCountry = arrayCountry
        } else {
            for countries in arrayCountry {
                if countries.lowercased().contains(searchText.lowercased()){
                    filteredCountry.append(countries)
                }
            }
        }
        self.tableView.reloadData()
    }
    
}

