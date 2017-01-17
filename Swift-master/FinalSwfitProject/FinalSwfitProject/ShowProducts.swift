//
//  ShowProducts.swift
//  FinalSwfitProject
//
//  Created by i319mac4 on 5/26/16.
//  Copyright © 2016 iug. All rights reserved.
//

import UIKit

class ShowProducts {
    
    private var method : String?
    private var inputURL:String?
    private var urlPath:String?
    private var ShopID : String?
    private var shopID : String?
    
    init(){
        self.urlPath = "http://localhost:80/API-SWIFT/scripts/listOfProduct.php";
        self.method = "POST";
        self.ShopID = self.returnShopId()
        print("shopID = \(shopID)")
        self.inputURL = "shopid=\(ShopID!)"
    }
    
    func returnShopId() -> String
    {
        
        let directory = NSTemporaryDirectory()
        let temporaryPath = NSURL(fileURLWithPath: directory)
        let temporaryFile = temporaryPath.URLByAppendingPathComponent(Constant.FILE_NAME)
        //let path = NSBundle.mainBundle().pathForResource("userInfo", ofType: "plist")
        let file  = NSDictionary(contentsOfURL: temporaryFile)
        
        return "\(file!["shopID"]!)"
        
    }
    
    func getListOfProduct(){
        
        let url = NSURL(string: self.urlPath!);
        let request = NSMutableURLRequest(URL:url!)
        request.HTTPMethod = self.method!
        request.HTTPBody = inputURL!.dataUsingEncoding(NSUTF8StringEncoding)
        
        var userDetails:NSDictionary? = NSDictionary()
        
        NSURLSession.sharedSession().dataTaskWithRequest(request){ (data :NSData?, response: NSURLResponse?,error: NSError?) in
            
            
            dispatch_async(dispatch_get_main_queue()){
                
                
                if error != nil
                {
                    self.NSNotificationMessage(Constant.ERROR_MESSAGE)
                }
                
                
                
                do{
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)as? NSDictionary
                    
                    
                    print("%%%%%%%%%%%%%%\(json)")
                    
                    if "\(json!["status"]!)" == "200" {
                        
                        userDetails! = json! as NSDictionary
                        let temp  = userDetails! as! NSMutableDictionary
                        temp.removeObjectForKey("status")
                        self.NSNotificationMessage(userDetails!)
                        
                        
                        
                        // self.saveTempInfoInPlistFile(userDetails!)
                        self.NSNotificationMessage(userDetails!)
                        
                        
                    }else
                    {
                        self.NSNotificationMessage(Constant.WRONG_VALIDATION)
                    }
                    
                    
                    
                    
                }catch
                {
                    print("erorr is \(error) ")
                    self.NSNotificationMessage(Constant.ERROR_MESSAGE)
                    
                    
                    
                }
                
            }
            
            
            }.resume()
        
        
    }
    
    private func saveTempInfoInPlistFile(dictionary : NSDictionary)
    {
        
        
        let tempDirectory = NSTemporaryDirectory()
        let tempPath = NSURL(fileURLWithPath: tempDirectory)
        let tempURL = tempPath.URLByAppendingPathComponent("userInfo.pilst")
        dictionary.writeToURL(tempURL, atomically: true)
        
    }
    
    
    private func NSNotificationMessage(message : NSObject)
    {
        NSNotificationCenter.defaultCenter().postNotificationName("products",object: message)
    }
    
}