//
//  WebcamTableViewCell.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 23/07/2022.
//

import UIKit
import SDWebImage

protocol WebcamProtocol {
    
    func buttonLive()
    
}

class WebcamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
    var delegate: WebcamProtocol?
    
    var url = String()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    @IBAction func buttonLIve() {
        
        delegate?.buttonLive()
        
        var webcamUrl : Webcam? {
            didSet{
                if let url = URL(string: webcamUrl?.player.day.embed ?? "") {
                    UIApplication.shared.open(url)
                }
            }
//            if let url = URL(string: url) {
//                UIApplication.shared.open(url)
//
//            }
        }
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
