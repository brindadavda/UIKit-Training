//
//  ViewController.swift
//  DemoCountryApp
//
//  Created by Brinda Davda on 17/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var countries: [GetAllCountriesQuery.Data.Country] = []
    
    private var countryInfo: GetCountryInfoQuery.Data.Country?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        Network.shared.apollo.fetch(query: GetAllCountriesQuery()){ result in
//            switch result{
//            case .success(let graphQLResult) :
//                
//                if let countries = graphQLResult.data?.countries {
//                    DispatchQueue.main.async {
//                        self.countries = countries
//                        
//                        self.countries.forEach({self.getDataBYContryWise(country: $0)})
//                        
//                        
//                    }
//                }
//                
//            case .failure(let error) : print("Featching error : \(error)")
//            }
//            
//        }
        
        
        fetchWeatherByCityName(city: "India")
        
        
        
    }


    private func getDataBYContryWise(country : GetAllCountriesQuery.Data.Country){
        Network.shared.apollo.fetch(query: GetCountryInfoQuery(code: country.code)) { result in
            switch result {
            case .success(let graphQLResult):
                DispatchQueue.main.async {
                    self.countryInfo = graphQLResult.data?.country
                    
                    print("countryInfo : \(self.countryInfo)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    private func fetchWeatherByCityName(city: String) {
        
        Network.shared.weather_apollo.fetch(query: GetWeatherByCityNameQuery(city: city)) { result in
            switch result {
            case .success(let graphQLResult):
                
                 print("Weather Data : \(graphQLResult.data)")
//                      let getCityName = data.getCityByName,
//                      let weather = getCityName.weather,
//                      let summary = weather.summary,
//                      let title = summary.title,
//                      let description = summary.description,
//                      let clouds = weather.clouds,
//                      let humidity = clouds.humidity,
//                      let temperature = weather.temperature,
//                      let actual = temperature.actual,
//                      let feelsLike = temperature.feelsLike,
//                      let icon = self.getSystemIcon(icon: summary.icon) else {
//                    
//                    DispatchQueue.main.async {
//                        self.loadingStatus = .notFound
//                    }
//                    return
//                }
//                
//                self.weatherInfo = WeatherInfoViewModel(temperature: actual, humidity: humidity, summaryTitle: title, summaryDescription: description, feelsLike: feelsLike, icon: icon)
//                
//                DispatchQueue.main.async {
//                    self.loadingStatus = .success
//                }
                
                
                
            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.loadingStatus = .failure
//                }
                print("Faild : \(error)")
            }
        }
        
    }
    
}

