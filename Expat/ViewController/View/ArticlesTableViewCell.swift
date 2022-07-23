//
//  ArticlesTableViewCell.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 13/07/2022.
//

import UIKit
import SDWebImage

class ArticlesTableViewCell: UITableViewCell {
    
  

    @IBOutlet weak var titleArticle: UILabel!
    @IBOutlet weak var dateArticle: UILabel!
    @IBOutlet weak var textArticle: UITextView!
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var linkArticle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var article : ArticleElement? {
        
        didSet{
            
            // REVOIR DEBALLAGE
            
            guard let url = URL(string: article?.media ?? "https://img.freepik.com/free-vector/news-background-breaking-news-vector-infographic-with-news-theme-map-world-vector-illustration_433751-25.jpg?t=st=1658170277~exp=1658170877~hmac=ed63d5e1749fc6f6fd2ef04275256325a31c2729d4cab787945881853ac427d9&w=1800") else { return }
            
            imageArticle.sd_setImage(with: url)
            titleArticle.text = article?.title
            linkArticle.text = article?.rights
            dateArticle.text = article?.publishedDate
            textArticle.text = article?.summary
            
        }
    }
    
}
