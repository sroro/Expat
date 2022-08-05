//
//  AccueilViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 04/08/2022.
//

import Foundation
import UIKit

class AccueilViewController: UIViewController {
    

    @IBOutlet weak var ListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListButton.layer.shadowRadius = 10
        ListButton.layer.shadowColor = UIColor.black.cgColor
        ListButton.layer.cornerRadius = 10
        ListButton.layer.shadowOpacity = 0.5
    }
    
    
}
