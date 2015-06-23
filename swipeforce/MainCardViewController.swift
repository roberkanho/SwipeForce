//
//  MainCardViewController.swift
//  swipeforce
//
//  Created by Carlos Cheung on 6/13/15.
//  Copyright (c) 2015 carloscheung. All rights reserved.
//

import UIKit

class MainCardViewController: UIViewController {
    
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var cardBackgroundOverlay: UIView!
    @IBOutlet weak var cardBackgroundImage: UIImageView!
    
    @IBOutlet weak var firstCard: UIView!
    @IBOutlet weak var cardBackground: UIView!
    
    @IBOutlet weak var firstCardOverlay: UIView!
    @IBOutlet weak var firstCardAcceptedImage: UIImageView!
    @IBOutlet weak var firstCardRejectedImage: UIImageView!
    @IBOutlet weak var firstCardLaterImage: UIImageView!
    
    @IBOutlet weak var secondCardOverlay: UIView!
    @IBOutlet weak var secondCardAcceptedImage: UIImageView!
    @IBOutlet weak var secondCardLaterImage: UIImageView!
    @IBOutlet weak var secondCardRejectedImage: UIImageView!
    
    @IBOutlet weak var thirdCardOverlay: UIView!
    @IBOutlet weak var thirdCardAccptedImage: UIImageView!
    @IBOutlet weak var thirdCardLaterImage: UIImageView!
    @IBOutlet weak var thirdCardRejectedImage: UIImageView!
    
    @IBOutlet weak var fourthCardOverlay: UIView!
    @IBOutlet weak var fourthCardAcceptedImage: UIImageView!
    @IBOutlet weak var fourthCardLaterImage: UIImageView!
    @IBOutlet weak var fourthCardRejectedImage: UIImageView!
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var labelView: UIView!
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var labelLabel: UILabel!
    
    @IBOutlet weak var secondCard: UIView!
    @IBOutlet weak var thirdCard: UIView!
    @IBOutlet weak var fourthCard: UIView!
    
    @IBOutlet weak var actionButtonsView: UIView!
    
    let whiteColor = UIColor(red:1, green:1, blue:1, alpha:1)
    let blueColor = UIColor(red:0.02, green:0.51, blue:0.86, alpha:1)
    let greenColor = UIColor(red:0.16, green:0.7, blue:0.48, alpha:1)
    let orangeColor = UIColor(red:0.96, green:0.65, blue:0.14, alpha:1)
    let redColor = UIColor(red:0.76, green:0.35, blue:0.46, alpha:1)
    let blueAlphaColor = UIColor(red:0.02, green:0.51, blue:0.86, alpha:0.4)
    let greenAlphaColor = UIColor(red:0.16, green:0.7, blue:0.48, alpha:0.4)
    let orangeAlphaColor = UIColor(red:0.96, green:0.65, blue:0.14, alpha:0.4)
    let redAlphaColor = UIColor(red:0.76, green:0.35, blue:0.46, alpha:0.4)
    
    var cardInitialCenter: CGPoint!
    var clockWise: Bool!
    var verticalMoveDown: Bool!
    
    var names = ["Tim Duncan", "Harris Bird", "Stephen Curry", "Andre Iguodala", "Draymond Green", "Hillary Clinton", "Barack Obama", "Larry Page"]
    var tags = ["Late", "Early", "New", "Later", "Hot", "Email"]
    var labels = ["Late", "Early", "New", "Later", "Hot", "Email"]
    
    var cards: [UIView]!
    var cardLocation: [CGRect]!
    var cardOverlay: [UIView]!
    var cardAcceptedImage: [UIImageView]!
    var cardRejectedImage: [UIImageView]!
    var cardLaterImage: [UIImageView]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = cardBackgroundView.bounds
        cardBackgroundView.addSubview(blurView)
        
        //need to check the status of the first card and then it will determine the color to display
        cardBackgroundOverlay.backgroundColor = blueAlphaColor
        cardBackground.backgroundColor = blueColor
        
        firstCard.layer.cornerRadius  = 10.0
        secondCard.layer.cornerRadius = 10.0
        thirdCard.layer.cornerRadius = 10.0
        fourthCard.layer.cornerRadius = 10.0
        fourthCard.alpha = 0
        
        labelView.layer.borderColor = whiteColor.CGColor
        labelView.layer.borderWidth = 2.0
        labelView.layer.cornerRadius = 5.0
        labelView.layer.masksToBounds = true
        
        self.nameLabel.text = names[0]
        self.labelLabel!.text = labels[0]
        
        photoImage.layer.borderWidth = 3.0
        photoImage.layer.masksToBounds = false
        photoImage.layer.borderColor = UIColor.whiteColor().CGColor
        photoImage.layer.cornerRadius = self.photoImage.frame.size.width / 2
        photoImage.clipsToBounds = true
        
        cards = [firstCard, secondCard, thirdCard, fourthCard]
        cardLocation = [firstCard.frame, secondCard.frame, thirdCard.frame, fourthCard.frame]
        cardOverlay = [firstCardOverlay, secondCardOverlay, thirdCardOverlay, fourthCardOverlay]
        cardAcceptedImage = [firstCardAcceptedImage, secondCardAcceptedImage, thirdCardAccptedImage, fourthCardAcceptedImage]
        cardRejectedImage = [firstCardRejectedImage, secondCardRejectedImage, thirdCardRejectedImage, fourthCardRejectedImage]
        cardLaterImage = [firstCardLaterImage, secondCardLaterImage, thirdCardLaterImage, fourthCardLaterImage]
        
        cardOverlay[0].alpha = 0
        cardAcceptedImage[0].hidden == true
        cardRejectedImage[0].hidden == true
        cardLaterImage[0].hidden == true
        
        cardBackgroundImage.image = self.photoImage.image
        cardBackgroundImage.transform = CGAffineTransformMakeScale(2, 2)

    }

    func progressValue(value: CGFloat, refValueMin: CGFloat, refValueMax: CGFloat, convertValueMin: CGFloat, convertValueMax: CGFloat) -> CGFloat {
        
        var ratio = (value - refValueMin)/(refValueMax - refValueMin)
        var currentValue = (convertValueMax - convertValueMin)*ratio + convertValueMin
        return currentValue
    }

    @IBAction func onPanCard(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        var location = sender.locationInView(view)
        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
        
        if sender.state == UIGestureRecognizerState.Began {
            cardInitialCenter = cards[0].center
        }
        
        if sender.state == UIGestureRecognizerState.Changed {
            self.cards[0].center = CGPoint(x: CGFloat(cardInitialCenter.x + translation.x), y: CGFloat(cardInitialCenter.y + translation.y))
            
            var rotateScale =  progressValue(cards[0].center.x, refValueMin: 160, refValueMax: 800, convertValueMin: 0, convertValueMax: (180.0 * CGFloat(M_PI)) / 180.0)
            var positiveAlphaScale =  progressValue(cards[0].center.x, refValueMin: 160, refValueMax: 280, convertValueMin: 0, convertValueMax: 1)
            var negativeAlphaScale =  progressValue(cards[0].center.x, refValueMin: 160, refValueMax: 40, convertValueMin: 0, convertValueMax: 1)
            var verticalAlphaScale =  progressValue(cards[0].center.y, refValueMin: 320, refValueMax: 480, convertValueMin: 0, convertValueMax: 1)
            var negativeFadeScale =  progressValue(cards[0].center.x, refValueMin: 160, refValueMax: 0, convertValueMin: 0.8, convertValueMax: 0)

            
            self.cards[0].transform = CGAffineTransformMakeRotation(rotateScale)

            if translation.x > 0 {
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.cardOverlay[0].alpha = positiveAlphaScale
                    self.cardAcceptedImage[0].hidden = false
                    self.cardLaterImage[0].hidden = true
                    self.cardRejectedImage[0].hidden = true
                    }, completion: nil)
            }
            
            if translation.x < 0 {
                
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.cardOverlay[0].alpha = negativeAlphaScale
                    self.cardAcceptedImage[0].hidden = true
                    self.cardLaterImage[0].hidden = true
                    self.cardRejectedImage[0].hidden = false
                    }, completion: nil)
            }
            
            if cards[0].center.y >= 320 {
                self.cardOverlay[0].alpha = verticalAlphaScale
                self.cardAcceptedImage[0].hidden = true
                self.cardLaterImage[0].hidden = false
                self.cardRejectedImage[0].hidden = true
            }
        }
        
        if sender.state == UIGestureRecognizerState.Ended {
            if abs(translation.x) < 100 && cards[0].center.y < 480 {
                UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: nil, animations: {
                    self.cards[0].center = self.cardInitialCenter
                    self.cards[0].transform = CGAffineTransformIdentity
                    self.cardOverlay[0].alpha = 0
                    }, completion: nil)
            }
            else if translation.x >= 100 && cards[0].center.y < 480 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.cards[0].center.x += self.view.bounds.width
                    }, completion: nil)
                delay(0.4) {
                    self.cards[0].transform = CGAffineTransformIdentity
                    self.animateCards()
                }
            }
            else if translation.x <= -100 && cards[0].center.y < 480 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.cards[0].center.x -= self.view.bounds.width
                    }, completion: nil)
                delay(0.4) {
                    self.cards[0].transform = CGAffineTransformIdentity
                    self.animateCards()
                }
            }
            else if cards[0].center.y > 480 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.cards[0].center.y += self.view.bounds.width
                    }, completion: nil)
                delay(0.4) {
                    self.cards[0].transform = CGAffineTransformIdentity
                    self.animateCards()
                }
            }
        }
    }

    func animateCards() {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.cards[3].alpha = 1
            self.cards[0].alpha = 0
            self.cards[1].frame = self.cardLocation[0]
            self.cards[2].frame = self.cardLocation[1]
            self.cards[3].frame = self.cardLocation[2]
            
            self.cardBackgroundOverlay.backgroundColor = UIColor(red:0.96, green:0.65, blue:0.14, alpha:0.3)
            self.cardBackgroundImage.image = self.photoImage.image
            self.cardBackgroundImage.transform = CGAffineTransformMakeScale(3, 3);
            
            }, completion: { (Bool) -> Void in
                var topCard = self.cards.removeAtIndex(0)
                self.cards.append(topCard)
                topCard.removeFromSuperview()
                self.view.insertSubview(topCard, atIndex: 1)
                topCard.frame = self.cardLocation[3]
                
                self.cardOverlay[0].alpha = 0
                var topCardOverlay = self.cardOverlay.removeAtIndex(0)
                self.cardOverlay.append(topCardOverlay)

                var topCardAcceptedImage = self.cardAcceptedImage.removeAtIndex(0)
                self.cardAcceptedImage.append(topCardAcceptedImage)
                
                var topCardRejectedImage = self.cardRejectedImage.removeAtIndex(0)
                self.cardRejectedImage.append(topCardRejectedImage)
                
                var topCardLaterImage = self.cardLaterImage.removeAtIndex(0)
                self.cardLaterImage.append(topCardLaterImage)
                
                self.photoImage.center.x = 160

        })
    }
    
    @IBAction func onTapAccept(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.cardOverlay[0].alpha = 0.8
            self.cardAcceptedImage[0].hidden = false
            self.cardLaterImage[0].hidden = true
            self.cardRejectedImage[0].hidden = true
            }, completion: nil)
        
        UIView.animateWithDuration(0.4, delay: 0.2, options: nil, animations: { () -> Void in
            self.cards[0].center.x += self.view.bounds.width * 1.3
            self.cards[0].transform = CGAffineTransformMakeRotation(45)
        }, completion: nil)
        
        delay(0.4) {
            self.cards[0].transform = CGAffineTransformIdentity
            self.animateCards()
        }
       }
    
    @IBAction func onTapRejected(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.cardOverlay[0].alpha = 0.8
            self.cardAcceptedImage[0].hidden = true
            self.cardLaterImage[0].hidden = true
            self.cardRejectedImage[0].hidden = false
            
            }, completion: nil)
        
        UIView.animateWithDuration(0.4, delay: 0.2, options: nil, animations: { () -> Void in
            self.cards[0].center.x -= self.view.bounds.width * 1.3
            self.cards[0].transform = CGAffineTransformMakeRotation(-45)
            }, completion: nil)
        
        delay(0.4) {
            self.cards[0].transform = CGAffineTransformIdentity
            self.animateCards()
        }
    }
    
    @IBAction func onTapLater(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.cardOverlay[0].alpha = 0.8
            self.cardAcceptedImage[0].hidden = true
            self.cardLaterImage[0].hidden = false
            self.cardRejectedImage[0].hidden = true
            }, completion: nil)
        
        UIView.animateWithDuration(0.4, delay: 0.2, options: nil, animations: { () -> Void in
            self.cards[0].center.y += self.view.bounds.height * 1.3
            }, completion: nil)
        
        delay(0.4) {
                self.cards[0].transform = CGAffineTransformIdentity
                self.animateCards()
                self.actionButtonsView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:0)
        }
    }
    
    class func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func onTapCard(sender: UITapGestureRecognizer) {
        performSegueWithIdentifier("card2DetailSegue", sender: nil)
         }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "card2DetailSegue") {
            //Checking identifier is crucial as there might be multiple
            // segues attached to same view
            var detailVC = segue!.destinationViewController as! DetailViewController;
            detailVC.passName = nameLabel.text
            detailVC.passPhoto = photoImage.image
            detailVC.passColor = cardBackground.backgroundColor
            detailVC.passBackgroundImageOverlay = cardBackgroundOverlay
            detailVC.passBackgroundImage = cardBackgroundImage.image
            
            detailVC.mainCardViewController = self
        }
    }
    
    
    
}
