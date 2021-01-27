//
//  WeatherCollectionViewCell.swift
//  Homework4
//
//  Created by Вова Благой on 24.01.2021.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "WeatherCollectionViewCell"
    
    var cityName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    var cityTemperature: UILabel = {
        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        return temperature
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(cityName)
        addSubview(cityTemperature)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        cityName.font = UIFont.systemFont(ofSize: 25.0)
        cityTemperature.font = UIFont.systemFont(ofSize: 25.0)
        
        NSLayoutConstraint.activate([
            cityName.centerYAnchor.constraint(equalTo: centerYAnchor),
            cityName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            cityTemperature.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            cityTemperature.topAnchor.constraint(equalTo: topAnchor),
            cityTemperature.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
