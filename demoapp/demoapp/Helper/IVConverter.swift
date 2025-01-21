//
//  IVConverter.swift
//  demoapp
//
//  Created by apple on 18/05/24.
//

import Foundation
import UIKit
import ImageIO
import CoreGraphics
import MobileCoreServices
import CoreFoundation
import UniformTypeIdentifiers

import SVGKit

var potrace: Potrace!

var width: Int!
var height: Int!
var imagePixels: [UInt8]!





func convertPNGtoWBMP(pngURL: URL, wbmpFileName: String) -> Bool {
    // Load the PNG image from the given URL
    guard let inputImage = UIImage(contentsOfFile: pngURL.path) else {
        print("Failed to load image from \(pngURL.path)")
        return false
    }

    // Convert the image to grayscale
    guard let grayscaleImage = convertToGrayscale(image: inputImage) else {
        print("Failed to convert image to grayscale")
        return false
    }

    // Convert the grayscale image to WBMP data
    guard let wbmpData = convertToWBMPData(image: grayscaleImage) else {
        print("Failed to convert image to WBMP data")
        return false
    }

    // Get the documents directory URL
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let wbmpURL = documentsDirectory.appendingPathComponent(wbmpFileName)

    // Save the WBMP data to the output URL
    do {
        try wbmpData.write(to: wbmpURL)
        print("Successfully saved WBMP to \(wbmpURL.path)")
        return true
    } catch {
        print("Failed to save WBMP file: \(error)")
        return false
    }
}

func convertToGrayscale(image: UIImage) -> UIImage? {
    guard let cgImage = image.cgImage else {
        return nil
    }

    let width = cgImage.width
    let height = cgImage.height
    let colorSpace = CGColorSpaceCreateDeviceGray()
    let bitmapInfo = CGImageAlphaInfo.none.rawValue

    guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width, space: colorSpace, bitmapInfo: bitmapInfo) else {
        return nil
    }

    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

    guard let grayscaleCGImage = context.makeImage() else {
        return nil
    }

    return UIImage(cgImage: grayscaleCGImage)
}

func convertToWBMPData(image: UIImage) -> Data? {
    guard let cgImage = image.cgImage else {
        return nil
    }

    let width = cgImage.width
    let height = cgImage.height
    let bytesPerRow = width
    var data = Data()

    // WBMP Header
    data.append(0x00) // Type field (0 for B/W, 1 for 16-gray)
    data.append(contentsOf: encodeMultiByteUInt(width))
    data.append(contentsOf: encodeMultiByteUInt(height))

    // Image Data
    guard let dataProvider = cgImage.dataProvider, let pixelData = dataProvider.data else {
        return nil
    }

    let pixels = CFDataGetBytePtr(pixelData)
    for y in 0..<height {
        for x in 0..<width {
            let pixelIndex = y * bytesPerRow + x
            let pixel = pixels![pixelIndex]
            data.append(pixel > 127 ? 0x00 : 0x01)
        }
    }

    return data
}

func encodeMultiByteUInt(_ value: Int) -> [UInt8] {
    var result = [UInt8]()
    var currentValue = value

    repeat {
        var byte = UInt8(currentValue & 0x7F)
        currentValue >>= 7
        if currentValue > 0 {
            byte |= 0x80
        }
        result.append(byte)
    } while currentValue > 0

    return result
}



extension UIImage {
    
    func pixelData() -> [UInt8]? {
        let size = self.size
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let cgImage = self.cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        return pixelData
    }
    
    func resize(to targetSize: CGSize) -> UIImage? {
            let size = self.size

            // Calculate the aspect ratio and determine new size
            let widthRatio  = targetSize.width  / size.width
            let heightRatio = targetSize.height / size.height
            let newSize: CGSize

            // Ensure the image is square
            if widthRatio > heightRatio {
                newSize = CGSize(width: targetSize.width, height: targetSize.width)
            } else {
                newSize = CGSize(width: targetSize.height, height: targetSize.height)
            }

            // Draw the resized image
            let rect = CGRect(origin: .zero, size: newSize)
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            self.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage
        }
}

func createImageDestination(inputImage: UIImage ) {
    // Resize the image to a supported ICO size
       guard let resizedImage = inputImage.resize(to: CGSize(width: 256, height: 256)) else {
           print("Failed to resize image")
           return
       }
       
       // Convert UIImage to PNG Data
       guard let pngData = resizedImage.pngData() else {
           print("Failed to convert UIImage to PNG data")
           return
       }
       
       // Create CFMutableData
       let cfMutableData = CFDataCreateMutable(kCFAllocatorDefault, 0)
       CFDataAppendBytes(cfMutableData, [UInt8](pngData), pngData.count)
       
       if #available(iOS 14.0, *) {
           // Create image destination for ICO
           guard let imageDestination = CGImageDestinationCreateWithData(cfMutableData!, UTType.ico.identifier as CFString, 1, nil) else {
               print("Failed to create CGImageDestination")
               return
           }
           
           // Get CGImage from UIImage
           guard let cgImage = resizedImage.cgImage else {
               print("Failed to get CGImage from UIImage")
               return
           }
           
           // Add CGImage to the destination
           CGImageDestinationAddImage(imageDestination, cgImage, nil)
           
           // Finalize the image destination
           if !CGImageDestinationFinalize(imageDestination) {
               print("Failed to finalize CGImageDestination")
               return
           }
           let outputFilePath = NSTemporaryDirectory().appending("output.ico")
           // Write the data to a file
           let fileURL = URL(fileURLWithPath: outputFilePath)
           do {
               try (cfMutableData! as NSData).write(to: fileURL, options: .atomic)
               print("Successfully saved image to file: \(outputFilePath)")
           } catch {
               print("Failed to write image data to file: \(error)")
           }
           
           print("Successfully created CGImageDestination with data")
       } else {
           // Fallback on earlier versions
           print("ICO creation is not supported on iOS versions earlier than 14.0")
       }
    
}

func convertPngToSvgUsingLibrary( originalImage : UIImage , imageView : UIImageView ) {
    if let pixels = originalImage.pixelData() {
        
        width = Int(originalImage.size.width)
        height = Int(originalImage.size.height)
        imagePixels = pixels
        
        updateImage(settings: Potrace.Settings() , for : imageView)
    }
}

func updateImage(settings: Potrace.Settings, for curves : UIImageView) {
    potrace = Potrace(data: UnsafeMutableRawPointer(mutating: imagePixels),
                           width: width,
                           height: height)
    
    potrace.process(settings: settings)

    let bezier = potrace.getBezierPath(scale: 2.0)
    
    DispatchQueue.main.async {
        let newImage = imageFromBezierPath(path: bezier, size: CGSize(width: curves.frame.width, height: curves.frame.height))
        curves.image = newImage
    }
}

func imageFromBezierPath(path: UIBezierPath, size: CGSize) -> UIImage {
    var image = UIImage()
    UIGraphicsBeginImageContext(size)
    if let context = UIGraphicsGetCurrentContext() {
        context.saveGState()
        path.fill()
        image = UIGraphicsGetImageFromCurrentImageContext()!
        context.restoreGState()
        UIGraphicsEndImageContext()
    }
    
    return image
}


extension FixedWidthInteger {
    var littleEndianBytes: [UInt8] {
        withUnsafeBytes(of: littleEndian, Array.init)
    }
}

func convertPngToBmp(pngImage: UIImage, outputFilePath: String) {
    guard let cgImage = pngImage.cgImage else {
        print("Failed to get CGImage from UIImage")
        return
    }

    let width = cgImage.width
    let height = cgImage.height
    let bitsPerComponent = 8
    let bytesPerRow = 4 * width
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue

    var pixelData = Data(count: height * bytesPerRow)
    let context = CGContext(
        data: pixelData.withUnsafeMutableBytes { $0.baseAddress },
        width: width,
        height: height,
        bitsPerComponent: bitsPerComponent,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: bitmapInfo
    )

    guard let drawingContext = context else {
        print("Failed to create CGContext")
        return
    }

    // Flip the context vertically
    drawingContext.translateBy(x: 0, y: CGFloat(height))
    drawingContext.scaleBy(x: 1.0, y: -1.0)

    drawingContext.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))

    let bmpFileHeaderSize = 14
    let bmpInfoHeaderSize = 40
    let fileSize = bmpFileHeaderSize + bmpInfoHeaderSize + pixelData.count

    var fileHeader = Data()
    fileHeader.append(0x42) // 'B'
    fileHeader.append(0x4D) // 'M'
    fileHeader.append(contentsOf: UInt32(fileSize).littleEndianBytes)
    fileHeader.append(contentsOf: UInt16(0).littleEndianBytes) // reserved
    fileHeader.append(contentsOf: UInt16(0).littleEndianBytes) // reserved
    fileHeader.append(contentsOf: UInt32(bmpFileHeaderSize + bmpInfoHeaderSize).littleEndianBytes)

    var infoHeader = Data()
    infoHeader.append(contentsOf: UInt32(bmpInfoHeaderSize).littleEndianBytes)
    infoHeader.append(contentsOf: Int32(width).littleEndianBytes)
    infoHeader.append(contentsOf: Int32(height).littleEndianBytes)
    infoHeader.append(contentsOf: UInt16(1).littleEndianBytes) // planes
    infoHeader.append(contentsOf: UInt16(32).littleEndianBytes) // bits per pixel
    infoHeader.append(contentsOf: UInt32(0).littleEndianBytes) // compression (none)
    infoHeader.append(contentsOf: UInt32(pixelData.count).littleEndianBytes)
    infoHeader.append(contentsOf: Int32(0).littleEndianBytes) // x pixels per meter (not specified)
    infoHeader.append(contentsOf: Int32(0).littleEndianBytes) // y pixels per meter (not specified)
    infoHeader.append(contentsOf: UInt32(0).littleEndianBytes) // total colors (not specified)
    infoHeader.append(contentsOf: UInt32(0).littleEndianBytes) // important colors (all)

    var bmpData = Data()
    bmpData.append(fileHeader)
    bmpData.append(infoHeader)
    bmpData.append(pixelData)

    do {
        // Get the documents directory URL
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputURL = documentsDirectory.appendingPathComponent(outputFilePath)

        // Ensure the directory exists
        let outputDirectory = outputURL.deletingLastPathComponent()
        try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true, attributes: nil)

        try bmpData.write(to: outputURL)
        print("Successfully wrote BMP file to \(outputURL.path)")
    } catch {
        print("Failed to write BMP file: \(error)")
    }
}

func ascii85Encode(_ data: Data) -> String {
    let table: [UInt8] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!#$%&()*+-;<=>?@^_`{|}~".utf8)
    var encoded = ""
    var buffer = [UInt8](repeating: 0, count: 4)
    var count = 0
    
    for byte in data {
        buffer[count] = byte
        count += 1
        
        if count == 4 {
            let value = (UInt32(buffer[0]) << 24) | (UInt32(buffer[1]) << 16) | (UInt32(buffer[2]) << 8) | UInt32(buffer[3])
            if value == 0 {
                encoded.append("z")
            } else {
                var encodedValue = ""
                var tempValue = value
                for _ in 0..<5 {
                    encodedValue = String(UnicodeScalar(table[Int(tempValue % 85)])) + encodedValue
                    tempValue /= 85
                }
                encoded.append(encodedValue)
            }
            count = 0
        }
    }
    
    if count > 0 {
        for i in count..<4 {
            buffer[i] = 0
        }
        let value = (UInt32(buffer[0]) << 24) | (UInt32(buffer[1]) << 16) | (UInt32(buffer[2]) << 8) | UInt32(buffer[3])
        var encodedValue = ""
        var tempValue = value
        for _ in 0..<5 {
            encodedValue = String(UnicodeScalar(table[Int(tempValue % 85)])) + encodedValue
            tempValue /= 85
        }
        encoded.append(String(encodedValue.prefix(count + 1)))
    }
    
    return encoded
}

func convertPngToEps(pngImage: UIImage, outputFilePath: String) {
    guard let cgImage = pngImage.cgImage else {
        print("Failed to get CGImage from UIImage")
        return
    }
    
    let width = cgImage.width
    let height = cgImage.height
    let bitsPerComponent = 8
    let bytesPerRow = 4 * width
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
    
    guard let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: bitsPerComponent,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: bitmapInfo
    ) else {
        print("Failed to create CGContext")
        return
    }
    
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    
    guard let pixelData = context.data else {
        print("Failed to get pixel data from CGContext")
        return
    }
    
    let data = Data(bytes: pixelData, count: height * bytesPerRow)
    let ascii85Data = ascii85Encode(data)
    
    let epsContent = """
    %!PS-Adobe-3.0 EPSF-3.0
    %%BoundingBox: 0 0 \(width) \(height)
    %%HiResBoundingBox: 0 0 \(width) \(height)
    /pix \(width) string def
    \(width) \(height) 8
    [\(width) 0 0 -\(height) 0 \(height)]
    {currentfile pix readhexstring pop}
    false 3 colorimage
    \(ascii85Data)
    showpage
    """
    
    do {
        // Get the documents directory URL
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputURL = documentsDirectory.appendingPathComponent(outputFilePath)
        
        // Ensure the directory exists
        let outputDirectory = outputURL.deletingLastPathComponent()
        try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true, attributes: nil)
        
        // Write EPS data
        try epsContent.write(to: outputURL, atomically: true, encoding: .utf8)
        print("Successfully wrote EPS file to \(outputURL.path)")
    } catch {
        print("Failed to write EPS file: \(error)")
    }
}



func convertPNGtoTIFF(pngURL: URL, tiffURL: URL) -> Bool {
    guard let source = CGImageSourceCreateWithURL(pngURL as CFURL, nil) else {
        print("Failed to create image source")
        return false
    }
    
    guard let destination = CGImageDestinationCreateWithURL(tiffURL as CFURL, kUTTypeTIFF, 1, nil) else {
        print("Failed to create image destination")
        return false
    }
    
    CGImageDestinationAddImageFromSource(destination, source, 0, nil)
    
    if !CGImageDestinationFinalize(destination) {
        print("Failed to finalize image destination")
        return false
    }
    
    return true
}


// Define custom TGA UTI
let kUTTypeTGA = "com.truevision.tga-image"

func convertPNGtoTGA(pngURL: URL, completion: @escaping (Bool, Error?) -> Void) {
    guard let image = UIImage(contentsOfFile: pngURL.path) else {
        completion(false, NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to load PNG image"]))
        return
    }

    guard let cgImage = image.cgImage else {
        completion(false, NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create CGImage from PNG image"]))
        return
    }

    let width = cgImage.width
    let height = cgImage.height
    let bitsPerComponent = 8
    let bytesPerPixel = 4 // RGBA
    let bytesPerRow = bytesPerPixel * width
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue

    guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
        completion(false, NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create CGContext"]))
        return
    }

    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))

    if let imageData = context.data {
        let cfData = CFDataCreate(nil, imageData, bytesPerRow * height)
        guard let dataProvider = CGDataProvider(data: cfData!) else {
            completion(false, NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create CGDataProvider"]))
            return
        }

        let outputURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("output.tga")

        let tgaImage = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bytesPerPixel * 8,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: CGBitmapInfo(rawValue: bitmapInfo) ,
            provider: dataProvider,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )

        guard let destination = CGImageDestinationCreateWithURL(outputURL as CFURL, kUTTypeTGA as CFString, 1, nil) else {
            completion(false, NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create image destination"]))
            return
        }

        CGImageDestinationAddImage(destination, tgaImage!, nil)

        if CGImageDestinationFinalize(destination) {
            print(destination)
            print("Successfully converted PNG to TIFF. TIFF file saved at: \(outputURL)" )
            completion(true, nil)
        } else {
            completion(false, NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to finalize image destination"]))
        }
    } else {
        completion(false, NSError(domain: "ConversionError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve image data from CGContext"]))
    }
}


func convertPNGtoPS(pngImage: UIImage, outputFileName: String) {
    guard let cgImage = pngImage.cgImage else {
        print("Failed to get CGImage from UIImage")
        return
    }
    
    let width = cgImage.width
    let height = cgImage.height
    
    let psHeader = """
    %!PS-Adobe-3.0
    /image {
        \(width) \(height) 8
        [\(width) 0 0 -\(height) 0 \(height)]
        { currentfile \(width) string readhexstring pop }
        false 3
        colorimage
    } def
    """
    
    let psContent = """
    image
    """
    
    var psData = psHeader + psContent
    
    // Encode image data as hex
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bytesPerPixel = 4
    let bytesPerRow = bytesPerPixel * width
    let bitsPerComponent = 8
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
    
    guard let context = CGContext(data: nil,
                                  width: width,
                                  height: height,
                                  bitsPerComponent: bitsPerComponent,
                                  bytesPerRow: bytesPerRow,
                                  space: colorSpace,
                                  bitmapInfo: bitmapInfo) else {
        print("Failed to create CGContext")
        return
    }
    
    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
    
    guard let imageData = context.data else {
        print("Failed to get image data from CGContext")
        return
    }
    
    let dataPointer = imageData.bindMemory(to: UInt8.self, capacity: bytesPerRow * height)
    var hexString = ""
    for i in 0..<(bytesPerRow * height) {
        hexString += String(format: "%02x", dataPointer[i])
    }
    
    // Add image data to PS content
    psData += "\n<\(hexString)>"
    
    // Write PS data to file in the Documents directory
    guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print("Failed to get Documents directory")
        return
    }
    
    let outputURL = documentsDirectory.appendingPathComponent(outputFileName)
    
    do {
        try psData.write(to: outputURL, atomically: true, encoding: .utf8)
        print("Successfully wrote PS file to \(outputURL.path)")
    } catch {
        print("Failed to write PS file: \(error)")
    }
}


func convertPNGtoPDF(pngImage: UIImage, outputFilePath: String) {
    // Create a PDF graphics context
    UIGraphicsBeginPDFContextToFile(outputFilePath, CGRect.zero, nil)
    guard let pdfContext = UIGraphicsGetCurrentContext() else {
        print("Failed to create PDF context")
        return
    }
    
    // Get the size of the PNG image
    let imageSize = pngImage.size
    
    // Start a new PDF page
    UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height), nil)
    
    // Draw the PNG image onto the PDF context
    pngImage.draw(at: CGPoint.zero)
    
    // End the PDF context
    UIGraphicsEndPDFContext()
    
    print("Successfully created PDF file at \(outputFilePath)")
}

func convertPNGtoJPEG(pngImage: UIImage, outputFilePath: String, compressionQuality: CGFloat) {
    // Convert PNG image to JPEG data
    guard let jpegData = pngImage.jpegData(compressionQuality: compressionQuality) else {
        print("Failed to convert PNG to JPEG")
        return
    }
    
    // Write JPEG data to file
    do {
        try jpegData.write(to: URL(fileURLWithPath: outputFilePath))
        print("Successfully wrote JPEG file to \(outputFilePath)")
    } catch {
        print("Failed to write JPEG file: \(error)")
    }
}

func convertPNGtoGIF(pngImage: UIImage, outputFilePath: String) {
    guard let gifData = UIImageAnimatedGifRepresentation(pngImage) else {
        print("Failed to convert PNG to GIF")
        return
    }
    
    // Write GIF data to file
    do {
        try gifData.write(to: URL(fileURLWithPath: outputFilePath))
        print("Successfully wrote GIF file to \(outputFilePath)")
    } catch {
        print("Failed to write GIF file: \(error)")
    }
}

func UIImageAnimatedGifRepresentation(_ image: UIImage) -> Data? {
    guard let cgImage = image.cgImage else {
        print("Failed to get CGImage from UIImage")
        return nil
    }
    
    let destinationData = NSMutableData()
    guard let destination = CGImageDestinationCreateWithData(destinationData, kUTTypeGIF, 1, nil) else {
        print("Failed to create destination for GIF data")
        return nil
    }
    
    let frameProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: 0.0]]
    let gifProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 0]]
    
    CGImageDestinationAddImage(destination, cgImage, frameProperties as CFDictionary)
    CGImageDestinationSetProperties(destination, gifProperties as CFDictionary)
    
    guard CGImageDestinationFinalize(destination) else {
        print("Failed to finalize GIF data")
        return nil
    }
    
    return destinationData as Data
}

// Helper function to write little-endian data
func appendLittleEndian<T>(_ value: T, to data: inout Data) {
    var value = value
    let valuePointer = withUnsafePointer(to: &value) {
        return $0.withMemoryRebound(to: UInt8.self, capacity: MemoryLayout<T>.size) {
            return UnsafeBufferPointer(start: $0, count: MemoryLayout<T>.size)
        }
    }
    data.append(valuePointer)
}

// Function to convert PNG to EXR
func convertPngToExr(pngImage: UIImage, outputFilePath: String) throws {
    guard let cgImage = pngImage.cgImage else {
        throw NSError(domain: "ImageConversionError", code: 1, userInfo: ["message": "Failed to get CGImage from UIImage"])
    }

    let width = cgImage.width
    let height = cgImage.height
    let bitsPerComponent = 8
    let bytesPerPixel = 4  // 4 bytes per pixel for RGBA
    let bytesPerRow = bytesPerPixel * width
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue

    guard let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: bitsPerComponent,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: bitmapInfo
    ) else {
        throw NSError(domain: "ImageConversionError", code: 2, userInfo: ["message": "Failed to create CGContext"])
    }

    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

    guard let pixelData = context.data else {
        throw NSError(domain: "ImageConversionError", code: 3, userInfo: ["message": "Failed to get pixel data from CGContext"])
    }

    // Convert pixel data to float values for EXR
    let pixelBuffer = pixelData.bindMemory(to: UInt8.self, capacity: height * bytesPerRow)
    var floatPixels: [Float] = []
    for y in 0..<height {
        for x in 0..<width {
            let offset = (y * bytesPerRow) + (x * bytesPerPixel)
            let r = Float(pixelBuffer[offset + 0]) / 255.0
            let g = Float(pixelBuffer[offset + 1]) / 255.0
            let b = Float(pixelBuffer[offset + 2]) / 255.0
            let a = Float(pixelBuffer[offset + 3]) / 255.0
            floatPixels.append(r)
            floatPixels.append(g)
            floatPixels.append(b)
            floatPixels.append(a)
        }
    }

    // Create EXR file (This is a simplified example. Real-world EXR creation involves more headers and metadata)
    var exrData = Data()

    // Magic number (according to OpenEXR format)
    let magicNumber: UInt32 = 20000630
    appendLittleEndian(magicNumber, to: &exrData)

    // Version field
    let version: UInt32 = 2
    appendLittleEndian(version, to: &exrData)

    // Add header information (simplified)
    // ...
    // Here you should add required EXR headers like channel information, compression type, etc.
    // Refer to the OpenEXR documentation for full details

    // Add pixel data
    floatPixels.withUnsafeBufferPointer { bufferPointer in
        if let baseAddress = bufferPointer.baseAddress {
            let dataPointer = UnsafeRawPointer(baseAddress).assumingMemoryBound(to: UInt8.self)
            exrData.append(dataPointer, count: floatPixels.count * MemoryLayout<Float>.size)
        }
    }

    // Write EXR file
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let outputURL = documentsDirectory.appendingPathComponent(outputFilePath)

    try FileManager.default.createDirectory(at: outputURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
    try exrData.write(to: outputURL)
    print("Successfully wrote EXR file to \(outputURL.path)")
    
}


func convertPngToIco(pngImage: UIImage, outputFilePath: String) throws {
    guard let cgImage = pngImage.cgImage else {
        throw NSError(domain: "ImageConversionError", code: 1, userInfo: ["message": "Failed to get CGImage from UIImage"])
    }

    let width = cgImage.width
    let height = cgImage.height
    let bitsPerComponent = 8
    let bytesPerPixel = 4  // RGBA
    let bytesPerRow = bytesPerPixel * width
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue

    guard let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: bitsPerComponent,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: bitmapInfo
    ) else {
        throw NSError(domain: "ImageConversionError", code: 2, userInfo: ["message": "Failed to create CGContext"])
    }

    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

    guard let pixelData = context.data else {
        throw NSError(domain: "ImageConversionError", code: 3, userInfo: ["message": "Failed to get pixel data from CGContext"])
    }

    let data = Data(bytes: pixelData, count: height * bytesPerRow)

    // ICO file header
    var icoData = Data()

    // ICONDIR structure (6 bytes)
    icoData.append(contentsOf: [0x00, 0x00]) // Reserved (2 bytes)
    icoData.append(contentsOf: [0x01, 0x00]) // Image type (1 for icons, 2 for cursors) (2 bytes)
    icoData.append(contentsOf: [0x01, 0x00]) // Number of images (1 in this case) (2 bytes)

    // ICONDIRENTRY structure (16 bytes)
    icoData.append(UInt8(width)) // Width (1 byte)
    icoData.append(UInt8(height)) // Height (1 byte)
    icoData.append(0) // Color palette (0 means no palette) (1 byte)
    icoData.append(0) // Reserved (1 byte)
    icoData.append(contentsOf: [0x01, 0x00]) // Color planes (2 bytes)
    icoData.append(contentsOf: [0x20, 0x00]) // Bits per pixel (32 in this case) (2 bytes)

    let imageDataSize = data.count
    let imageOffset = 22 // 6 + 16 bytes for headers

    icoData.append(contentsOf: UInt32(imageDataSize).littleEndianBytes) // Image data size (4 bytes)
    icoData.append(contentsOf: UInt32(imageOffset).littleEndianBytes) // Offset of the image data (4 bytes)

    // Write the PNG image data to ICO
    icoData.append(data)

    // Write ICO file
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let outputURL = documentsDirectory.appendingPathComponent(outputFilePath)

    try FileManager.default.createDirectory(at: outputURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
    try icoData.write(to: outputURL)
    print("Successfully wrote ICO file to \(outputURL.path)")
}
//
//extension FixedWidthInteger {
//    var littleEndianBytes: [UInt8] {
//        withUnsafeBytes(of: littleEndian, Array.init)
//    }
//}

func convertPNGtoODD(pngURL: URL, oddFileName: String) -> Bool {
    // Load the PNG image from the given URL
    guard let inputImage = UIImage(contentsOfFile: pngURL.path) else {
        print("Failed to load image from \(pngURL.path)")
        return false
    }

    // Get the image data
    guard let imageData = inputImage.pngData() else {
        print("Failed to get PNG data from image")
        return false
    }

    // Create ODD data from the image data
    guard let oddData = convertToODDData(image: inputImage) else {
        print("Failed to convert image to ODD data")
        return false
    }

    // Get the documents directory URL
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let oddURL = documentsDirectory.appendingPathComponent(oddFileName)

    // Save the ODD data to the output URL
    do {
        try oddData.write(to: oddURL)
        print("Successfully saved ODD to \(oddURL.path)")
        return true
    } catch {
        print("Failed to save ODD file: \(error)")
        return false
    }
}

func convertToODDData(image: UIImage) -> Data? {
    guard let cgImage = image.cgImage else {
        return nil
    }

    let width = cgImage.width
    let height = cgImage.height
    let bytesPerRow = width * 4
    var data = Data()

    // Example ODD header (custom format)
    data.append(UInt8(0x4F)) // 'O'
    data.append(UInt8(0x44)) // 'D'
    data.append(UInt8(0x44)) // 'D'
    data.append(UInt8(0x01)) // Version

    // Image dimensions
    data.append(UInt32(width).littleEndian.data)
    data.append(UInt32(height).littleEndian.data)

    // Image data
    guard let dataProvider = cgImage.dataProvider, let pixelData = dataProvider.data else {
        return nil
    }

    let pixels = CFDataGetBytePtr(pixelData)
    for y in 0..<height {
        for x in 0..<width {
            let pixelIndex = (y * bytesPerRow) + (x * 4)
            let r = pixels![pixelIndex]
            let g = pixels![pixelIndex + 1]
            let b = pixels![pixelIndex + 2]
            let a = pixels![pixelIndex + 3]
            data.append(contentsOf: [r, g, b, a])
        }
    }

    return data
}

extension FixedWidthInteger {
    var data1: Data {
        var value = self
        return Data(bytes: &value, count: MemoryLayout<Self>.size)
    }
}

enum ImageError: Error {
    case cgImageConversionFailed
    case cgContextCreationFailed
    case pixelDataExtractionFailed
    case fileWriteFailed
}

extension UIImage {
    func convertToOdd(outputFilePath: String) throws {
        guard let cgImage = self.cgImage else {
            throw ImageError.cgImageConversionFailed
        }

        let width = cgImage.width
        let height = cgImage.height
        let bitsPerComponent = 8
        let bytesPerPixel = 4  // Assuming RGBA
        let bytesPerRow = bytesPerPixel * width
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue

        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo
        ) else {
            throw ImageError.cgContextCreationFailed
        }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

        guard let pixelData = context.data else {
            throw ImageError.pixelDataExtractionFailed
        }

        let header = ODDHeader(width: UInt32(width), height: UInt32(height), bitsPerPixel: UInt32(bitsPerComponent * bytesPerPixel))
        let oddData = header.toData() + Data(bytesNoCopy: pixelData, count: height * bytesPerRow, deallocator: .none)

        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let outputURL = documentsDirectory.appendingPathComponent(outputFilePath)

        do {
            try oddData.write(to: outputURL)
            print("Successfully wrote ODD file to \(outputURL.path)")
        } catch {
            throw ImageError.fileWriteFailed
        }
    }
}

struct ODDHeader {
    let width: UInt32
    let height: UInt32
    let bitsPerPixel: UInt32

    func toData() -> Data {
        var data = Data()
        data.append(contentsOf: width.littleEndianBytes)
        data.append(contentsOf: height.littleEndianBytes)
        data.append(contentsOf: bitsPerPixel.littleEndianBytes)
        return data
    }
}
