//
//  ListViewController.swift
//  SwipeForce_List
//
//  Created by June Lim on 6/14/15.
//  Copyright (c) 2015 June Lim. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var acceptedView: UIView!
    @IBOutlet weak var rejectedView: UIView!
    @IBOutlet weak var laterView: UIView!
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectedButton: UIButton!
    
    @IBOutlet weak var laterWhiteIcon: UIImageView!
    @IBOutlet weak var laterOrangeIcon: UIImageView!
    @IBOutlet weak var acceptWhiteIcon: UIImageView!
    @IBOutlet weak var acceptGreenIcon: UIImageView!
    @IBOutlet weak var rejectRedIcon: UIImageView!
    @IBOutlet weak var rejectWhiteIcon: UIImageView!
    
    var listSelect: Int!
    var namesLater = ["June Lim", "Eddie Le Breton", "Dan Adair", "Pawan Gaargi", "Jon Liak"]
    var titlesLater = ["Lead PM", "GM", "PM", "Lead PM", "PM"]
    var companiesLater = ["Zynga","Zynga","Zynga","Zynga","Zynga"]
    var namesAccepted = ["Carlos", "Nan", "Tim"]
    var titlesAccepted = ["Engineer", "Designer", "Engineer"]
    var companiesAccepted = ["Optimizely","Unknown","CodePath"]
    var namesRejected = ["Posey", "Bumgarner", "Aoki", "Romo"]
    var titlesRejected = ["Catcher", "Pitcher", "Hitter", "Pitcher"]
    var companiesRejected = ["SF Giants","SF Giants","SF Giants","SF Giants"]
    var listSelectGlobal = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        // Set default list as Later
        listSelect = 1
        listSelectGlobal.setInteger(listSelect, forKey: "list")
        listSelectGlobal.synchronize()
        
        laterButton.setTitleColor(UIColor(white: 1, alpha: 1), forState: nil)
        laterView.backgroundColor = UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: 1)
        acceptedView.backgroundColor = UIColor(red: 0.16, green: 0.7, blue: 0.48, alpha: 0.1)
        rejectedView.backgroundColor = UIColor(red: 0.76, green: 0.35, blue: 0.46, alpha: 0.1)
        laterOrangeIcon.alpha = 0
        acceptWhiteIcon.alpha = 0
        rejectWhiteIcon.alpha = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listSelect == 1 {
            return self.namesLater.count
        } else if listSelect == 2 {
            return self.namesAccepted.count
        } else {
            return self.namesRejected.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("ListCell") as! ListCell
        
        if listSelect == 1 {
            cell.nameLabel.text = namesLater[indexPath.row]
            cell.titleLabel.text = titlesLater[indexPath.row]
            cell.companyLabel.text = companiesLater[indexPath.row]
        } else if listSelect == 2 {
            cell.nameLabel.text = namesAccepted[indexPath.row]
            cell.titleLabel.text = titlesAccepted[indexPath.row]
            cell.companyLabel.text = companiesAccepted[indexPath.row]
        } else {
            cell.nameLabel.text = namesRejected[indexPath.row]
            cell.titleLabel.text = titlesRejected[indexPath.row]
            cell.companyLabel.text = companiesRejected[indexPath.row]
        }
        
        cell.listViewController = self
        return cell
    }
    
    // Remove from Later and Add to Accepted
    func archiveContact(cell: UITableViewCell) {
        var indexPath = listTableView.indexPathForCell(cell)!.row
        namesAccepted.append(namesLater[indexPath])
        titlesAccepted.append(titlesLater[indexPath])
        companiesAccepted.append(companiesLater[indexPath])
        namesLater.removeAtIndex(indexPath)
        titlesLater.removeAtIndex(indexPath)
        companiesLater.removeAtIndex(indexPath)
        self.listTableView.reloadData()
    }
    
    // Remove from Later to Add to Rejected
    func removeContact(cell: UITableViewCell) {
        var indexPath = listTableView.indexPathForCell(cell)!.row
        namesRejected.append(namesLater[indexPath])
        titlesRejected.append(titlesLater[indexPath])
        companiesRejected.append(companiesLater[indexPath])
        namesLater.removeAtIndex(indexPath)
        titlesLater.removeAtIndex(indexPath)
        companiesLater.removeAtIndex(indexPath)
        self.listTableView.reloadData()
    }
    
    // Remove from Accepted and Add to Later
    func acceptedToLater(cell: UITableViewCell) {
        var indexPath = listTableView.indexPathForCell(cell)!.row
        namesLater.append(namesAccepted[indexPath])
        titlesLater.append(titlesAccepted[indexPath])
        companiesLater.append(companiesAccepted[indexPath])
        namesAccepted.removeAtIndex(indexPath)
        titlesAccepted.removeAtIndex(indexPath)
        companiesAccepted.removeAtIndex(indexPath)
        self.listTableView.reloadData()
    }
    
    // Remove from Accepted and Add to Later
    func acceptedToRejected(cell: UITableViewCell) {
        var indexPath = listTableView.indexPathForCell(cell)!.row
        namesRejected.append(namesAccepted[indexPath])
        titlesRejected.append(titlesAccepted[indexPath])
        companiesRejected.append(companiesAccepted[indexPath])
        namesAccepted.removeAtIndex(indexPath)
        titlesAccepted.removeAtIndex(indexPath)
        companiesAccepted.removeAtIndex(indexPath)
        self.listTableView.reloadData()
    }
    
    // Remove from Rejected and Add to Later
    func rejectedToLater(cell: UITableViewCell) {
        var indexPath = listTableView.indexPathForCell(cell)!.row
        namesLater.append(namesRejected[indexPath])
        titlesLater.append(titlesRejected[indexPath])
        companiesLater.append(companiesRejected[indexPath])
        namesRejected.removeAtIndex(indexPath)
        titlesRejected.removeAtIndex(indexPath)
        companiesRejected.removeAtIndex(indexPath)
        self.listTableView.reloadData()
    }
    
    // Remove from Rejected and Add to Accepted
    func rejectedToAccepted(cell: UITableViewCell) {
        var indexPath = listTableView.indexPathForCell(cell)!.row
        namesAccepted.append(namesRejected[indexPath])
        titlesAccepted.append(titlesRejected[indexPath])
        companiesAccepted.append(companiesRejected[indexPath])
        namesRejected.removeAtIndex(indexPath)
        titlesRejected.removeAtIndex(indexPath)
        companiesRejected.removeAtIndex(indexPath)
        self.listTableView.reloadData()
    }
    
    
    // Button Actions for selecting the menu
    @IBAction func acceptedButtonTap(sender: AnyObject) {
        listSelect = 2
        listSelectGlobal.setInteger(listSelect, forKey: "list")
        listSelectGlobal.synchronize()
        self.listTableView.reloadData()
        acceptButton.setTitleColor(UIColor(white: 1, alpha: 1), forState: nil)
        laterButton.setTitleColor(UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: 1), forState: nil)
        rejectedButton.setTitleColor(UIColor(red: 0.76, green: 0.35, blue: 0.46, alpha: 1), forState: nil)
        laterView.backgroundColor = UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: 0.1)
        acceptedView.backgroundColor = UIColor(red: 0.16, green: 0.7, blue: 0.48, alpha: 1)
        rejectedView.backgroundColor = UIColor(red: 0.76, green: 0.35, blue: 0.46, alpha: 0.1)
        laterOrangeIcon.alpha = 1
        laterWhiteIcon.alpha = 0
        acceptGreenIcon.alpha = 0
        acceptWhiteIcon.alpha = 1
        rejectRedIcon.alpha = 1
        rejectWhiteIcon.alpha = 0
    }
    
    @IBAction func laterButtonTap(sender: AnyObject) {
        listSelect = 1
        listSelectGlobal.setInteger(listSelect, forKey: "list")
        listSelectGlobal.synchronize()
        self.listTableView.reloadData()
        laterButton.setTitleColor(UIColor(white: 1, alpha: 1), forState: nil)
        acceptButton.setTitleColor(UIColor(red: 0.16, green: 0.7, blue: 0.48, alpha: 1), forState: nil)
        rejectedButton.setTitleColor(UIColor(red: 0.76, green: 0.35, blue: 0.46, alpha: 1), forState: nil)
        laterView.backgroundColor = UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: 1)
        acceptedView.backgroundColor = UIColor(red: 0.16, green: 0.7, blue: 0.48, alpha: 0.1)
        rejectedView.backgroundColor = UIColor(red: 0.76, green: 0.35, blue: 0.46, alpha: 0.1)
        laterOrangeIcon.alpha = 0
        laterWhiteIcon.alpha = 1
        acceptGreenIcon.alpha = 1
        acceptWhiteIcon.alpha = 0
        rejectRedIcon.alpha = 1
        rejectWhiteIcon.alpha = 0
    }
    
    @IBAction func rejectedButtonTap(sender: AnyObject) {
        listSelect = 0
        listSelectGlobal.setInteger(listSelect, forKey: "list")
        listSelectGlobal.synchronize()
        self.listTableView.reloadData()
        rejectedButton.setTitleColor(UIColor(white: 1, alpha: 1), forState: nil)
        acceptButton.setTitleColor(UIColor(red: 0.16, green: 0.7, blue: 0.48, alpha: 1), forState: nil)
        laterButton.setTitleColor(UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: 1), forState: nil)
        laterView.backgroundColor = UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: 0.1)
        acceptedView.backgroundColor = UIColor(red: 0.16, green: 0.7, blue: 0.48, alpha: 0.1)
        rejectedView.backgroundColor = UIColor(red: 0.76, green: 0.35, blue: 0.46, alpha: 1)
        laterOrangeIcon.alpha = 1
        laterWhiteIcon.alpha = 0
        acceptGreenIcon.alpha = 1
        acceptWhiteIcon.alpha = 0
        rejectRedIcon.alpha = 0
        rejectWhiteIcon.alpha = 1
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
