import Foundation
import UIKit

class PSDDocument {
    let width: Int
    let height: Int
    var layers: [PSDLayer] = []
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func addLayer(name: String, width: Int, height: Int) -> PSDLayer {
        let layer = PSDLayer(name: name, width: width, height: height)
        layers.append(layer)
        return layer
    }
    
    func write(toFile path: String) throws {
        let url = URL(fileURLWithPath: path)
        let directoryURL = url.deletingLastPathComponent()
        
        // Create the directory if it doesn't exist
        try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        
        // Create the file if it doesn't exist
        if !FileManager.default.fileExists(atPath: path) {
            FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        }
        
        let fileHandle = try FileHandle(forWritingTo: url)
        
        // Write the header
        let header = PSDHeader(height: UInt32(height), width: UInt32(width))
        fileHandle.write(header.data)
        
        // Write color mode data (empty for now)
        fileHandle.write(UInt32(0).data)
        
        // Write image resources (empty for now)
        fileHandle.write(UInt32(0).data)
        
        // Write layer and mask information
        var layerData = Data()
        for layer in layers {
            layerData.append(layer.data)
        }
        
        let layerDataLength = UInt32(layerData.count)
        fileHandle.write(layerDataLength.data)
        fileHandle.write(layerData)
        
        // Write image data (merged layer)
        var imageData = Data()
        for layer in layers {
            imageData.append(layer.imageData)
        }
        
        fileHandle.write(imageData)
        
        fileHandle.closeFile()
    }
}

class PSDLayer {
    let name: String
    let width: Int
    let height: Int
    var pixelData: [UInt8]
    
    init(name: String, width: Int, height: Int) {
        self.name = name
        self.width = width
        self.height = height
        self.pixelData = [UInt8](repeating: 0, count: width * height * 4)
    }
    
    func setPixel(x: Int, y: Int, red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
        let index = (y * width + x) * 4
        pixelData[index] = red
        pixelData[index + 1] = green
        pixelData[index + 2] = blue
        pixelData[index + 3] = alpha
    }
    
    var data: Data {
        var data = Data()
        
        // Write layer info (this is highly simplified and not a complete implementation)
        data.append(name.data(using: .utf8)!)
        data.append(UInt32(width).data)
        data.append(UInt32(height).data)
        data.append(Data(pixelData))  // Convert the array to Data before appending
        
        return data
    }
    
    var imageData: Data {
        return Data(pixelData)
    }
}

struct PSDHeader {
    let signature: [UInt8] = [0x38, 0x42, 0x50, 0x53]
    let version: UInt16 = 1
    let reserved: [UInt8] = [UInt8](repeating: 0, count: 6)
    let channels: UInt16 = 4
    let height: UInt32
    let width: UInt32
    let depth: UInt16 = 8
    let colorMode: UInt16 = 3
    
    var data: Data {
        var data = Data(signature)
        data.append(version.data)
        data.append(contentsOf: reserved)
        data.append(channels.data)
        data.append(height.data)
        data.append(width.data)
        data.append(depth.data)
        data.append(colorMode.data)
        return data
    }
}

extension FixedWidthInteger {
    var data: Data {
        withUnsafeBytes(of: self.bigEndian) { Data($0) }
    }
}

func convertPngToPsd(pngImage: UIImage, outputFilePath: String) {
    guard let cgImage = pngImage.cgImage else {
        print("Failed to get CGImage from UIImage")
        return
    }
    
    let width = cgImage.width
    let height = cgImage.height
    
    // Create a new PSD document
    let psd = PSDDocument(width: width, height: height)
    
    // Create a new layer
    let layer = psd.addLayer(name: "Background", width: width, height: height)
    
    // Get pixel data from the UIImage
    guard let data = cgImage.dataProvider?.data else {
        print("Failed to get pixel data from CGImage")
        return
    }
    
    let pixelData = CFDataGetBytePtr(data)
    let bytesPerRow = cgImage.bytesPerRow
    
    // Set the pixel data to the PSD layer
    for y in 0..<height {
        for x in 0..<width {
            let pixelIndex = y * bytesPerRow + x * 4
            
            let red = pixelData?[pixelIndex]
            let green = pixelData?[pixelIndex + 1]
            let blue = pixelData?[pixelIndex + 2]
            let alpha = pixelData?[pixelIndex + 3]
            
            layer.setPixel(x: x, y: height - y - 1, red: red ?? 0, green: green ?? 0, blue: blue ?? 0, alpha: alpha ?? 0)
        }
    }
    
    // Get the documents directory URL
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let outputURL = documentsDirectory.appendingPathComponent(outputFilePath)
    
    // Ensure the directory exists
    let outputDirectory = outputURL.deletingLastPathComponent()
    do {
        try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true, attributes: nil)
    } catch {
        print("Failed to create directory: \(error)")
        return
    }
    
    // Write the PSD file to the specified path
    do {
        try psd.write(toFile: outputURL.path)
        print("Successfully wrote PSD file to \(outputURL.path)")
    } catch {
        print("Failed to write PSD file: \(error)")
    }
}

