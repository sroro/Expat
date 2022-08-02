//
//  CityViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 26/05/2022.
//

import UIKit
import SDWebImage

class CityViewController: UIViewController {
    
    //    MARK: - Outlets
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var imageCity: UIImageView!
    
    @IBOutlet weak var nameCurrency: UILabel!
    @IBOutlet weak var exchangeCurrency: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imageWeather: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    
    @IBOutlet weak var priceStudio: UILabel!
    @IBOutlet weak var priceRepas: UILabel!
    @IBOutlet weak var priceCoffee: UILabel!
    
    @IBOutlet weak var priceTransport: UILabel!
    @IBOutlet weak var priceCinema: UILabel!
    @IBOutlet weak var princeEssence: UILabel!
    
    @IBOutlet weak var titleBank: UILabel!
    @IBOutlet weak var textBank: UITextView!
    @IBOutlet weak var titleCityTxt: UILabel!
    @IBOutlet weak var textTopCity: UITextView!
    
    
    // MARK: - Properties
    
    var monnaie = String()
    var infosCountry = CityService()
    var change = ExchangeService()
    var weather = WeatherService()
    var city = String()
    var codeCountry = String()
    
    var userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveInfosCountry()
        getWeather()
        
    }
    
    
    // MARK: - Methods
    
    
    func receiveInfosCountry() {
        
        infosCountry.getCity(city: city) { [weak self] result in
            switch result {
            case.failure(_):
                print("error")
                
            case.success(let resultOk):
                DispatchQueue.main.async { [self] in
                    
                    guard let urlImage = URL(string: resultOk.data[0].image) else { return }
                    
                    self?.cityTitle.text = resultOk.data[0].title
                    self?.nameCurrency.text = resultOk.data[0].currency
                    self?.priceStudio.text = resultOk.data[0].studio
                    self?.priceRepas.text = resultOk.data[0].repas
                    self?.priceCoffee.text = resultOk.data[0].cafe
                    self?.priceTransport.text = resultOk.data[0].transport
                    self?.priceCinema.text = resultOk.data[0].cinema
                    self?.princeEssence.text = resultOk.data[0].essence
                    self?.textBank.text = resultOk.data[0].textBank
                    self?.textTopCity.text = resultOk.data[0].textCity
                    self?.imageCity.sd_setImage(with: urlImage)
                    
                    self?.codeCountry = resultOk.data[0].code ?? "FR"
                    self?.userDefaults.set(self?.codeCountry, forKey: "codeCountry")
                }
               
                self!.monnaie = resultOk.data[0].devise
                
                // appel currency apres receiveInfo pour recevoir la devise
//                self?.currency()  EN PAUSE CAR PLUS DE CREDIT SUR l'API
            }
            
        }
    }
    
    
    
    func currency() {
        change.getExchange(devise: monnaie ) { [weak self] resultat in
            switch resultat {
                
            case.failure(_):
                print("error")
            case.success(let result):
                DispatchQueue.main.async {
                    self?.exchangeCurrency.text = ("1€ = \(result)")
                    
                }
                
            }
        }
    }
    
    
    
    func getWeather() {
        
        weather.getWeather(place: city ) { [weak self] resultat in
            switch resultat {
            case.failure(_):
                print("error")
                
            case.success(let resultOk):
                DispatchQueue.main.async{
                    self?.temperature.text = "\(resultOk.main.temp) °C "
                    self?.date.text = resultOk.weather[0].weatherDescription
                }
            }
            
        }
    }
    
    
    
    
}
