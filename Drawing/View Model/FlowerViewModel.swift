//
//  FlowerViewModel.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/26/23.
//

import Foundation
import CoreData


class FlowerViewModel: ObservableObject {
    @Published var flowers: [FlowerCD] = []
    
    func fetchFlowers(context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<FlowerCD> = FlowerCD.fetchRequest()
        
        do {
            flowers = try context.fetch(fetchRequest)
        } catch {
            print("ERROR; \(error.localizedDescription)")
        }
    }
}
