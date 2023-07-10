//
//  DeleteToDoPopupViewController.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 9/8/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class DeleteToDoPopupViewController: UIViewController {

    @IBOutlet var deleteHeaderLbl: UILabel!
    @IBOutlet var deleteWarningLbl: UILabel!
    @IBOutlet var deleteWarningView: UIView!
    @IBOutlet var deleteEventBtn: UIButton!
    @IBOutlet var cancelEventBtn: UIButton!
    
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
        deleteWarningLbl.text = NSLocalizedString("Delete To Do List", comment: "")
        
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
        NotificationCenter.default.post(name: Notification.Name("ClearToDoListNotification"), object: nil, userInfo: ["key":"value"])
        self.dismiss(animated: true, completion: nil)
    }

    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
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
        print("TimerExpiredSegue7")
        performSegue(withIdentifier: "TimerExpiredSegue7", sender: nil)
    }
    //END
}
