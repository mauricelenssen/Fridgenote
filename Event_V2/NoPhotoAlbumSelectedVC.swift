//
//  NoPhotoAlbumSelectedVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 17/11/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class NoPhotoAlbumSelectedVC: UIViewController {
    @IBOutlet var noPhotoAlbumHeaderLbl: UILabel!
    @IBOutlet var noPhotoAlbumWarningTV: UITextView!
    @IBOutlet var noPhotoAlbumWarningView: UIView!
    @IBOutlet var selectAlbumBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noPhotoAlbumWarningView!.layer.shadowColor = UIColor.black.cgColor
        noPhotoAlbumWarningView!.layer.shadowOpacity = shadowOpacityView
        noPhotoAlbumWarningView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        noPhotoAlbumWarningView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        noPhotoAlbumWarningView?.backgroundColor    = windowColor
        noPhotoAlbumWarningView?.layer.cornerRadius = cornerRadiusWindow
        noPhotoAlbumWarningView?.layer.borderWidth  = borderWidthWindow
        noPhotoAlbumWarningView?.layer.borderColor  = borderColor.cgColor
        
        noPhotoAlbumHeaderLbl?.backgroundColor    = windowColor
        noPhotoAlbumHeaderLbl?.layer.cornerRadius = cornerRadiusWindow
        noPhotoAlbumHeaderLbl?.layer.borderWidth  = borderWidthWindow
        noPhotoAlbumHeaderLbl?.layer.borderColor  = borderColor.cgColor
        noPhotoAlbumHeaderLbl?.text = NSLocalizedString("No Photo Album", comment: "")
        noPhotoAlbumHeaderLbl.textColor = mainTextColor
        noPhotoAlbumWarningTV.textColor = mainTextColor
        noPhotoAlbumWarningTV.text = NSLocalizedString("This button activates the Photo Slide Show. Currently there is no photo album selected. Do you want to select a photo Album stored on your device?", comment: "")
        
        selectAlbumBtn?.setImage(selectPhotoAlbumImage, for: .normal)
        selectAlbumBtn?.setImage(selectPhotoAlbumImagePressed, for: .highlighted)
        cancelBtn?.setImage(cancelPopupBtnImage, for: .normal)
        cancelBtn?.setImage(cancelPopupBtnPressedImage, for: .highlighted)
        
    
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelBtnPressed(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPhotoAlbumBtnPressed(){
        print("Go to Settings to select photo album")
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in settings screen
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        print ("View Appear NO PHOTOALBUM")
        //BEGIN - you returned back from erro message stating there is no photablum, check again if now there is a photoalbum selected
        if (userSelectedPhotoAlbum != "") {self.dismiss(animated: true, completion: nil)}
        //END
            
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
