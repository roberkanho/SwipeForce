//
//  ListCell.swift
//  SwipeForce_List
//
//  Created by June Lim on 6/14/15.
//  Copyright (c) 2015 June Lim. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var acceptIcon: UIImageView!
    @IBOutlet weak var rejectIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    
    // required to interact with ListViewController
    weak var listViewController: ListViewController!
    
    var originalLoc: CGPoint!
    var originalCellBackgroundLoc: CGPoint!
    var originalAcceptIcon: CGPoint!
    var originalRejectIcon: CGPoint!
    var originalLaterIcon: CGPoint!
    var listSelectGlobal = NSUserDefaults.standardUserDefaults()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // add a pan recognizer
        var recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
        
        // record original location
        originalLoc = self.center
        originalCellBackgroundLoc = cellBackgroundView.center
        originalAcceptIcon = acceptIcon.center
        originalRejectIcon = rejectIcon.center
        originalLaterIcon = laterIcon.center
        
        
    }
    
    // Conditions for different state of Pan
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        var translation = recognizer.translationInView(self)
        var listSelect = listSelectGlobal.integerForKey("list")
        
        if listSelect == 1 {
            
            if recognizer.state == UIGestureRecognizerState.Began {
                
                acceptIcon.alpha = 0
                rejectIcon.alpha = 0
                laterIcon.alpha = 0
                
            } else if recognizer.state == UIGestureRecognizerState.Changed {
                
                self.center.x = originalLoc.x + translation.x
                if translation.x < -10 {
                    self.rejectIcon.alpha = translation.x / -100
                    self.acceptIcon.alpha = 0
                    self.cellBackgroundView.center.x = self.originalCellBackgroundLoc.x
                    self.cellBackgroundView.backgroundColor =
                        UIColor(red:0.76, green:0.35, blue:0.46, alpha:translation.x / -100)
                } else if translation.x > 10 {
                    self.rejectIcon.alpha = 0
                    self.acceptIcon.alpha = translation.x / 100
                    self.cellBackgroundView.center.x = self.originalCellBackgroundLoc.x - 640
                    self.cellBackgroundView.backgroundColor = UIColor(red: 0.16, green: 0.7, blue: 0.48, alpha: translation.x / 100)
                }
                
            } else if recognizer.state == UIGestureRecognizerState.Ended {
                
                if translation.x < -100 {
                    UIView.animateWithDuration(0.6, animations: { () -> Void in
                        self.center.x = self.originalLoc.x - 320
                    })
                    var timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("panLtoR"), userInfo: nil, repeats: false)
                    
                } else if translation.x >= -100 && translation.x < 100 {
                    self.center.x = self.originalLoc.x
                    
                    
                } else if translation.x >= 100 {
                    UIView.animateWithDuration(0.6, animations: { () -> Void in
                        self.center.x = self.originalLoc.x + 320
                    })
                    var timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("panLtoA"), userInfo: nil, repeats: false)
                }
            }
        } else if listSelect == 2 {
            if recognizer.state == UIGestureRecognizerState.Began {
                acceptIcon.alpha = 0
                rejectIcon.alpha = 0
                laterIcon.alpha = 0
                self.laterIcon.center.x = self.originalLaterIcon.x
            } else if recognizer.state == UIGestureRecognizerState.Changed {
                
                self.center.x = originalLoc.x + translation.x
                if translation.x < -150 {
                    self.rejectIcon.center.x = self.originalRejectIcon.x
                    self.rejectIcon.alpha = 1
                    self.laterIcon.alpha = 0
                    self.cellBackgroundView.center.x = self.originalCellBackgroundLoc.x
                    self.cellBackgroundView.backgroundColor =
                        UIColor(red:0.76, green:0.35, blue:0.46, alpha: 1)
                } else if translation.x < -10 {
                    self.rejectIcon.alpha = 0
                    self.laterIcon.alpha = translation.x / -100
                    self.cellBackgroundView.center.x = self.originalCellBackgroundLoc.x
                    self.cellBackgroundView.backgroundColor = UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: translation.x / -100)
                } else {
                    self.center.x = originalLoc.x
                }
                
            } else if recognizer.state == UIGestureRecognizerState.Ended {
                
                if translation.x < -150 {
                    UIView.animateWithDuration(0.6, animations: { () -> Void in
                        self.center.x = self.originalLoc.x - 320
                    })
                    var timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("panAtoR"), userInfo: nil, repeats: false)
                    
                } else if translation.x >= -150 && translation.x < -100 {
                    UIView.animateWithDuration(0.6, animations: { () -> Void in
                        self.center.x = self.originalLoc.x - 320
                    })
                    var timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("panAtoL"), userInfo: nil, repeats: false)
                    
                } else if translation.x > -100 {
                    self.center.x = self.originalLoc.x
                }
            }
        } else {
            if recognizer.state == UIGestureRecognizerState.Began {
                acceptIcon.alpha = 0
                rejectIcon.alpha = 0
                laterIcon.alpha = 0
                
            } else if recognizer.state == UIGestureRecognizerState.Changed {
                
                self.center.x = originalLoc.x + translation.x
                if translation.x > 150 {
                    self.acceptIcon.center.x = self.originalAcceptIcon.x
                    self.acceptIcon.alpha = 1
                    self.laterIcon.alpha = 0
                    self.cellBackgroundView.center.x = self.originalCellBackgroundLoc.x - 640
                    self.cellBackgroundView.backgroundColor =
                        UIColor(red:0.16, green:0.7, blue:0.48, alpha: 1)
                } else if translation.x > 10 {
                    self.acceptIcon.alpha = 0
                    self.laterIcon.center.x = self.originalLaterIcon.x + 225
                    self.laterIcon.alpha = translation.x / 100
                    self.cellBackgroundView.center.x = self.originalCellBackgroundLoc.x - 640
                    self.cellBackgroundView.backgroundColor = UIColor(red: 0.96, green: 0.65, blue: 0.14, alpha: translation.x / 100)
                } else {
                    self.center.x = originalLoc.x
                }
                
            } else if recognizer.state == UIGestureRecognizerState.Ended {
                
                if translation.x > 150 {
                    UIView.animateWithDuration(0.6, animations: { () -> Void in
                        self.center.x = self.originalLoc.x + 320
                    })
                    var timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("panRtoA"), userInfo: nil, repeats: false)
                    
                } else if translation.x <= 150 && translation.x > 100 {
                    UIView.animateWithDuration(0.6, animations: { () -> Void in
                        self.center.x = self.originalLoc.x + 320
                    })
                    var timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: Selector("panRtoL"), userInfo: nil, repeats: false)
                    
                } else if translation.x <= 100 {
                    self.center.x = self.originalLoc.x
                    
                }
            }
        }
    }
    
    // This allows Gesture Recognizer to cancel when scrolled vertically
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    
    // Asks ListViewController to refresh after delay
    func panLtoA () {
        listViewController.archiveContact(self)
    }
    
    func panLtoR () {
        listViewController.removeContact(self)
    }
    
    func panAtoR () {
        listViewController.acceptedToRejected(self)
    }
    
    func panAtoL () {
        listViewController.acceptedToLater(self)
    }
    
    func panRtoA () {
        listViewController.rejectedToAccepted(self)
    }
    
    func panRtoL () {
        listViewController.rejectedToLater(self)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}