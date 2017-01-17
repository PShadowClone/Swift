//
//  BarcodeViewController.swift
//  FinalSwfitProject
//
//  Created by i219pc11 on 5/3/16.
//  Copyright © 2016 iug. All rights reserved.
//

import AVFoundation
import UIKit



class BarcodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    var barcodeNumber:String?
    var numberOfSales:Int8 = 1
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var productName: UITextField!
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var barcodeOperation:BarcodeOperation?
    
    @IBOutlet weak var productPrice: UITextField!
    
    @IBOutlet weak var productAmount: UITextField!
    override func viewDidLoad() {
               super.viewDidLoad()
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BarcodeViewController.handler(_:)), name: "barcode", object: nil)
        
        barcodeOperation = BarcodeOperation()
        //barcodeOperation?.fetchProductDetails("5555555555")
        notificationImage.hidden = true
        notificationLabel.hidden = true
        

        //view.backgroundColor = UIColor.blackColor()
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypePDF417Code]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
//
//        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logoutAction(sender: AnyObject) {
        
        if Logout.logout() == true
        {
            let login = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as? ViewController
            self.presentViewController(login!, animated: true, completion: nil)
        }else
        {
            PrintMessage.alertMessages(self, title: "Warnning", message: "Something went wrong during logout, please try again")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        captureSession = nil
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.running == true) {
            captureSession.stopRunning();
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            foundCode(readableObject.stringValue);
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    func foundCode(code: String) {
        self.barcodeNumber = code
         barcodeOperation?.fetchProductDetails(code)
        print("Barcode Number is \(code)")
    }
    
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    func handler (notification : NSNotification) ->Void
    {
        if (notification.object!.isEqual(Constant.PRODUCT_NOT_FOUND) == false) &&   (notification.object!.isEqual(Constant.ERROR_MESSAGE) == false)
        {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(BarcodeViewController.finish(_:)), name: "barcode2", object: nil)
            let runBarcode:RunBarcode? = RunBarcode()
            runBarcode?.SaleDone(self.barcodeNumber!)

             print("\(notification.object)")
            let traders = notification.object as! NSDictionary
            barcodeShowOperation(traders.allValues[0]["product"]!!["Name"] as! String , price: traders.allValues[0]["product"]!!["SingleUnitPrice"] as! String)
            //self.tradersTableView.reloadData()
            
           
        }else
        {
            PrintMessage.alertMessages(self, title: "Warning", message: Constant.PRODUCT_NOT_FOUND)
        }
    }
    
    func barcodeShowOperation(name:String , price:String)
    {
        productName.text = name
        productName.enabled = false
        productPrice.text = price
        productPrice.enabled = false
            }

    func finish (notification : NSNotification) ->Void
    {
        if (notification.object!.isEqual(Constant.PRODUCT_NOT_FOUND) == false) &&   (notification.object!.isEqual(Constant.ERROR_MESSAGE) == false)
        {
            notificationImage.hidden = false
            notificationLabel.hidden = false
            numberOfSales = numberOfSales+1

        }else
        {
            PrintMessage.alertMessages(self, title: "Warning", message: Constant.PRODUCT_NOT_FOUND)
        }
    }

    
}
