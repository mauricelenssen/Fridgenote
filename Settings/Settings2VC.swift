//
//  Settings2VC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 8/7/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import StoreKit

//BEGIN - this array hold the user selected calendar ID, it is used in Upcoming Calendar table view
var userCalendarListID: [String] = []
var userCalendarListTick: [Bool] = []
//END

//BEGIN - this array hold the user selected calendar ID, it is used in Today Calendar table view
var userCalendarListID1: [String] = []
var userCalendarListTick1: [Bool] = []



class Settings2VC: UIViewController,SKPaymentTransactionObserver  {
    //BEGIN - Header Controls
    @IBOutlet var topHeaderView: UIView!
    @IBOutlet var topHeaderImg: UIImageView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var topHeaderLbl: UILabel!
    //END
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var settingsHeaderLbl: UILabel!
    //@IBOutlet var restoreAppBtn: UIButton!
    //@IBOutlet var inAppBtn: UIButton!
    
    //BEGIN - Button Definitions
    @IBOutlet var infoVw: UIView!
    @IBOutlet var infoLbl: UILabel!
    @IBOutlet var infoImg: UIImageView!
    @IBOutlet var infoBtn: UIButton!
    
    @IBOutlet var calendarSelectionVw: UIView!
    @IBOutlet var calendarSelectionLbl: UILabel!
    @IBOutlet var calendarSelectionImg: UIImageView!
    @IBOutlet var calendarSelectionBtn: UIButton!
    
    @IBOutlet var photoSelectionVw: UIView!
    @IBOutlet var photoSelectionLbl: UILabel!
    @IBOutlet var photoSelectionImg: UIImageView!
    @IBOutlet var photoSelectionBtn: UIButton!
    
    @IBOutlet var slideShowPresentationVw: UIView!
    @IBOutlet var slideShowPresentationLbl: UILabel!
    @IBOutlet var slideShowPresentationImg: UIImageView!
    @IBOutlet var slideShowPresentationBtn: UIButton!
    
    @IBOutlet var screenBrightnessVw: UIView!
    @IBOutlet var screenBrightnessLbl: UILabel!
    @IBOutlet var screenBrightnessImg: UIImageView!
    @IBOutlet var screenBrightnessBtn: UIButton!
    
    @IBOutlet var appRestoreVw: UIView!
    @IBOutlet var appRestoreLbl: UILabel!
    @IBOutlet var appRestoreImg: UIImageView!
    @IBOutlet var appRestoreBtn: UIButton!
    
    @IBOutlet var calendarEditVw: UIView!
    @IBOutlet var calendarEditLbl: UILabel!
    @IBOutlet var calendarEditImg: UIImageView!
    @IBOutlet var calendarEditBtn: UIButton!
    
    @IBOutlet var appUnlockVw: UIView!
    @IBOutlet var appUnlockLbl: UILabel!
    @IBOutlet var appUnlockImg: UIImageView!
    @IBOutlet var appUnlockBtn: UIButton!
    
    @IBOutlet var monthViewSettingsVw: UIView!
    @IBOutlet var monthViewSettingsLbl: UILabel!
    @IBOutlet var monthViewSettingsImg: UIImageView!
    @IBOutlet var monthViewSettingsBtn: UIButton!
    
    @IBOutlet var familyViewSettingsVw: UIView!
    @IBOutlet var familyViewSettingsLbl: UILabel!
    @IBOutlet var familyViewSettingsImg: UIImageView!
    @IBOutlet var familyViewSettingsBtn: UIButton!
    
    
    //END
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerSegue")
        performSegue(withIdentifier: "TimerSegue", sender: nil)
    }
    //END
    
    
    @objc func screenModeHasChanged()
        {
            print ("I updated the screen MODE")
            updateScreen()
            updateInAppStatus()
        }
    
    
    override func viewWillAppear(_ animated: Bool){
        print ("Settings View Appear")
        //UINavigationBar.appearance().backgroundColor = .green        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        //END
        
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in settings screen
        eventAccessApproved = EventStoreAuthorizations()
        photoAccessApproved = PhotoAuthorizations()
        print ("gfdgfdggdfgdf")
        updateScreen()
        updateInAppStatus()
    }

    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        screenSaverAllowed = true //allow to show the screen saver again once you are out of the settings screen
        
        NotificationCenter.default.removeObserver(self)
    }
    func updateScreen() {
        updateInAppStatus()
        
        topHeaderLbl.textColor = mainTextColor
        topHeaderLbl.text =  NSLocalizedString("Settings", comment: "")
        topHeaderImg?.image = topHeaderImage
        
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        backgroundImageView?.image = backgroundImage
        
        infoVw!.layer.borderColor  = borderColor.cgColor
        infoVw!.layer.shadowColor = UIColor.black.cgColor
        infoVw!.layer.shadowOpacity = shadowOpacityView
        infoVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        infoVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        infoVw?.backgroundColor    = windowColor
        infoVw?.layer.cornerRadius = cornerRadiusWindow
        infoVw?.layer.borderWidth  = borderWidthWindow
        infoVw?.layer.borderColor  = borderColor.cgColor
        
        infoLbl.text = NSLocalizedString("Info", comment: "")
        infoLbl.textColor = mainTextColor
        infoImg.image = infoSettingsImage
        
        // -----------
        calendarSelectionVw!.layer.borderColor  = borderColor.cgColor
        calendarSelectionVw!.layer.shadowColor = UIColor.black.cgColor
        calendarSelectionVw!.layer.shadowOpacity = shadowOpacityView
        calendarSelectionVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        calendarSelectionVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        calendarSelectionVw?.backgroundColor    = windowColor
        calendarSelectionVw?.layer.cornerRadius = cornerRadiusWindow
        calendarSelectionVw?.layer.borderWidth  = borderWidthWindow
        calendarSelectionVw?.layer.borderColor  = borderColor.cgColor
        
        calendarSelectionLbl.text = NSLocalizedString("Calendar Selection", comment: "")
        calendarSelectionLbl.textColor = mainTextColor
        calendarSelectionImg.image = calendarSelectionSettingsImage
        
        // -----------
        photoSelectionVw!.layer.borderColor  = borderColor.cgColor
        photoSelectionVw!.layer.shadowColor = UIColor.black.cgColor
        photoSelectionVw!.layer.shadowOpacity = shadowOpacityView
        photoSelectionVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        photoSelectionVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        photoSelectionVw?.backgroundColor    = windowColor
        photoSelectionVw?.layer.cornerRadius = cornerRadiusWindow
        photoSelectionVw?.layer.borderWidth  = borderWidthWindow
        photoSelectionVw?.layer.borderColor  = borderColor.cgColor
        
        photoSelectionLbl.text = NSLocalizedString("Slide Show Settings", comment: "")
        photoSelectionLbl.textColor = mainTextColor
        photoSelectionImg.image = photoLibrarySelectionSettingsImage
        
        // -----------
        slideShowPresentationVw!.layer.borderColor  = borderColor.cgColor
        slideShowPresentationVw!.layer.shadowColor = UIColor.black.cgColor
        slideShowPresentationVw!.layer.shadowOpacity = shadowOpacityView
        slideShowPresentationVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        slideShowPresentationVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        slideShowPresentationVw?.backgroundColor    = windowColor
        slideShowPresentationVw?.layer.cornerRadius = cornerRadiusWindow
        slideShowPresentationVw?.layer.borderWidth  = borderWidthWindow
        slideShowPresentationVw?.layer.borderColor  = borderColor.cgColor
        slideShowPresentationLbl.text = NSLocalizedString("Slide Show Presentation", comment: "")
        slideShowPresentationLbl.textColor = mainTextColor
        slideShowPresentationImg.image = photoDisplaySettingsImage
        
        // -----------
        screenBrightnessVw!.layer.borderColor  = borderColor.cgColor
        screenBrightnessVw!.layer.shadowColor = UIColor.black.cgColor
        screenBrightnessVw!.layer.shadowOpacity = shadowOpacityView
        screenBrightnessVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        screenBrightnessVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        screenBrightnessVw?.backgroundColor    = windowColor
        screenBrightnessVw?.layer.cornerRadius = cornerRadiusWindow
        screenBrightnessVw?.layer.borderWidth  = borderWidthWindow
        screenBrightnessVw?.layer.borderColor  = borderColor.cgColor
        screenBrightnessLbl.text = NSLocalizedString("Screen Brightness Settings", comment: "")
        screenBrightnessLbl.textColor = mainTextColor
        screenBrightnessImg.image = screenBrightnessSettingsImage
        
        // -----------
        appRestoreVw!.layer.borderColor  = borderColor.cgColor
        appRestoreVw!.layer.shadowColor = UIColor.black.cgColor
        appRestoreVw!.layer.shadowOpacity = shadowOpacityView
        appRestoreVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        appRestoreVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        appRestoreVw?.backgroundColor    = windowColor
        appRestoreVw?.layer.cornerRadius = cornerRadiusWindow
        appRestoreVw?.layer.borderWidth  = borderWidthWindow
        appRestoreVw?.layer.borderColor  = borderColor.cgColor
        appRestoreLbl.text = NSLocalizedString("Restore Purchase", comment: "")
        appRestoreLbl.textColor = mainTextColor
        appRestoreImg.image = inAppRestoreSettingsImage
        
        
        // -----------
        calendarEditVw!.layer.borderColor  = borderColor.cgColor
        calendarEditVw!.layer.shadowColor = UIColor.black.cgColor
        calendarEditVw!.layer.shadowOpacity = shadowOpacityView
        calendarEditVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        calendarEditVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        calendarEditVw?.backgroundColor    = windowColor
        calendarEditVw?.layer.cornerRadius = cornerRadiusWindow
        calendarEditVw?.layer.borderWidth  = borderWidthWindow
        calendarEditVw?.layer.borderColor  = borderColor.cgColor
        calendarEditLbl.text = NSLocalizedString("Calendar Creation or Edit", comment: "")
        calendarEditLbl.textColor = mainTextColor
        calendarEditImg.image = calendarEditSettingsImage
        
        
        // -----------
        appUnlockVw!.layer.borderColor  = borderColor.cgColor
        appUnlockVw!.layer.shadowColor = UIColor.black.cgColor
        appUnlockVw!.layer.shadowOpacity = shadowOpacityView
        appUnlockVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        appUnlockVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        appUnlockVw?.backgroundColor    = windowColor
        appUnlockVw?.layer.cornerRadius = cornerRadiusWindow
        appUnlockVw?.layer.borderWidth  = borderWidthWindow
        appUnlockVw?.layer.borderColor  = borderColor.cgColor
        //appUnlockLbl.text = NSLocalizedString("Unlock App", comment: "")
        appUnlockLbl.text = NSLocalizedString("Unlock App, App is currently locked", comment: "")
        appUnlockLbl.textColor = mainTextColor
        appUnlockImg.image = inAppSettingsImage
        
        
        // ------------
        
       
        monthViewSettingsVw!.layer.borderColor  = borderColor.cgColor
        monthViewSettingsVw!.layer.shadowColor = UIColor.black.cgColor
        monthViewSettingsVw!.layer.shadowOpacity = shadowOpacityView
        monthViewSettingsVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        monthViewSettingsVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        monthViewSettingsVw?.backgroundColor    = windowColor
        monthViewSettingsVw?.layer.cornerRadius = cornerRadiusWindow
        monthViewSettingsVw?.layer.borderWidth  = borderWidthWindow
        monthViewSettingsVw?.layer.borderColor  = borderColor.cgColor
        
        monthViewSettingsLbl.text = NSLocalizedString("Month View Layout", comment: "")
        monthViewSettingsLbl.textColor = mainTextColor
        monthViewSettingsImg.image = monthViewBtnImage
    
    
        // ------------
        
        
        familyViewSettingsVw!.layer.borderColor  = borderColor.cgColor
        familyViewSettingsVw!.layer.shadowColor = UIColor.black.cgColor
        familyViewSettingsVw!.layer.shadowOpacity = shadowOpacityView
        familyViewSettingsVw!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        familyViewSettingsVw!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        familyViewSettingsVw?.backgroundColor    = windowColor
        familyViewSettingsVw?.layer.cornerRadius = cornerRadiusWindow
        familyViewSettingsVw?.layer.borderWidth  = borderWidthWindow
        familyViewSettingsVw?.layer.borderColor  = borderColor.cgColor
        
        familyViewSettingsLbl.text = NSLocalizedString("Calendar Overview", comment: "")
        familyViewSettingsLbl.textColor = mainTextColor
        familyViewSettingsImg.image = weekOutlookImage
    }
    
    
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close the Settings View")
        
        screenSaverAllowed = true //allow to show the screen saver again once you are out off the settings screen
        //BEGIN - Go back to your Root View Controller
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func restoreInAppPurchase() {
        print ("Restore button pressed")
        
        SKPaymentQueue.default().restoreCompletedTransactions()
        
    }

    @IBAction func unlockAppFeatures() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print ("Unable to make a payment")
        }
        
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String
            
            if prodID == productID {
                //BEGIN: This checks if the returned string equals string I coded as the inapp purchase string
                print ("I restored the purchase")
                let alert = UIAlertController(title: NSLocalizedString("Purchase restored", comment:""), message: NSLocalizedString("Your app is now unlocked, the purchase has been restored.", comment:""), preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:""), style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                
                inAppPurchased = true
                //inAppBtn.isHidden = true
                //restoreAppBtn.isHidden = true
                saveUserDefaults() //store the inAppPurchased variable
            }
            else {
                let alert = UIAlertController(title: NSLocalizedString("Restore Error!", comment:""), message: NSLocalizedString("Your app purchase could not be restored!", comment:""), preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment:""), style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                
            }
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
                //restoreAppBtn.isHidden = true
                //inAppBtn.isHidden = true
                saveUserDefaults() //store the inAppPurchased variable
            case .failed:
                print ("failed")
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                print ("restored")
                SKPaymentQueue.default().finishTransaction($0)
                inAppPurchased = true
                //inAppBtn.isHidden = true
                //restoreAppBtn.isHidden = true
                saveUserDefaults() //store the inAppPurchased variable
                break
            case .deferred:
                print ("deferred")
                break
            @unknown default:
                break
            }
       })
    }
    
    func updateInAppStatus(){
        if inAppPurchased {
            //BEGIN - User is using PAID Version
            appUnlockLbl.text = NSLocalizedString("Unlock App, App is currently unlocked", comment: "")
        }
        else {
            //BEGIN - User is using FREE version
            appUnlockLbl.text = NSLocalizedString("Unlock App, App is currently locked", comment: "")
        }
         
    }
         

    
    
    @IBAction func settingsButtonPressedDown(sender: UIButton){
        switch (sender.tag) {
        case 0:
            infoVw.backgroundColor = buttonPressedColor
        case 1:
            calendarSelectionVw.backgroundColor = buttonPressedColor
        case 2:
            photoSelectionVw.backgroundColor = buttonPressedColor
        case 3:
            slideShowPresentationVw.backgroundColor = buttonPressedColor
        case 4:
            screenBrightnessVw.backgroundColor = buttonPressedColor
        case 5:
            appRestoreVw.backgroundColor = buttonPressedColor
        case 6:
            calendarEditVw.backgroundColor = buttonPressedColor
        case 7:
            appUnlockVw.backgroundColor = buttonPressedColor
        case 8:
            monthViewSettingsVw.backgroundColor = buttonPressedColor
        case 9:
            familyViewSettingsVw.backgroundColor = buttonPressedColor
        default:
            print ("switch fell Through")
        }
    }
    
    @IBAction func settingsButtonCanceled(sender: UIButton){
        switch (sender.tag) {
        case 0:
            infoVw.backgroundColor = windowColor
        case 1:
            calendarSelectionVw.backgroundColor = windowColor
        case 2:
            photoSelectionVw.backgroundColor = windowColor
        case 3:
            slideShowPresentationVw.backgroundColor = windowColor
        case 4:
            screenBrightnessVw.backgroundColor = windowColor
        case 5:
            appRestoreVw.backgroundColor = windowColor
        case 6:
            calendarEditVw.backgroundColor = windowColor
        case 7:
            appUnlockVw.backgroundColor = windowColor
        case 8:
            monthViewSettingsVw.backgroundColor = windowColor
        case 9:
            familyViewSettingsVw.backgroundColor = windowColor
        
        
        
        default:
            print ("switch fell Through")
        }
    }
    
}
