//
//  EditCityVC.swift
//  weathermap
//
//  Created by Moamen Rafiq on 03/09/2024.
//

import UIKit

class EditCityVC: UIViewController {
   
    var CitiesArray = [
    City(name: "Alexandria",Id: "361058"),
    City(name: "Al Alamayn",Id: "361612"),
    City(name: "Arish",Id: "361546"),
    City(name: "Port Said",Id: "358619")
    ]
    
  
    var selectedcity : City?
    
    @IBOutlet weak var ButtonChange: UIButton!
    @IBOutlet weak var CitiesPickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CitiesPickerView.delegate = self
        CitiesPickerView.dataSource = self
        
        ButtonChange.layer.cornerRadius = 18
        
        
    }
    
    @IBAction func ChangeCityButton(_ sender: Any) {
        if let city = selectedcity {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeCityValue"), object: nil, userInfo: ["city" : city])
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}
extension EditCityVC :  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        CitiesArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CitiesArray[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedcity = CitiesArray[row]
    }
    
}
