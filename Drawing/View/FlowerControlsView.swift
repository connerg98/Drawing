//
//  FlowerControlsView.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/26/23.
//

import SwiftUI

struct FlowerControlsView: View {
//    @State private var petalOffset = -20.0
//    @State private var petalWidth = 100.0
//    @State private var numberOfPetals: Double = 16.0
//
//    @State private var petalLineWidth: CGFloat = 3.0
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var flowerVM: FlowerViewModel

    @State var flower = FlowerModel(id: nil, name: "", lineWidth: 3.0, numberOfPetals: 16, petalOffset: -20, petalWidth: 100, primaryColor: "20 30 100", secondaryColor: "100 40 10", tertiaryColor: "255 255 255")
    
    private var colorSet: (primary: Color, secondary: Color, tertiary: Color) {
        (rgbStringToColor(flower.primaryColor), rgbStringToColor(flower.secondaryColor), rgbStringToColor(flower.tertiaryColor))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                
                Group {
                    
                    FlowerView(primary: colorSet.primary, secondary: colorSet.secondary, tertiary: colorSet.tertiary, petalOffset: $flower.petalOffset, petalWidth: $flower.petalWidth, numberOfPetals: $flower.numberOfPetals, tertiaryLineWidth: $flower.lineWidth)
                    //                .padding(.top)
                    //                .frame(maxWidth: 50, maxHeight: 50)
                    
                }
                
                Spacer()
                
                
                Group {
                    VStack {
                        //                Text("Name:")
                        TextField("name", text: $flower.name)
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Text("Petal Count: \(Int(flower.numberOfPetals))")
                        Slider(value: $flower.numberOfPetals, in: 8...64)
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Text("Petal Offset: \(Int(flower.petalOffset))")
                        Slider(value: $flower.petalOffset, in: -40...40)
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Text("Petal Width: \(Int(flower.petalWidth))")
                        Slider(value: $flower.petalWidth, in: 1...100)
                    }
                    .padding(.horizontal)
                    
                    VStack {
                        Text("Petal Line Width: \(Int(flower.lineWidth))")
                        Slider(value: $flower.lineWidth, in: 0...15)
                    }
                    .padding(.horizontal)
                }
                
                VStack {
                    Text("Petal Line Width: \(Int(flower.lineWidth))")
                    Slider(value: $flower.lineWidth, in: 0...15)
                }
                .padding(.horizontal)
                
                VStack {
                    Text("Petal Line Width: \(Int(flower.lineWidth))")
                    Slider(value: $flower.lineWidth, in: 0...15)
                }
                .padding(.horizontal)
                VStack {
                    Text("Petal Line Width: \(Int(flower.lineWidth))")
                    Slider(value: $flower.lineWidth, in: 0...15)
                }
                .padding(.horizontal)
                VStack {
                    Text("Petal Line Width: \(Int(flower.lineWidth))")
                    Slider(value: $flower.lineWidth, in: 0...15)
                }
                .padding(.horizontal)
                VStack {
                    Text("Petal Line Width: \(Int(flower.lineWidth))")
                    Slider(value: $flower.lineWidth, in: 0...15)
                }
                .padding(.horizontal)
                
                Button("Save") {
                    if flower.id == nil {
                        flowerVM.create(flower, context: context)
                    } else {
                        flowerVM.edit(flower, context: context)
                    }
                    
                    flowerVM.save(context: context)
                    dismiss()
                }
            }
            //        .navigationTitle(flower.name)
            //        .padding()
        }
    }
}

struct FlowerControlsView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerControlsView()
    }
}
