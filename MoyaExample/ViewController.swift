//
//  ViewController.swift
//  MoyaExample
//
//  Created by Kittikawin Sontinarakul on 10/5/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var searchCityNameButton: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    
    let provider = MoyaProvider<WeatherService>()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func searchCityNameButtonPressed(_ sender: UIButton) {
        guard let cityName = cityNameTextField.text else {
            return
        }
        provider.request(.fecthWeatherCity(name: cityName), completion: fetchCityName(result:))
    }
    
    @IBAction func getLocationButtonPressed(_ sender: UIBarButtonItem) {
        locationManager.requestLocation()
    }
    
    func fetchCityName(result: Result<Response, MoyaError>) {
        switch result {
        case .success(let response):
            decodeAndShow(response)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    fileprivate func decodeAndShow(_ response: (Response)) {
        do {
            let decodedData = try response.map(WeatherData.self)
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            
            self.textView.text = "\(cityName) : \(temp) C"
        }
        catch {
            
        }
    }
    
    func fetchLocationHandler(result: Result<Response, MoyaError>) {
        switch result {
        case .success(let response):
            decodeAndShow(response)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
                
        if let location = locations.last {
            provider.request(.fecthWeatherLocation(lat: location.coordinate.latitude, long: location.coordinate.longitude), completion: fetchLocationHandler(result:))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
