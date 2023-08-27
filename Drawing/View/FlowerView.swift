//
//  FlowerView.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/26/23.
//

import SwiftUI

struct FlowerView: View {
    var primary: Color
    var secondary: Color
    var tertiary: Color
    
    @Binding var petalOffset: Double
    @Binding var petalWidth: Double
    @Binding var numberOfPetals: Double
    @Binding var tertiaryLineWidth: Float
    
    var body: some View {
        ZStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth, numberOfPetals: numberOfPetals)
                .fill(primary)
            Flower(petalOffset: petalOffset, petalWidth: petalWidth, numberOfPetals: numberOfPetals)
                .fill(secondary, style: FillStyle(eoFill: true, antialiased: true))
            Flower(petalOffset: petalOffset, petalWidth: petalWidth, numberOfPetals: numberOfPetals)
                .stroke(tertiary, lineWidth: CGFloat(tertiaryLineWidth))
        }
    }
}

struct FlowerView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerView(primary: .yellow, secondary: .blue, tertiary: .black, petalOffset: .constant(-20), petalWidth: .constant(100), numberOfPetals: .constant(16), tertiaryLineWidth: .constant(3))
    }
}
