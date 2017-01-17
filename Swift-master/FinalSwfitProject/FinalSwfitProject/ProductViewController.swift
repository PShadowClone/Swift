import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var showProduct:ShowProducts?
    
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
    @IBOutlet weak var productTableView: UITableView!
    
    var products:NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.handler(_:)), name: "products", object: nil)
        
        showProduct = ShowProducts()
        showProduct?.getListOfProduct()
        
        // Do any additional setup after loading the view.
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
    
    func tableView(tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return products == nil ? 0:products!.count
    }
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productCell", forIndexPath: indexPath) as! ProductCustomCellTable
        
        cell.productImage.image = UIImage(named: "productIcon")
        cell.productName.text = products!.allValues[indexPath.row]["product"]!!["Name"] as? String
        cell.QProduct.text = "Ammount : \(products!.allValues[indexPath.row]["product"]!!["WholeQuantity"]!! as! String)"
        
        /*
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.Default,
                reuseIdentifier: simpleTableIdentifier)
        }
        if indexPath.row == 0
        {
            cell?.textLabel?.text = ""
            return cell!
        }
        cell?.textLabel?.text = products!.allValues[indexPath.row]["product"]!!["Name"] as? String
 */
        return cell
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
        if ((notification.object?.isEqual(Constant.ERROR_MESSAGE)) != nil)
        {
            products = notification.object as? NSDictionary
            self.productTableView.reloadData()
        }
    }
    
}