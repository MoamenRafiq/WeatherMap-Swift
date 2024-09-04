//
//  ViewController.swift
//  weathermap
//
//  Created by Moamen Rafiq on 31/08/2024.
//

import UIKit
import Alamofire
class HomeVC: UIViewController {
    
    @IBOutlet weak var ActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var CityNameLbl: UILabel!
    @IBOutlet weak var TempLbl: UILabel!
    @IBOutlet weak var HumidityLbl: UILabel!
    @IBOutlet weak var PressureLbl: UILabel!
    
    @IBOutlet weak var GroupSV: UIView!
    @IBOutlet weak var ButtonEdit: UIButton!
    
    var cityId = "358172"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GroupSV.layer.cornerRadius = 18
        ButtonEdit.layer.cornerRadius = 18
        NotificationCenter.default.addObserver(self, selector: #selector(cityChange), name: NSNotification.Name(rawValue: "ChangeCityValue"), object: nil)
        
        
        getCityWeatherInfo()
        
    }
    func getCityWeatherInfo() {
        let params = ["id":cityId, "appId": "714851d850312db371d444e49104fa18"]
//        ActivityIndicatorView.isHidden = false
        ActivityIndicatorView.startAnimating()
        
        AF.request("https://api.openweathermap.org/data/2.5/weather" , parameters : params, encoder : URLEncodedFormParameterEncoder.default) .responseJSON { response in
            print(response.value)
            if let result = response.value {
                
                let JSONDictionary = result as! NSDictionary
                let main = JSONDictionary["main"] as! NSDictionary
                var temp = main["temp"] as! Double
                var pressure = main["pressure"] as! Double
                var humidity = main["humidity"] as! Double
                
                temp = temp - 272.15
                temp = Double (round (1000 * temp) / 1000)
                self.ActivityIndicatorView.stopAnimating()
//                self.ActivityIndicatorView.isHidden = true
                self.TempLbl.text = "\(temp)°"
                self.HumidityLbl.text = "\(humidity)"
                self.PressureLbl.text = "\(pressure)"
                
            }
        }
    }
    @objc func cityChange (notification : Notification) {
        if let city = notification.userInfo?["city"] as? City {
            CityNameLbl.text = city.name
            cityId = city.Id
            getCityWeatherInfo()
        }
        
    }
    
}


