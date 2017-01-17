//
//  Logout.swift
//  FinalSwfitProject
//
//  Created by i219pc11 on 5/3/16.
//  Copyright © 2016 iug. All rights reserved.
//

import UIKit

class Logout {
    
    static func logout() -> Bool
    {
        let tempDirectory = NSTemporaryDirectory()
        let tempPath = NSURL(fileURLWithPath: tempDirectory)
        let tempURL = tempPath.URLByAppendingPathComponent(Constant.FILE_NAME)
        print(tempURL)
        do{
        let fileManage = NSFileManager.defaultManager()
        try fileManage.removeItemAtURL(tempURL)
            return true
        
        }catch
        {
            
            return false
        }
        
    }

}
