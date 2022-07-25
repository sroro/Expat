//
//  WebcamTableViewCell.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 23/07/2022.
//

import UIKit
import SDWebImage

protocol WebcamTableViewCellDelegate: AnyObject {
    
    func liveButton()
    
}

class WebcamTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var button: UIButton!
    weak var delegate: WebcamTableViewCellDelegate?
    
    var url = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    var webcamInformations : Webcam? {
        didSet{
            
            // REVOIR DEBALLAGE
            
            guard let urlImage = URL(string: webcamInformations?.image.current.preview ?? "") else { return }
            placeTitle.text = webcamInformations?.title
            imagePlace.sd_setImage(with: urlImage)
          
        }
    }
    
        
    @IBAction func liveButton() {
        
        delegate?.liveButton()
       
        if let url = URL(string: "www.essentioil.fr") {
                    UIApplication.shared.open(url)
        
        
        }
    
}
    
}
