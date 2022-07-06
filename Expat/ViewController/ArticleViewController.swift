//
//  ArticleViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 04/07/2022.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var text: UITextView!
    
    var article = ArticleService()
    var heyy = testss()
    override func viewDidLoad() {
        super.viewDidLoad()

        receiveArticle()
        // Do any additional setup after loading the view.
    }
    
    
    func receiveArticle() {
        
//        article.getArticle { [weak self]  resultat in
//            switch resultat {
//            case.failure(_):
//                print("error")
//
//            case.success(let articles):
//
//
//                    let dateArticle = articles.articles[0].publishedAt
//                    let dateformatter = DateFormatter()
//
//                    self?.date.text = dateformatter.string(from: dateArticle)
//                self?.titre.text = articles.articles[0].title
//
//            }
//        }
        
        heyy.appels { [weak self] hello in
            switch hello {
            case.failure(_):
                print("error")
            case.success(let ok):
               
               print( ok.articles[0].title )
            }
        }
        
        
    }
    


}
