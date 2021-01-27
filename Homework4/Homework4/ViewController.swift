//
//  ViewController.swift
//  Homework4
//
//  Created by Вова Благой on 21.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var storage = Storage()
    private var cellsData: [String: Double] = [:]
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var addCityButton: UIButton!
    
    private let weatherCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.9254694581, green: 0.9256245494, blue: 0.9254490733, alpha: 1)
        view.addSubview(weatherCollectionView)
        
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseID)
        
        updateCellsData()
    }

    private func setupLayouts() {
        weatherCollectionView.translatesAutoresizingMaskIntoConstraints = false
        weatherCollectionView.backgroundColor = #colorLiteral(red: 0.9254694581, green: 0.9256245494, blue: 0.9254490733, alpha: 1)

        // Layout constraints for `weatherCollectionView`
        NSLayoutConstraint.activate([
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherCollectionView.topAnchor.constraint(equalTo: addCityButton.bottomAnchor, constant: 40),
            weatherCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateCellsData() {
        for city in storage.citys {
            let parse = CityWeatherParse()
            parse.parseCurrentTemperature(city: city, temperatureCompletionHandler: { temp, error in
                self.cellsData[city] = temp
                DispatchQueue.main.async {
                    self.weatherCollectionView.reloadData()
                }
            })
        }
    }
    
    @IBAction func addCityButton(_ sender: Any) {
        if cityTextField.text! == "" {
            showAlert()
            return
        }
        storage.addCity(city: cityTextField.text!)
        cityTextField.text = ""
        updateCellsData()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Attention", message: "Enter city", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storage.citys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.reuseID, for: indexPath) as! WeatherCollectionViewCell
        cell.cityName.text = storage.citys[indexPath.row]
        if let temp = cellsData[storage.citys[indexPath.row]] {
            cell.cityTemperature.text = String(temp) + " C"
        }
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        vc.name = storage.citys[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 100)
    }
    
}



