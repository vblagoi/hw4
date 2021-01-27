//
//  ForecastWeatherCollectionViewCell.swift
//  Homework4
//
//  Created by Вова Благой on 27.01.2021.
//

import UIKit

class ForecastWeatherCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ForecastWeatherCollectionViewCell"
    
    var date: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    var temperature: UILabel = {
        let temperature = UILabel()
        temperature.translatesAutoresizingMaskIntoConstraints = false
        return temperature
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addSubview(date)
        addSubview(temperature)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        date.font = UIFont.systemFont(ofSize: 15.0)
        temperature.font = UIFont.systemFont(ofSize: 25.0)
        
        NSLayoutConstraint.activate([
            date.centerYAnchor.constraint(equalTo: centerYAnchor),
            date.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            
            temperature.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            temperature.topAnchor.constraint(equalTo: topAnchor),
            temperature.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
