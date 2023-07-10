//
//  GeneralWarningViewController.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 5/10/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

var generalWarningHeaderText:String = "Warningggg"
var generalWarningText:String = "Warningggg"

class GeneralWarningViewController: UIViewController {
    
    @IBOutlet var warningHeaderLbl: UILabel!
    @IBOutlet var warningGeneralTV: UITextView!
    @IBOutlet var warningView: UIView!
    @IBOutlet var cancelEventBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateScreen(){
        warningHeaderLbl.textColor = mainTextColor
        warningHeaderLbl.text = generalWarningHeaderText
        warningGeneralTV.textColor = mainTextColor
        warningGeneralTV.text = generalWarningText
        
        warningView!.layer.shadowColor = UIColor.black.cgColor
        warningView!.layer.shadowOpacity = shadowOpacityView
        warningView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        warningView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        warningView?.backgroundColor    = windowColor
        warningView?.layer.cornerRadius = cornerRadiusWindow
        warningView?.layer.borderWidth  = borderWidthWindow
        warningView?.layer.borderColor  = borderColor.cgColor
        
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
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        print ("View Appear")
        screenSaverCounter = 0 //Reset the screen saver counter
        updateScreen()
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
