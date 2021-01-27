//
//  Storage.swift
//  Homework4
//
//  Created by Вова Благой on 24.01.2021.
//

import Foundation

class Storage {
    var citys: [String] = ["Kyiv", "Dnipro", "London"]
    
    func addCity(city: String) {
        citys.append(city)
    }
}
