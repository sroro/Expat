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
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
    var delegate: WebcamProtocol?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    
    
    @IBAction func buttonLive(_ sender: Any) {
        delegate?.buttonLive(with: webcamInformations?.player.day.embed ?? "https://webcams.windy.com/webcams/public/embed/player/1511477795/day")
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
