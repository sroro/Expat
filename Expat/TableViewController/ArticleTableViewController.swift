//
//  ArticleTableViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 12/07/2022.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    var article = ArticleService()
    var arrayTitleNews = [String]()
    var arrayElementNews = [ArticleElement]()
    var nameCountrys = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "articleCell")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        //receive nameCountry when taped row in city tableView
        guard let nameCountry = UserDefaults.standard.string(forKey: "nameCountrySelected") else { return }
        nameCountrys = nameCountry
        receiveArticle()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        arrayTitleNews.removeAll()
        arrayElementNews.removeAll()
    }
    
    
    
    // MARK: - Methods
    
    
    func receiveArticle() {
        
        article.getArticle(keyword: nameCountrys) { [weak self] resultat in
            switch resultat {
            case.failure(_):
                self?.alertNoData()
                
            case.success(let article):
                DispatchQueue.main.async {
                    for data in article.articles {
                        //  add title of data in an array for numberOfRowInSections
                        // add all date in arrayElement for use in tableView
                        self?.arrayTitleNews.append(data.title)
                        self?.arrayElementNews.append(data)
                    }
                    self?.tableView.reloadData()
                }
            }
        }        
    }
  
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayTitleNews.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticlesTableViewCell else { return UITableViewCell() }
        let arrayElements = arrayElementNews[indexPath.row]
        cell.article = arrayElements
        return cell
    }
    
    // height of cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
    
}
