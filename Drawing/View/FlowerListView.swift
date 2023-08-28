//
//  FlowerListView.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/26/23.
//

import SwiftUI

struct FlowerListView: View {
    @Environment(\.managedObjectContext) var context
//    @Environment(\.dismiss) var dismiss
    
    @StateObject private var flowerVM = FlowerViewModel()
    
    private var imageIndex = -1
    
    var body: some View {
        NavigationView {
            List {
                ForEach(flowerVM.flowers, id: \.id) { flower in
                    NavigationLink {
                        FlowerControlsView(flower: flowerVM.transformIntoModel(flower))
                            .environmentObject(flowerVM)
                    } label: {
                        HStack {
                            if let flowerImage = AdvancedImage.fetchImage(from: flower.flowerImageURL) {
                                Image(uiImage: flowerImage)
                            } else {
                                Image(systemName: "plus")
                            }
                            
                            VStack {
                                Text(flower.name ?? "No name")
                            }
                        }
                    }
                }

            }
            .navigationTitle("My Flowers")
            .onAppear { flowerVM.fetchFlowers(context: context) ; flowerVM.fetchImages() }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        FlowerControlsView()
                            .environmentObject(flowerVM)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct FlowerListView_Previews: PreviewProvider {
    static var previews: some View {
        FlowerListView()
    }
}
