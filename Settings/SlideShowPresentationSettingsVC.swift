//
//  SlideShowPresentationSettingsVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 8/7/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import StoreKit

class SlideShowPresentationSettingsVC: UIViewController {
    //BEGIN - Header Controls
    @IBOutlet var topHeaderView: UIView!
    @IBOutlet var topHeaderImg: UIImageView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var topHeaderLbl: UILabel!
    //END
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var settingsWindowView: UIView!
    
    @IBOutlet var displayClockLbl: UILabel!
    @IBOutlet var displayDateLbl: UILabel!
    @IBOutlet var displayLocationLbl: UILabel!
    @IBOutlet var displayPhotoCreationDateLbl: UILabel!
    
    @IBOutlet var shufflePhotosLbl: UILabel!
    @IBOutlet var photoZoomSpeedLbl: UILabel!
    @IBOutlet var zoomSpeedMinLbl: UILabel!
    @IBOutlet var zoomSpeedMaxLbl: UILabel!
    
    @IBOutlet var clockInPhotoSw: UISwitch!
    @IBOutlet var dateInPhotoSw: UISwitch!
    @IBOutlet var locationInPhotoSw: UISwitch!
    
    @IBOutlet var displayPhotoCreationDateSw: UISwitch!
    @IBOutlet var photoMotionSw: UISwitch!
    @IBOutlet var photoShuffleSw: UISwitch!
    @IBOutlet var photoMotionSpeedSld: UISlider!
    @IBOutlet var inAppBtn: UIButton!
    
    @IBAction func unlockAppFeatures() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print ("Unable to make a payment")
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({
            switch $0.transactionState {
            case .purchasing:
                print ("purchasing")
            case .purchased:
                print ("purchased")
                SKPaymentQueue.default().finishTransaction($0)
                inAppPurchased = true
                inAppBtn.isHidden = true
                saveUserDefaults() //store the inAppPurchased variable
            case .failed:
                print ("failed")
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                print ("restored")
                break
            case .deferred:
                print ("deferred")
                break
            @unknown default:
                break
            }
       })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerSegue")
        performSegue(withIdentifier: "TimerSegue", sender: nil)
    }
    //END
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    @objc func screenModeHasChanged()
    {
        print ("I updated the screen MODE")
        updateScreen()
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        print ("Info View Appear")
        updateInAppStatus()
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        //END
        
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in settings screen
        eventAccessApproved = EventStoreAuthorizations()
        photoAccessApproved = PhotoAuthorizations()
        updateScreen()
    }

    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        saveUserDefaults() //save all settings
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func clockInPhotoChange(_ sender: UISwitch) {
        if (sender.isOn == true){
            clockInPhoto = true
        }
        else{
            clockInPhoto = false
        }
    }
    
    @IBAction func photoShuffleChange(_ sender: UISwitch) {
        if (sender.isOn == true){
            photoShuffle = true
        }
        else{
            photoShuffle = false
            photoUpNextCounter = 0 //set to 0 so the photo show start from the start else it will use last random image one
        }
    }
    
    @IBAction func dateInPhotoChange(_ sender: UISwitch) {
        if (sender.isOn == true){
            dateInPhoto = true
        }
        else{
            dateInPhoto = false
        }
    }
    
    @IBAction func locationInPhotoChange(_ sender: UISwitch) {
        if (sender.isOn == true){
            locationInPhoto = true
        }
        else{
            locationInPhoto = false
        }
    }
    
    @IBAction func photoMotionChange(_ sender: UISlider) {
        photoMotionSpeed = sender.value
    }
    
    @IBAction func photoMotionSwitchChange(_ sender: UISwitch) {
        if sender.isOn == true {
            photoMotion = true
            photoMotionSpeedSld.isEnabled = true
        }
        else {
            photoMotion = false
            photoMotionSpeedSld.isEnabled = false
        }
    }
    func updateInAppStatus(){
        inAppBtn!.layer.shadowColor = UIColor.black.cgColor
        inAppBtn!.layer.shadowOpacity = shadowOpacityButtons
        inAppBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        inAppBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        if inAppPurchased {
            //BEGIN - User is using PAID Version
            inAppBtn?.isHidden = true
            inAppBtn?.setImage(lockImage, for: .normal)
            inAppBtn?.setTitleColor(attentionTextColor, for: .normal)
            inAppBtn?.setTitle("", for: .normal)
        }
        else {
            //BEGIN - User is using FREE version
            inAppBtn?.isHidden = false
            inAppBtn?.setImage(lockImage, for: .normal)
            inAppBtn?.setTitleColor(attentionTextColor, for: .normal)
            inAppBtn?.setTitle(NSLocalizedString("Photo Limit of 5", comment: ""), for: .normal)
        }
    }
    
    func updateScreen(){
        eventAccessApproved = EventStoreAuthorizations()
        photoAccessApproved = PhotoAuthorizations()
        updateInAppStatus()
        
        backgroundImageView?.image = backgroundImage
    
        topHeaderLbl.textColor = mainTextColor
        topHeaderLbl.text = NSLocalizedString("Slide Show Presentation", comment: "")
        topHeaderImg?.image = topHeaderImage
        
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        settingsWindowView!.layer.shadowColor = UIColor.black.cgColor
        settingsWindowView!.layer.shadowOpacity = shadowOpacityView
        settingsWindowView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        settingsWindowView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        settingsWindowView?.backgroundColor    = windowColor
        settingsWindowView?.layer.cornerRadius = cornerRadiusWindow
        settingsWindowView?.layer.borderWidth  = borderWidthWindow
        settingsWindowView?.layer.borderColor  = borderColor.cgColor
    
        
                
        displayClockLbl.textColor = mainTextColor
        displayClockLbl.text = NSLocalizedString("Display Clock in Photo", comment: "")
        
        displayDateLbl.textColor = mainTextColor
        displayDateLbl.text = NSLocalizedString("Display Date in Photo", comment: "")
        
        displayLocationLbl.textColor = mainTextColor
        displayLocationLbl.text = NSLocalizedString("Show Location in Photo (if data is available in photo)", comment: "")
                
        displayPhotoCreationDateLbl.textColor = mainTextColor
        displayPhotoCreationDateLbl.text = NSLocalizedString("display creation date in photo", comment: "")
        
        shufflePhotosLbl.textColor = mainTextColor
        shufflePhotosLbl.text = NSLocalizedString("Shuffle Photos" , comment: "")
        
        photoZoomSpeedLbl.textColor = mainTextColor
        photoZoomSpeedLbl.text = NSLocalizedString("Photo Zoom Speed" , comment: "")
        
        zoomSpeedMinLbl.textColor = mainTextColor
        zoomSpeedMaxLbl.textColor = mainTextColor
        
        //BEGIN - Update the switches to the user defaulted state
        if clockInPhoto == true {clockInPhotoSw.isOn = true}
        else {clockInPhotoSw.isOn = false }
        //END
        
        //BEGIN - Update the switches to the user defaulted state
        if dateInPhoto == true {dateInPhotoSw.isOn = true}
        else {dateInPhotoSw.isOn = false }
        //END
        
        //BEGIN - Update the switches to the user defaulted state
        if displayCreationDateInPhoto == true {displayPhotoCreationDateSw.isOn = true}
        else {displayPhotoCreationDateSw.isOn = false }
        //END//
        
        //BEGIN - Update the switches to the user defaulted state
        if photoMotion == true {
            photoMotionSw.isOn = true
            photoMotionSpeedSld.isEnabled = true
        }
        else {
            photoMotionSw.isOn = false
            photoMotionSpeedSld.isEnabled = false
        }
        //END//
    
        //BEGIN - Update the switches to the user defaulted state
        if photoShuffle == true {photoShuffleSw.isOn = true}
        else {photoShuffleSw.isOn = false }
        //END//
    
        photoMotionSpeedSld.value   = Float(photoMotionSpeed)
        
        //BEGIN - Update the switches to the user defaulted state
        if  locationInPhoto == true {locationInPhotoSw.isOn = true}
        else {locationInPhotoSw.isOn = false }
        //END//
    }
    
    @IBAction func displayDateInPhotoSwitchChange(_ sender: UISwitch) {
        if (sender.isOn == true){
            print ("Date in Photo enabled")
            displayCreationDateInPhoto = true
        }
        else{
            print ("Date in Photo disabled")
            displayCreationDateInPhoto = false
        }
    }
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close View")
        self.dismiss(animated: true, completion: nil)
    }

}

