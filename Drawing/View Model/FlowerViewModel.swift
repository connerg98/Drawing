//
//  FlowerViewModel.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/26/23.
//

import SwiftUI
import CoreData


class FlowerViewModel: ObservableObject {
    @Published var flowers: [FlowerCD] = []
    @Published var flowerImages: [UIImage] = []
    
    func fetchFlowers(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<FlowerCD> = FlowerCD.fetchRequest()
        
        do {
            flowers = try context.fetch(fetchRequest)
        } catch {
            print("ERROR; \(error.localizedDescription)")
        }
    }
    
    func fetchImages() {
        let imageURLs = flowers.compactMap { $0.flowerImageURL }
        let imageDataCollection = imageURLs.compactMap { try? Data(contentsOf: $0 as URL) }
        let images = imageDataCollection.compactMap { UIImage(data: $0) }
        
        flowerImages = images
    }
    
    func create(_ flower: FlowerModel, context: NSManagedObjectContext) {
        let newFlower = FlowerCD(context: context)
        newFlower.id = UUID()
        newFlower.name = flower.name
        newFlower.lineWidth = flower.lineWidth
        newFlower.numberOfPetals = flower.numberOfPetals
        newFlower.petalWidth = flower.petalWidth
        newFlower.petalOffset = flower.petalOffset
        
        newFlower.primaryColor = flower.primaryColor
        newFlower.secondaryColor = flower.secondaryColor
        newFlower.tertiaryColor = flower.tertiaryColor
        
        newFlower.flowerImageURL = flower.imageURL
        
        flowers.append(newFlower)
        
        save(context: context)
    }
    
    func edit(_ flower: FlowerModel, context: NSManagedObjectContext) {
        guard let index = index(of: flower) else { print("ERROR; flower doesn't exist") ; return }
        let editedFlower = flowers[index]
        
        editedFlower.name = flower.name
        editedFlower.lineWidth = flower.lineWidth
        editedFlower.numberOfPetals = flower.numberOfPetals
        editedFlower.petalWidth = flower.petalWidth
        editedFlower.petalOffset = flower.petalOffset
        
        editedFlower.primaryColor = flower.primaryColor
        editedFlower.secondaryColor = flower.secondaryColor
        editedFlower.tertiaryColor = flower.tertiaryColor
        
        editedFlower.flowerImageURL = flower.imageURL
        
        save(context: context)
    }
    
    func delete(_ flower: FlowerModel, context: NSManagedObjectContext) {
        guard let index = index(of: flower) else { print("ERROR; flower doesn't exist") ; return }
        let removedFlower = flowers[index]
        
        flowers.remove(at: index)
        
        context.delete(removedFlower)
    }
    
    func index(of flower: FlowerModel) -> Int? {
        return flowers.firstIndex(where: { $0.id == flower.id })
    }
    
    func transformIntoModel(_ flower: FlowerCD) -> FlowerModel {
        let newFlower = FlowerModel(
            id: flower.id ?? UUID(),
            name: flower.name ?? "No name",
            lineWidth: flower.lineWidth,
            numberOfPetals: flower.numberOfPetals,
            petalOffset: flower.petalOffset,
            petalWidth: flower.petalWidth,
            primaryColor: flower.primaryColor ?? "100 0 0",
            secondaryColor: flower.secondaryColor ?? "0 0 0",
            tertiaryColor: flower.tertiaryColor ?? "255 255 255",
            imageURL: flower.flowerImageURL)
        
        return newFlower
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("ERROR; \(error.localizedDescription)")
        }
    }
}
