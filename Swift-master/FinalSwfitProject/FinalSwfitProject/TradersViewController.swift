//
//  TradersViewController.swift
//  FinalSwfitProject
//
//  Created by i219pc11 on 5/3/16.
//  Copyright © 2016 iug. All rights reserved.
//

import UIKit

class TradersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var showTrader:ShowTraders?
    var traders:NSDictionary?
    

    @IBOutlet weak var progressBar: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.handler(_:)), name: "traders", object: nil)
        
        showTrader = ShowTraders()
        showTrader?.fetchAllTraders()
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView,
                s   numberOfRowsInSection section: Int) -> Int {
        return traders!.count
    }

    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(tableTable)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.Default,
                reuseIdentifier: tableTable)
        }
        cell?.textLabel?.text = traders![indexPath.row]!["FirstName"]
        return cell!
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

    
//    func handler (notification : NSNotification) ->Void
//    {
//        if notification.object as! String == Constant.ERROR_MESSAGE
//        {
//            traders = notification.object as! NSDictionary
//        }
//    }
}
