//
//  LoadingCircleView.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/26/23.
//

import SwiftUI

struct LoadingCircleView: View {
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

struct LoadingCircleView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCircleView()
    }
}
