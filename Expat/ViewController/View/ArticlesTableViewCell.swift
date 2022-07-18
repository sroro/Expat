//
//  ArticlesTableViewCell.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 13/07/2022.
//

import UIKit


class ArticlesTableViewCell: UITableViewCell {
    
  

    @IBOutlet weak var titleArticle: UILabel!
    @IBOutlet weak var dateArticle: UILabel!
    @IBOutlet weak var textArticle: UITextView!
    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var urlButton: UIButton!
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
            guard let url = URL(string: article?.media ?? "") else { return }
            
            imageArticle.image = UIImage(data: u)
            titleArticle.text = article?.title
            linkArticle.text = article?.link
            dateArticle.text = article?.publishedDate
            textArticle.text = article?.summary
            
        }
    }
    
}
