//
//  DeleteReminderViewController.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 3/10/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class DeleteReminderViewController: UIViewController {
    @IBOutlet var deleteHeaderLbl: UILabel!
    @IBOutlet var deleteWarningLbl: UILabel!
    @IBOutlet var deleteWarningView: UIView!
    @IBOutlet var deleteEventBtn: UIButton!
    @IBOutlet var cancelEventBtn: UIButton!
    
    @IBOutlet var spinnerIV: UIImageView!
    var closeTimer: Timer? = nil
    
    
    
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerIV.contentMode = .center
        spinnerIV.isHidden = true
        
        
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
        deleteWarningLbl.text = NSLocalizedString("Delete Note:", comment: "") + notesTitles[SelectedRow]
        deleteWarningLbl.isHidden = false
        
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
    }
    
    @IBAction func cancelBtnPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteBtnPressed(){
        //BEGIN - Start the bin animation
        spinnerIV.isHidden = false
        deleteWarningLbl.isHidden = true
        spinnerIV?.layer.removeAnimation(forKey: "rotationAnimation")
        let loadingImages = (0...12).map { UIImage(named: "Delete_Animation_\($0).png")! }
        spinnerIV.animationImages = loadingImages
        spinnerIV.animationRepeatCount = 1
        spinnerIV.animationDuration = 0.4
        spinnerIV.image = loadingImages.last
        spinnerIV.startAnimating()
        
        //BEGIN - you need to delay the closing of the screen else you won't see the finished animation
        closeTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.closeScreen2), userInfo: nil, repeats: true)
        //END
     }
    
    
    
    
    @objc func closeScreen2(){
        closeTimer?.invalidate()
        self.spinnerIV?.layer.removeAnimation(forKey: "rotationAnimation")
        NotificationCenter.default.post(name: Notification.Name("DeleteReminderNotification"), object: nil, userInfo: ["key":"value"])
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool){
        print ("View Appear")
        screenSaverCounter = 0 //Reset the screen saver counter
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("View will disappear")
        print ("Stop notification")
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AlarmNotification"), object: nil)
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerExpiredSegue")
        performSegue(withIdentifier: "TimerExpiredSegue", sender: nil)
    }
    //END
}
