//
//  WebcamTableViewCell.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 23/07/2022.
//

import UIKit
import SDWebImage

protocol WebcamProtocol {
    
    func buttonLive(with url: String)
    
}

class WebcamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
    var delegate: WebcamProtocol?
    var url : String = "https://webcams.windy.com/webcams/public/embed/player/1511477795/day"
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    @IBAction func buttonLIve() {
        
        delegate?.buttonLive(with: url)
        
    }
    
    var webcamInformations : Webcam? {
        didSet{
            
            // REVOIR DEBALLAGE
            
            guard let urlImage = URL(string: webcamInformations?.image.current.preview ?? "") else { return }
            placeTitle.text = webcamInformations?.title
            imagePlace.sd_setImage(with: urlImage)
            
        }
    }
    
    
    
    
}
