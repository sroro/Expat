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
    var array = [ArticleElement]()
    
    var test = ["rodolphe","sabrina","yaseen","saîda"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveArticle()
                tableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        tableView.reloadData()
    }
    
    
    // MARK: - Methods
    
    
    func receiveArticle() {
        
        article.getArticle { [weak self] resultat in
            switch resultat {
            case.failure(_):
                print("error")
                
            case.success(let article):
                DispatchQueue.main.async {
                    for data in article.articles {
                        self?.arrayTitle.append(data.title)
                        self?.array.append(data)
                   
                    }
                    self?.tableView.reloadData()
                }
                
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return arrayTitle.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayTitle.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticlesTableViewCell else { return UITableViewCell() }
        let arrayElements = array[indexPath.row]
        cell.article = arrayElements
        return cell
    }
    
    // height of cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
    
}
