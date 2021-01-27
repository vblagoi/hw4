//
//  DetailsViewController.swift
//  Homework4
//
//  Created by Вова Благой on 26.01.2021.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDelegate {
    
    var name: String = ""
    
    var countItems: Int = 0
    
    var forecastData: [ForecastModel] = []
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    
    @IBOutlet weak var cityPopulation: UILabel!
    
    private let forecastWeatherCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        updateInfo()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.9254694581, green: 0.9256245494, blue: 0.9254490733, alpha: 1)
        view.addSubview(forecastWeatherCollectionView)
        
        forecastWeatherCollectionView.dataSource = self
        forecastWeatherCollectionView.delegate = self
        forecastWeatherCollectionView.register(ForecastWeatherCollectionViewCell.self, forCellWithReuseIdentifier: ForecastWeatherCollectionViewCell.reuseID)
    }
    
    private func setupLayouts() {
        forecastWeatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        forecastWeatherCollectionView.backgroundColor = #colorLiteral(red: 0.9254694581, green: 0.9256245494, blue: 0.9254490733, alpha: 1)

        // Layout constraints for `collectionView`
        NSLayoutConstraint.activate([
            forecastWeatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            forecastWeatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            forecastWeatherCollectionView.topAnchor.constraint(equalTo: cityPopulation.bottomAnchor, constant: 40),
            forecastWeatherCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func updateInfo() {
        let parse = CityWeatherParse()
        parse.parseForecastData(city: name, temperatureCompletionHandler: { data, error in
            DispatchQueue.main.async {
                self.cityName.text = data?.city.name
                self.country.text = "Country " + (data?.city.country)!
                self.latitude.text = "Latitude " + String(format: "%.4f", (data?.city.coord.lat)!)//+ (data?.city.coord.lat)!
                self.longitude.text = "Longitude " + String(format: "%.4f", (data?.city.coord.lon)!)
                self.cityPopulation.text = "Population " + String((data?.city.population)!)
                self.forecastData = data!.list
                self.countItems = self.forecastData.count
                self.forecastWeatherCollectionView.reloadData()
            }
        })
    }

}

extension DetailsViewController: UICollectionViewDataSource, UICollisionBehaviorDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastWeatherCollectionViewCell.reuseID, for: indexPath) as! ForecastWeatherCollectionViewCell
        
        cell.date.text = forecastData[indexPath.row].dt_txt//storage.citys[indexPath.row]
        cell.temperature.text = String(forecastData[indexPath.row].main.temp) + " C"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 100)
    }
    
    
}
