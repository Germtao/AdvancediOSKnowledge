//
//  UserDefaults.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/5/6.
//  Copyright © 2019 unitTao. All rights reserved.
//

import Foundation

struct UserDefaultsKey {
    static let time = "timeNotation"
    static let units = "unitsNotation"
    static let temperature = "temperatureNotation"
}

extension UserDefaults {
    static func timeNotation() -> TimeNotation {
        let time = UserDefaults.standard.integer(forKey: UserDefaultsKey.time)
        guard let timeNotation = TimeNotation(rawValue: time) else { return .twelveHour }
        return timeNotation
    }
    
    static func unitsNotation() -> UnitsNotation {
        let units = UserDefaults.standard.integer(forKey: UserDefaultsKey.units)
        guard let unitsNotation = UnitsNotation(rawValue: units) else { return .imperial }
        return unitsNotation
    }
    
    static func temperatureNotation() -> TemperatureNotation {
        let temperature = UserDefaults.standard.integer(forKey: UserDefaultsKey.temperature)
        guard let temperatureNotation = TemperatureNotation(rawValue: temperature) else { return .fahrenheit }
        return temperatureNotation
    }
    
    static func set(timeNotation notation: TimeNotation) {
        UserDefaults.standard.set(notation.rawValue, forKey: UserDefaultsKey.time)
        UserDefaults.standard.synchronize()
    }
    
    static func set(unitsNotation notation: UnitsNotation) {
        UserDefaults.standard.set(notation.rawValue, forKey: UserDefaultsKey.units)
        UserDefaults.standard.synchronize()
    }
    
    static func set(temperatureNotation notation: TemperatureNotation) {
        UserDefaults.standard.set(notation.rawValue, forKey: UserDefaultsKey.temperature)
        UserDefaults.standard.synchronize()
    }
}
