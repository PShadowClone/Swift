//
//  StrategyClass.swift
//  FinalSwfitProject
//
//  Created by i219pc11 on 5/28/16.
//  Copyright © 2016 iug. All rights reserved.
//

import UIKit

protocol StrategyClass{
    func fetchAllTraders()
    func fetchProductDetails(barcodeNumber:String)
    func SaleDone(barcodeNumber:String)

}
