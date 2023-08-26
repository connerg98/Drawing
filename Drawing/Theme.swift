//
//  Theme.swift
//  Drawing
//
//  Created by Conner Glasgow on 4/9/22.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var midnightBlue: Color {
        Color(red: decimalValueofRGB(value: 25), green: decimalValueofRGB(value: 25), blue: decimalValueofRGB(value: 112))
    }
    
    static var navyBlue: Color {
        Color(red: decimalValueofRGB(value: 0), green: decimalValueofRGB(value: 0), blue: decimalValueofRGB(value: 128))
    }
    
    static var sunsetPink: Color {
        Color(red: decimalValueofRGB(value: 250), green: decimalValueofRGB(value: 114), blue: decimalValueofRGB(value: 165))
    }
    
    static var sunset: Color {
        Color(red: decimalValueofRGB(value: 250), green: decimalValueofRGB(value: 214), blue: decimalValueofRGB(value: 165))
    }
    
    static var sunrise: Color {
        Color(red: decimalValueofRGB(value: 247), green: decimalValueofRGB(value: 205), blue: decimalValueofRGB(value: 93))
    }
    
    static var relaxingBlue: Color {
        Color(red: decimalValueofRGB(value: 145), green: decimalValueofRGB(value: 178), blue: decimalValueofRGB(value: 199))
    }
    
    static var relaxingOrange: Color {
        Color(red: decimalValueofRGB(value: 251), green: decimalValueofRGB(value: 190), blue: decimalValueofRGB(value: 129))
    }
    
    static var arabianRed: Color {
        Color(red: decimalValueofRGB(value: 163), green: decimalValueofRGB(value: 11), blue: decimalValueofRGB(value: 46))
    }
}

func decimalValueofRGB(value: Double) -> Double {
    return (value / 255)
}
