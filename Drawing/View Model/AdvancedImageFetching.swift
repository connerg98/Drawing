//
//  AdvancedImageFetching.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/27/23.
//

import SwiftUI


struct AdvancedImage {
    static func fetchImage(from imageURL: URL?) -> UIImage? {
        guard let imageURL = imageURL else { return nil }
        
        do {
            let data = try Data(contentsOf: imageURL)
            let image = UIImage(data: data)
            
            return image
        } catch {
            print("ERROR; \(error.localizedDescription)")
        }
        
        return nil
    }
    
//    static func placeHolderImage() -> UIImage {
//        UI
//    }
    
//    static func takeSnapshot(of view: some View) -> UIImage {
//        let controller = UIHostingController(rootView: view)
//        let view = controller.view!
//
//        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
//        let image = renderer.image { _ in
//            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
//        }
//
//        controller.dismiss(animated: false)
//
//        return image
//    }
    
    static func takeSnapshot(of view: UIView) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        
        return renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }
    }
    
    static func saveSnapshot(_ image: UIImage?, imageName: String, imageURL: inout URL?) {
        guard let image = image else { print("ERROR; failed to save") ;
            return }
                
        if let data = image.pngData() {
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL: URL
                
                if let url = imageURL {
                    fileURL = url
                    
                    print(imageURL)
                } else {
                    fileURL = documentsDirectory.appendingPathComponent(imageName + ".png")
                    imageURL = fileURL
                    
                    print(imageURL)
                }
                
                do {
                    try data.write(to: fileURL)
                } catch {
                    print("ERROR; \(error.localizedDescription)")
                }
            } else {
                print("failed to locate url for document directory")
            }
        } else {
            print("failed to convert image to png")
        }
    }
}
