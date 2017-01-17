//
//  TradersViewController.swift
//  FinalSwfitProject
//
//  Created by i219pc11 on 5/3/16.
//  Copyright © 2016 iug. All rights reserved.
//


import UIKit

class TradersViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    var showTrader:ShowTraders?
    var traders:NSDictionary?
     let simpleTableIdentifier = "SimpleTableIdentifier"
    
    
    @IBOutlet weak var tradersTableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.handler(_:)), name: "traders", object: nil)
        
        showTrader = ShowTraders()
        showTrader?.fetchAllTraders()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return traders == nil ? 0: traders!.count
    }
    
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TraderCell", forIndexPath: indexPath) as! TraderCustomCellTable
        
      cell.traderImage.image = UIImage(named:"TraderIcon")
       cell.traderName.text = traders!.allValues[indexPath.row]["trader"]!!["FirstName"]!! as! String
       cell.traderPhoneNumber.text  = "Phone Number : \(traders!.allValues[indexPath.row]["trader"]!!["Mobile"]!! as! String)"
        
//
//        cell?.trderImage.image =         cell?.textLabel?.text = traders!.allValues[indexPath.row]["trader"]!!["FirstName"]!! as! String
//        cell?.detailTextLabel?.text = "Phone Number : \(traders!.allValues[indexPath.row]["trader"]!!["Mobile"]!! as! String)"
        return cell
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
         
    func handler (notification : NSNotification) ->Void
    {
        
       if (notification.object!.isEqual(Constant.EMPTY_TRADER_LIST) == false) &&   (notification.object!.isEqual(Constant.ERROR_MESSAGE) == false) {
        print(notification.object)
            traders = notification.object as! NSDictionary
            self.tradersTableView.reloadData()
    
        print("\(traders!.allValues[1]["trader"])")
       }else
       {
        PrintMessage.alertMessages(self, title: "Warning", message: Constant.EMPTY_TRADER_LIST)
        }
    }
}
