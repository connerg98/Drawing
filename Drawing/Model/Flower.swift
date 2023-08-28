//
//  Flower.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/26/23.
//

import SwiftUI


struct FlowerModel {
    let id: UUID?
    var name: String
    var lineWidth: Float
    var numberOfPetals: Double
    var petalOffset: Double
    var petalWidth: Double
    var primaryColor: String
    var secondaryColor: String
    var tertiaryColor: String
    var imageURL: URL?
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
