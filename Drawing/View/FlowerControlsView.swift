//
//  FlowerControlsView.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/26/23.
//

import SwiftUI

struct FlowerControlsView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var numberOfPetals: Double = 16.0
    
    @State private var petalLineWidth: CGFloat = 3.0
    
    var body: some View {
        VStack {
            FlowerView(primary: .black, secondary: .arabianRed, tertiary: .white, petalOffset: $petalOffset, petalWidth: $petalWidth, numberOfPetals: $numberOfPetals, tertiaryLineWidth: $petalLineWidth)
                .padding()
            
            VStack {
                Text("Petal Count: \(Int(numberOfPetals))")
                Slider(value: $numberOfPetals, in: 8...64)
            }
            .padding()
            
            VStack {
                Text("Petal Offset: \(Int(petalOffset))")
                Slider(value: $petalOffset, in: -40...40)
            }
            .padding()
            
            VStack {
                Text("Petal Width: \(Int(petalWidth))")
                Slider(value: $petalWidth, in: 1...100)
            }
            .padding()
            
            VStack {
                Text("Petal Line Width: \(Int(petalLineWidth))")
                Slider(value: $petalLineWidth, in: 0...15)
            }
            .padding()
        }
        .padding()
    }
}

struct FlowerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerControlsView()
    }
}
