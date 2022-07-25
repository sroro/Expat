//
//  WebcamTableViewController.swift
//  Expat
//
//  Created by Rodolphe Schnetzer on 23/07/2022.
//

import UIKit
import SDWebImage

class WebcamTableViewController: UITableViewController {
    
    var webcam = WebcamsService()
    var numberWebcams = [String]()
    var arrayWebcams = [Webcam]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "WebcamTableViewCell", bundle: nil), forCellReuseIdentifier: "webcamCell")
        tableView.reloadData()
        receiveWebcam()
        SDImageCache.shared.clearDisk()
        SDImageCache.shared.clearMemory()
    }
    
    
    func receiveWebcam() {
        
        
        webcam.getWebcams { [weak self] resultat in
            switch resultat {
            case.failure(_):
                print("error")
            case.success(let result):
                
                DispatchQueue.main.async {
        
                    for data in result.result.webcams {
                        self?.arrayWebcams.append(data)
                        self?.numberWebcams.append(data.title)
                    }
                    
                    self?.tableView.reloadData()
                }
                
            }
        }
    }
    
    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberWebcams.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "webcamCell", for: indexPath) as? WebcamTableViewCell else { return UITableViewCell() }
        let array = arrayWebcams[indexPath.row]
        
        //remppli les info
        cell.webcamInformations = array
        
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
}

extension WebcamTableViewController: WebcamTableViewCellDelegate  {
    func liveButton() {
        print("hello")
    }
    
    
    
}
