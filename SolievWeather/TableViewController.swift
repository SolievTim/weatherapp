//
//  TableViewController.swift
//  SolievWeather
//
//  Created by user on 23.09.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {
    
    @IBOutlet weak var cityTableView: UITableView!
    var cityName = ""
    
    struct Cities {
        var cityName = ""
        var cityTemp = 0.0
    }
    
    var cityTempArray: [Cities] = []
    
    func currentWeather(city: String) {
        let url = "http://api.weatherapi.com/v1/current.json?key=https://github.com/SwiftyJSON/SwiftyJSON.git&q=London&aqi=no\(city)"
        AF.request(url, method: .get).validate().responseJSON { response in switch response.result {
        case .success(let value):
            let json = JSON(value)
            let name = json["location"]["name"].stringValue
            let temp = json["current"]["temp_c"].doubleValue
            self.cityTempArray.append(Cities(cityName: name, cityTemp: temp))
            self.cityTableView.reloadData()
        case .failure(let error):
            print(error)
        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTableView.delegate = self
        cityTableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! citiesNameCell
        
        cell.cityName.text = cityTempArray[indexPath.row].cityName
        cell.cityTemp.text = String(cityTempArray[indexPath.row].cityTemp)
        
        return cell
    }
}
