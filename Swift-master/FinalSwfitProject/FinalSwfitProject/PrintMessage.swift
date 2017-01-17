//
//  PrintMessage.swift
//  FinalSwfitProject
//
//  Created by i219pc11 on 5/2/16.
//  Copyright © 2016 iug. All rights reserved.
//

import UIKit

class PrintMessage {
    
    
    static func alertMessages(controller:UIViewController ,title : String , message :String )-> Void
    {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle:.Alert)
        let buttons = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alert.addAction(buttons)
        controller.presentViewController(alert, animated: true, completion: nil)
        
        
    }

}
