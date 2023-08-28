//
//  FileManager-DocumentsDirectory.swift
//  Drawing
//
//  Created by Conner Glasgow on 8/27/23.
//

import Foundation


extension FileManager {
    func documentDirectory(appendingPathComp: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(appendingPathComp)
    }
}
