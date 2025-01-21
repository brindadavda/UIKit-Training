//
//  CameraViewController.swift
//  instagramClone
//
//  Created by apple on 15/01/24.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    //MARK:- Vars
    var captureSession : AVCaptureSession!
    
    
    var backCamera : AVCaptureDevice!
    var frontCamera : AVCaptureDevice!
    var backInput : AVCaptureInput!
    var frontInput : AVCaptureInput!
  
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //setupAndStartCaptureSession()
    }
    
    //MARK:- Camera Setup
    func setupAndStartCaptureSession(){
           DispatchQueue.global(qos: .userInitiated).async{
               //init session
               self.captureSession = AVCaptureSession()
               //start configuration
               self.captureSession.beginConfiguration()
               
               //session specific configuration
               if self.captureSession.canSetSessionPreset(.photo) {
                   self.captureSession.sessionPreset = .photo
               }
               self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
               
               //setup inputs
               self.setupInputs()
               
               //commit configuration
               self.captureSession.commitConfiguration()
               //start running it
               self.captureSession.startRunning()
           }
       }
       
       func setupInputs(){
           //get back camera
           if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
               backCamera = device
           } else {
               //handle this appropriately for production purposes
               fatalError("no back camera")
           }
           
           //get front camera
           if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
               frontCamera = device
           } else {
               fatalError("no front camera")
           }
           
           //now we need to create an input objects from our devices
           guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
               fatalError("could not create input device from back camera")
           }
           backInput = bInput
           if !captureSession.canAddInput(backInput) {
               fatalError("could not add back camera input to capture session")
           }
           
           guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
               fatalError("could not create input device from front camera")
           }
           frontInput = fInput
           if !captureSession.canAddInput(frontInput) {
               fatalError("could not add front camera input to capture session")
           }
           
           //connect back camera input to session
           captureSession.addInput(backInput)
       }
       
    
    func setupPreviewLayer(){
           let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            //view.layer.insertSublayer(previewLayer, below: switchCameraButton.layer)
            previewLayer.frame = self.view.layer.frame
        }

    
    func setupOutput(){
        let videoOutput = AVCaptureVideoDataOutput()
        let videoQueue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)

        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        } else {
            fatalError("could not add video output")
        }
        
        //deal with the orientation
        videoOutput.connections.first?.videoOrientation = .portrait
    }


}


