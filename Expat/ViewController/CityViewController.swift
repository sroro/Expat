//
//  CityViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 26/05/2022.
//

import UIKit

class CityViewController: UIViewController {
    
//    MARK: - Outlets
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var imageCity: UIImageView!
    
    @IBOutlet weak var nameCurrency: UILabel!
    @IBOutlet weak var exchangeCurrency: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    
    
    @IBOutlet weak var priceStudio: UIStackView!
    @IBOutlet weak var priceRepas: UILabel!
    @IBOutlet weak var priceCoffee: UILabel!
    
    @IBOutlet weak var priceTransport: UILabel!
    @IBOutlet weak var priceCinema: UILabel!
    @IBOutlet weak var princeEssence: UILabel!
    
    @IBOutlet weak var titleBank: UILabel!
    @IBOutlet weak var textBank: UITextView!
    @IBOutlet weak var titleCityTxt: UILabel!
    @IBOutlet weak var textTopCity: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textBank.text = test.textBanque
        textTopCity.text = test.textCity
        titleCityTxt.text = test.titletextCity
        // Do any additional setup after loading the view.
    }
    
    
    var test = Espagne()

    

}
