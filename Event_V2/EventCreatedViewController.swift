//
//  EventCreatedViewController.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 7/8/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class EventCreatedViewController: UIViewController {
    @IBOutlet var calendarHeaderLbl: UILabel!
    @IBOutlet var calendarInfoView: UIView!
    //@IBOutlet var tickAnimationIVC: UIImageView!
    
    @IBOutlet var spinnerIVC: UIImageView!
    
    var activityTimer: Timer? = nil
    var closeTimer: Timer? = nil
    var errorCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        calendarInfoView!.layer.shadowColor = UIColor.black.cgColor
        calendarInfoView!.layer.shadowOpacity = shadowOpacityView
        calendarInfoView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        calendarInfoView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        calendarInfoView?.backgroundColor    = windowColor
        calendarInfoView?.layer.cornerRadius = cornerRadiusWindow
        calendarInfoView?.layer.borderWidth  = borderWidthWindow
        calendarInfoView?.layer.borderColor  = borderColor.cgColor
        
        calendarHeaderLbl.textColor = mainTextColor
        if userRequestedToUpdateEvent == true {
            calendarHeaderLbl.text = NSLocalizedString("Updating Event", comment: "")
        }
        else{
            calendarHeaderLbl.text = NSLocalizedString("Creating Event", comment: "")
        }
   }
    
    @objc func checkIfEventIsAdded() {
        //eventAddedSucces = false
        if eventAddedSucces ==  true && errorCounter > 10 // the errorcounter makes sure you see the animation for atleast 1 second
        {
            //BEGIN - Stop animation and dispay tick mark
            spinnerIVC?.layer.removeAnimation(forKey: "rotationAnimation")
            
            if dayMode {
                let loadingImages = (0...23).map { UIImage(named: "Tick AnimationDay_\($0).png")! }
                spinnerIVC.animationImages = loadingImages
                spinnerIVC.animationRepeatCount = 1
                spinnerIVC.animationDuration = 0.4
                spinnerIVC.image = loadingImages.last
                spinnerIVC.startAnimating()
            }
            else{
                let loadingImages = (0...23).map { UIImage(named: "Tick AnimationNight_\($0).png")! }
                spinnerIVC.animationImages = loadingImages
                spinnerIVC.animationRepeatCount = 1
                spinnerIVC.animationDuration = 0.4
                spinnerIVC.image = loadingImages.last
                spinnerIVC.startAnimating()
            }
            
            eventAddedSucces = false
            activityTimer?.invalidate() //Stop the timer to check if event is added
            //BEGIN - yuo need to delay the closing of the screen else you won't see the finished animation
            closeTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.closeScreen), userInfo: nil, repeats: true)
            //END
        }
        else
        {
            errorCounter=errorCounter+1
            
            if errorCounter == 50 {
                //BEGIN - after 3 seconds start colour the spinner RED to indicate something is wrong
                spinnerIVC.tintColor = .red
                //END
            }
            if errorCounter == 80 {
                print ("Error Counter /(errorCounter)")
                spinnerIVC?.layer.removeAnimation(forKey: "rotationAnimation")
                //BEGIN - Stop animation and dispay error cross
                let loadingImages = (0...12).map { UIImage(named: "Error_Animation_\($0).png")! }
                spinnerIVC.animationImages = loadingImages
                spinnerIVC.animationRepeatCount = 1
                spinnerIVC.animationDuration = 0.4
                spinnerIVC.image = loadingImages.last
                spinnerIVC.startAnimating()
                calendarHeaderLbl.textColor = .red
                calendarHeaderLbl.text = NSLocalizedString("Error - Could not create the Event", comment: "")
                //BEGIN - Wait for another 1 second so user can see red Cross
                closeTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.closeScreen), userInfo: nil, repeats: true)
                //END
            }
        }
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        print ("View Appear")
        screenSaverCounter = 0 //Reset the screen saver counter
        //BEGIN - start the spinner Animation
        //BEGIN - get access so yuo speed up, by not asking for it all the time
        eventAddedSucces = EventStoreAuthorizations()
        //END
        
        
        spinnerIVC.image = UIImage(named: "SpinnerDay")?.withRenderingMode(.alwaysTemplate)
        spinnerIVC.tintColor = attentionTextColor
        spinnerIVC.contentMode = .center
        
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
            rotationAnimation.duration = 1.5
            rotationAnimation.isCumulative = true
            rotationAnimation.repeatCount = .infinity
        
        self.spinnerIVC?.layer.add(rotationAnimation, forKey: "rotationAnimation")
        //END
        
        activityTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.checkIfEventIsAdded), userInfo: nil, repeats: true)
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerExpiredSegue8")
        performSegue(withIdentifier: "TimerExpiredSegue8", sender: nil)
    }
    //END
    
    
    @objc func closeScreen() {
        closeTimer?.invalidate()
        self.spinnerIVC?.layer.removeAnimation(forKey: "rotationAnimation")
        NotificationCenter.default.post(name: Notification.Name("updateEventNotification"), object: nil, userInfo: ["key":"value"])
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("View will disappear")
        print ("Stop notification")
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AlarmNotification"), object: nil)
    }
}
