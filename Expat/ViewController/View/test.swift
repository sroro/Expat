//
//  test.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 02/06/2022.
//

import UIKit

class test: UIViewController {
    
    var test = CurrencyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func testButton(_ sender: Any) {
        test.getExchange(devise: "USD") { [weak self] result in
            switch result{
            case.failure(_):
                print("error")
            case .success(let resultOk):
                DispatchQueue.main.async {
                    self?.testLabel.text = String(resultOk)
                }
               
                
            }
        }
    }
    
    @IBOutlet weak var testLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
