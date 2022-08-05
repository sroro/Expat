//
//  Alert+extension.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 05/08/2022.
//

import Foundation
import UIKit

extension UITableViewController {
    
    func alertNoData(){
        let alert = UIAlertController(title: "No Data", message: "Sorry no data here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    

}

extension UIViewController {
    func alertNoCountry(){
        let alert = UIAlertController(title: "No Data", message: "Oups...an Error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Later", style: .default))
        present(alert, animated: true)
    }
    
    func alertNoCurrency(){
        let alert = UIAlertController(title: "No Data", message: "Oups...there is no monney", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Later", style: .default))
        present(alert, animated: true)
    }
    
    func alertNoWeather(){
        let alert = UIAlertController(title: "No Data", message: "Oups...the sun is hide", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Later", style: .default))
        present(alert, animated: true)
    }
}
