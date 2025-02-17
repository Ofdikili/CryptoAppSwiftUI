//
//  LocalFileManager.swift
//  CryptoAppSwiftUI
//
//  Created by Ömer Faruk Dikili on 18.02.2025.
//

import Foundation
import UIKit
class LocalFileManager{
    static let instance = LocalFileManager()
    private init(){}
    
    func saveImage(image:UIImage , folderName:String,imageName:String){
        createFolderIfNeeded(folderName: folderName)
        guard
              let data  = image.pngData(),
              let url = getURlForImage(imageName:imageName,folderName:folderName)
        else {return}
        do{
            try data.write(to: url)
        }catch let error{
            print("Error saving image: \(error)")
        }
    }
    
    func getImage(imageName:String,folderName:String)->UIImage?{
        guard let url = getURlForImage(imageName:imageName,folderName:folderName) else { return nil }
        do{
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }catch let error{
            return nil
        }
    }
    
    private func createFolderIfNeeded(folderName:String){
        guard let url = getURlForFolder(folderName: folderName) else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory: \(error)")
            }
        }
    }
    
    
    
    private func getURlForFolder(folderName:String)->URL?{
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        guard let documentsDirectory = urls.first else { return nil }
        let folderURL = documentsDirectory.appendingPathComponent(folderName)
        return folderURL
    }
    
    private func getURlForImage(imageName:String,folderName:String)->URL?{
        guard let folderURL = getURlForFolder(folderName:folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
