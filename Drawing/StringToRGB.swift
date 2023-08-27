//
//  StringToRGB.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/26/23.
//

import Foundation


extension String {
    func toRGB() -> (red: Double, green: Double, blue: Double) {
        let strings = self.components(separatedBy: " ")
        let numbers = strings.compactMap { Double($0) }
        
        let red = numbers[0]
        let green = numbers[1]
        let blue = numbers[2]
        
        return (red, green, blue)
    }
}
