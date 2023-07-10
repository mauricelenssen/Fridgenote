//
//  DeleteCalendarPopupVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 24/7/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit



class DeleteCalendarPopupVC: UIViewController {

    @IBOutlet var deleteHeaderLbl: UILabel!
    @IBOutlet var deleteWarningLbl: UILabel!
    @IBOutlet var deleteWarningView: UIView!
    @IBOutlet var deleteEventBtn: UIButton!
    @IBOutlet var cancelEventBtn: UIButton!
    @IBOutlet var spinnerIVC: UIImageView!
    
    var closeTimer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteWarningView!.layer.shadowColor = UIColor.black.cgColor
        deleteWarningView!.layer.shadowOpacity = shadowOpacityView
        deleteWarningView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        deleteWarningView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        deleteWarningView?.backgroundColor    = windowColor
        deleteWarningView?.layer.cornerRadius = cornerRadiusWindow
        deleteWarningView?.layer.borderWidth  = borderWidthWindow
        deleteWarningView?.layer.borderColor  = borderColor.cgColor
        
        deleteHeaderLbl.textColor = mainTextColor
        deleteHeaderLbl.text = NSLocalizedString("Warning", comment: "")
        deleteWarningLbl.textColor = mainTextColor
        deleteWarningLbl.text = NSLocalizedString("Are you sure you want to Delete the Calendar?", comment: "")
        
        deleteEventBtn?.setImage(deletePopupBtnImage, for: .normal)
        deleteEventBtn?.setImage(deletePopupBtnPressedImage, for: .highlighted)
        
        deleteEventBtn!.layer.shadowColor = UIColor.black.cgColor
        deleteEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        deleteEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        deleteEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        cancelEventBtn?.setImage(cancelPopupBtnImage, for: .normal)
        cancelEventBtn?.setImage(cancelPopupBtnPressedImage, for: .highlighted)
        cancelEventBtn!.layer.shadowColor = UIColor.black.cgColor
        cancelEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        cancelEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        cancelEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        spinnerIVC.isHidden = true
        
        
    }
    
    @IBAction func cancelBtnPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBtnPressed(){
        let calendarStore = EKEvent.init(eventStore: eventStore)
        calendarStore.calendar = eventStore.calendar(withIdentifier: calendarSelectedID)
        var calendarDeleted: Bool = false
        do
        {
            try eventStore.removeCalendar(calendarStore.calendar, commit: true)
            calendarDeleted = true
        }
        catch
        {
            print("ERROR - Deleting the Calendar")
            calendarDeleted = false
        }
        deleteHeaderLbl.textColor = .red
        deleteWarningLbl.text = ""
        deleteHeaderLbl.text = ""
        if calendarDeleted {
            if dayMode {
                let loadingImages = (0...23).map { UIImage(named: "Tick AnimationDay_\($0).png")! }
                spinnerIVC.animationImages = loadingImages
                spinnerIVC.animationRepeatCount = 1
                spinnerIVC.animationDuration = 0.4
                spinnerIVC.image = loadingImages.last
                spinnerIVC.isHidden = false
                spinnerIVC.startAnimating()
            }
            else{
                let loadingImages = (0...23).map { UIImage(named: "Tick AnimationNight_\($0).png")! }
                spinnerIVC.animationImages = loadingImages
                spinnerIVC.animationRepeatCount = 1
                spinnerIVC.animationDuration = 0.4
                spinnerIVC.image = loadingImages.last
                spinnerIVC.isHidden = false
                spinnerIVC.startAnimating()
            }
            
            //BEGIN - you need to delay the closing of the screen else you won't see the finished animation
            closeTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.closeScreen), userInfo: nil, repeats: true)
        }
        else{
            
            //spinnerIVC?.layer.removeAnimation(forKey: "rotationAnimation")
            //BEGIN - Stop animation and dispay error cross
            let loadingImages = (0...12).map { UIImage(named: "Error_Animation_\($0).png")! }
            spinnerIVC.animationImages = loadingImages
            spinnerIVC.animationRepeatCount = 1
            spinnerIVC.animationDuration = 0.4
            spinnerIVC.image = loadingImages.last
            spinnerIVC.isHidden = false
            spinnerIVC.startAnimating()
            deleteHeaderLbl.textColor = .red
            deleteWarningLbl.text = ""
            deleteHeaderLbl.text = NSLocalizedString("Could not Delete the Calendar", comment: "")
            //BEGIN - Wait for another 1 second so user can see red Cross
            closeTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.closeScreen), userInfo: nil, repeats: true)
         }
    }
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        print ("View Appear")
        closeTimer?.invalidate()
        self.spinnerIVC?.layer.removeAnimation(forKey: "rotationAnimation")
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("View will disappear")
        print ("Stop notification")
        NotificationCenter.default.removeObserver(self) //Remove All notifications
    }
        
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerExpiredSegue")
        performSegue(withIdentifier: "TimerExpiredSegue", sender: nil)
    }
    
    @objc func closeScreen() {
        closeTimer?.invalidate()
        self.spinnerIVC?.layer.removeAnimation(forKey: "rotationAnimation")
        NotificationCenter.default.post(name: Notification.Name("DeleteCalendarNotification"), object: nil, userInfo: ["key":"value"])
        self.dismiss(animated: true, completion: nil)
    }
}
