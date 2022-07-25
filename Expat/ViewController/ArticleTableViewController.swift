//
//  ArticleTableViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 12/07/2022.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    var article = ArticleService()
    var arrayTitle = [String]()
    var arrayElement = [ArticleElement]()
    var keyword = UserDefaults.standard.value(forKey: "nameCountry")
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        receiveArticle()
        tableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        tableView.reloadData()
  
    }
    
    // MARK: - Methods
    
    
    func receiveArticle() {
        
        article.getArticle(keyword: "france" as! String) { [weak self] resultat in
            switch resultat {
            case.failure(_):
                print("error")
                
            case.success(let article):
                DispatchQueue.main.async {
                    for data in article.articles {
                        //  add title of data in an array for numberOfRowInSections
                        // add all date in arrayElement for use in tableView
                        self?.arrayTitle.append(data.title)
                        self?.arrayElement.append(data)
                    }
                    self?.tableView.reloadData()
                }
            }
        }        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayTitle.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticlesTableViewCell else { return UITableViewCell() }
        let arrayElements = arrayElement[indexPath.row]
        cell.article = arrayElements
        return cell
    }
    
    // height of cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
    
}
