
//
//  DetailViewController.swift
//  swipeforce
//
//  Created by Carlos Cheung on 6/13/15.
//  Copyright (c) 2015 carloscheung. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var passName: String!
    var passPhoto: UIImage!
    var passColor: UIColor!
    var passBackgroundImage: UIImage!
    var passBackgroundImageOverlay: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backgroundImageOverlay: UIView!
    
    @IBOutlet weak var personalInfoCard: UIView!
    @IBOutlet weak var personalInfoPanel: UIView!
    @IBOutlet weak var leadInfoPanel: UIView!
    @IBOutlet weak var contactInfoPanel: UIView!

    @IBOutlet weak var actionButtonsView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    weak var mainCardViewController: MainCardViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSizeMake(320, 800)
        
        var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = backgroundImageOverlay.bounds
        backgroundImageOverlay.addSubview(blurView)
        
//        self.nameLabel.alpha = 0
//        self.photoImage.alpha = 0
//        self.personalInfoPanel.alpha = 0
//        self.leadInfoPanel.alpha = 0
//        self.contactInfoPanel.alpha = 0
        
        nameLabel.text = passName
        photoImage.image = passPhoto
        cardBackgroundView.backgroundColor = passColor
        backgroundImage.image = passBackgroundImage
        backgroundImageOverlay.backgroundColor = passBackgroundImageOverlay.backgroundColor
        
        photoImage.layer.borderWidth = 3.0
        photoImage.layer.masksToBounds = false
        photoImage.layer.borderColor = UIColor.whiteColor().CGColor
        photoImage.layer.cornerRadius = self.photoImage.frame.size.width / 2
        photoImage.clipsToBounds = true
        
        createGradient(view: actionButtonsView)
        
        personalInfoCard.layer.cornerRadius  = 10.0
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//            UIView.animateWithDuration(0.05, delay: 0, options: nil, animations: { () -> Void in
//                self.photoImage.center.y = 118
//                self.photoImage.alpha = 1
//                self.nameLabel.center.y = 184
//                self.nameLabel.alpha = 1
//                self.personalInfoPanel.center.y = 324
//                self.personalInfoPanel.alpha = 1
//                self.leadInfoPanel.center.y = 444
//                self.leadInfoPanel.alpha = 1
//                self.contactInfoPanel.center.y = 600
//                self.contactInfoPanel.alpha = 1
//                }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGradient(view aView: UIView) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRectMake(0.0, 0.0, aView.frame.size.width, aView.frame.size.height)
        gradient.colors = [UIColor(red: 0.0/255.0, green: 0.0/255.0, blue:   0.0/255.0, alpha: 0.0).CGColor, UIColor(red: 0.0/255.0, green: 0.0/255.0,   blue: 0.0/255.0, alpha: 0.5).CGColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        aView.layer.insertSublayer(gradient, atIndex:0)
    }
    
    @IBAction func onTapDone(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onTapAccept(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
        self.mainCardViewController.onTapAccept(sender)
        })
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
