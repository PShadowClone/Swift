//
//  ViewController.swift
//  FinalSwfitProject
//
//  Created by i219pc11 on 4/24/16.
//  Copyright © 2016 iug. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    var doneFlag = false
    var login:Login?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     prepareButtonDesign()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.handler(_:)), name: "login", object: nil)
       
    // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchBackground(sender: UITapGestureRecognizer) {
        phoneNumber.resignFirstResponder()
        password.resignFirstResponder()
    }
    @IBAction func CancelAction(sender: UIButton) {
        phoneNumber.text = ""
        password.text = ""
        
    }
    
    @IBAction func sgininAction(sender: AnyObject) {
       
        
        
        if phoneNumber.text == "" || password.text == ""
        {
            
            PrintMessage.alertMessages(self, title: "Warnning", message: "Missing Required fields, please fill all required fields ")
        }else{
       login = Login(phoneNumber: "\(phoneNumber.text!)" , password: "\(password.text!)")
        login!.login()
        }
        
        
    }
    
    private func prepareButtonDesign()
    {
        cancelButton.layer.cornerRadius = 5.0
        signinButton.layer.cornerRadius = 5.0
        let buttonTextColor = signinButton.titleLabel?.textColor;
        
        signinButton.layer.borderColor = buttonTextColor?.CGColor
        signinButton.layer.borderWidth = 2
        

        
    }
    
    
    
    func handler(notif : NSNotification) ->Void
    {
        
        if (notif.object!.isEqual(Constant.WRONG_VALIDATION) == false) &&   (notif.object!.isEqual(Constant.ERROR_MESSAGE) == false) {
        
        let mainViewController  = self.storyboard!.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        self.presentViewController(mainViewController, animated: true, completion: nil)
            
            NSNotificationCenter.defaultCenter().removeObserver(self)
            print("######$$#$#$#$#$#$#$")
        
        }else
        {
            PrintMessage.alertMessages(self, title: "Warnning", message: notif.object as! String)
            password.text = ""
        }
        
        
    }

}

