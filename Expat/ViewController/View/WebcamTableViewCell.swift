//
//  WebcamTableViewCell.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 23/07/2022.
//

import UIKit
import SDWebImage

class WebcamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
    
    var url = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    var webcam : Webcam? {
        didSet{
            
            // REVOIR DEBALLAGE
            
            guard let urlImage = URL(string: webcam?.image.current.preview ?? "") else { return }
            placeTitle.text = webcam?.title
            imagePlace.sd_setImage(with: urlImage)
          
        }
    }
    
        
    @IBAction func liveButton(_ sender: Any) {
       
        if let url = URL(string: "www.essentioil.fr") {
                    UIApplication.shared.open(url)
        
        
        }
    
}
    
}
