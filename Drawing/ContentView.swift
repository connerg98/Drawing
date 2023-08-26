//
//  ContentView.swift
//  Drawing
//
//  Created by Conner Glasgow on 4/6/22.
//

import SwiftUI


struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct LoadingCircle: View {
    @State private var endAngle = 0.0
    
    let maxAngle = 360.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Text("%\(Int((endAngle / 360.0) * 100))")
                .font(.largeTitle)
            
            VStack {
                Arc(startAngle: .degrees(0), endAngle: .degrees(endAngle), clockwise: true)
                    .strokeBorder(.black, lineWidth: 15)
                    .padding()
                    .onReceive(timer) { Input in
                        if endAngle < maxAngle {
                            endAngle += 1
                        }
                    }
            }
        }
        .padding()
    }
}

struct Flower: InsettableShape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20

    // How wide to make each petal
    var petalWidth: Double = 100
    
    var insetAmount = 0.0
    var numberOfPetals: Double = 16.0

    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()

        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / (numberOfPetals / 2)) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)

            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))

            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)

            // add it to our main path
            path.addPath(rotatedPetal)
        }

        // now send the main path back
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var flower = self
        flower.insetAmount += amount
        return flower
    }
}

struct FlowerView: View {
    var primary: Color
    var secondary: Color
    var tertiary: Color
    
    @Binding var petalOffset: Double
    @Binding var petalWidth: Double
    @Binding var numberOfPetals: Double
    @Binding var tertiaryLineWidth: CGFloat
    
    var body: some View {
        ZStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth, numberOfPetals: numberOfPetals)
                .fill(primary)
            Flower(petalOffset: petalOffset, petalWidth: petalWidth, numberOfPetals: numberOfPetals)
                .fill(secondary, style: FillStyle(eoFill: true, antialiased: true))
            Flower(petalOffset: petalOffset, petalWidth: petalWidth, numberOfPetals: numberOfPetals)
                .stroke(tertiary, lineWidth: tertiaryLineWidth)
        }
    }
}

struct ContentView: View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
