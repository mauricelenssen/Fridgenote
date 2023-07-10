//
//  SlideShowSettingsVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 8/7/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import CoreMotion
import StoreKit

class SlideShowSettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //BEGIN - Header Controls
    @IBOutlet var topHeaderView: UIView!
    @IBOutlet var topHeaderImg: UIImageView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var topHeaderLbl: UILabel!
    //END
    
    @IBOutlet var photoAlbumList: UITableView!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var settingsWindowView: UIView!
    
    @IBOutlet var enableSlideShowLbl: UILabel!
    @IBOutlet var selectPhotoAlbumLbl: UILabel!
    @IBOutlet var timeDelaySlideShowStartLbl: UILabel!
    @IBOutlet var photoDisplayTimeLbl: UILabel!
    @IBOutlet var fridgeDoorInteruptSlideShowLbl: UILabel!
    @IBOutlet var fridgeDoorMovementSensitivityLbl: UILabel!
    
    @IBOutlet var slideShowStartDelayStepper: UIStepper!
    @IBOutlet var photoDelayStepper: UIStepper!
    @IBOutlet var screenSaverSw: UISwitch!
    @IBOutlet var fridgeDoorMovementSw: UISwitch!
    @IBOutlet var fridgeDoorSensitivitySld: UISlider!
    @IBOutlet var movementLevelPB: UIProgressView!
    @IBOutlet var vibrationMaxImg: UIImageView!
    @IBOutlet var vibrationMinImg: UIImageView!
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
        
        let nib = UINib.init(nibName: "PhotoAlbumTableViewCell", bundle: nil)
        self.photoAlbumList!.register(nib, forCellReuseIdentifier: "PhotoAlbumTableViewCell")
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
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        //END
        photoUpNextCounter = 0
        print ("I reset the photo counter, else it will crash if you select a new album with less photos")
        updateInAppStatus()
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in settings screen
        eventAccessApproved = EventStoreAuthorizations()
        photoAccessApproved = PhotoAuthorizations()
        
        motionManager = CMMotionManager()
        if (motionManager.isGyroAvailable){
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(
                to: OperationQueue.current!,
                withHandler: { (gyroData: CMGyroData?, errorOC: Error?) in
                    self.outputGyroData(gyro: gyroData!)
            })
        }
        
        updateScreen()
    }

    override func viewWillDisappear(_ animated: Bool) {
        print ("Settings EXIT - Stop notification")
        saveUserDefaults() //save all settings
        motionManager.stopGyroUpdates() // Stop the gyro so they don't go off in other viewcontrollers.
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    // Table View Functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let readPhotoAlbumData = getAllPhotoAlbumTitles()
        let photoAlbumID = readPhotoAlbumData.albumID[indexPath.row]
        
        userSelectedPhotoAlbum = photoAlbumID
        print ("userselected photoalbum is: \(userSelectedPhotoAlbum)")
        //print ("User picked a new photo album \(indexPath.row) | \(photoAlbumArray[indexPath.row])")
        
        photoAlbumList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //var photoAlbumArray : [String] = []
        let readPhotoAlbumData = getAllPhotoAlbumTitles()
        let photoAlbumArray = readPhotoAlbumData.titles
        return (photoAlbumArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        
        let readPhotoAlbumData = getAllPhotoAlbumTitles()
        let photoAlbumTitles = readPhotoAlbumData.titles
        let photoAlbumID = readPhotoAlbumData.albumID
        let photoAlbumType = readPhotoAlbumData.albumType
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoAlbumTableViewCell", for: indexPath) as! PhotoAlbumTableViewCell
        //BEGIN - place tick box next to selected photo album
        if photoAlbumID[indexPath.row] == userSelectedPhotoAlbum {
            photoAlbumList.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            
            cell.photoAlbumSelectionIv.image = UIImage(named: "TickSelected")?.withRenderingMode(.alwaysTemplate)
            cell.photoAlbumSelectionIv.tintColor = UIColor.init(cgColor: attentionTextColor.cgColor)
            cell.photoAlbumNameLbl?.textColor = mainTextColor
            cell.photoAlbumTypeLbl?.textColor = subTextColor
            cell.photoAlbumNameLbl!.text = photoAlbumTitles[indexPath.row]
            cell.photoAlbumTypeLbl!.text = photoAlbumTypeName (type: photoAlbumType[indexPath.row].rawValue)
        }
        else{
            cell.photoAlbumSelectionIv?.image = UIImage(named: "TickNotSelected")?.withRenderingMode(.alwaysTemplate)
            cell.photoAlbumSelectionIv.tintColor = UIColor.init(cgColor: attentionTextColor.cgColor)
            cell.photoAlbumNameLbl?.textColor = mainTextColor
            cell.photoAlbumTypeLbl?.textColor = subTextColor
            cell.photoAlbumNameLbl!.text = photoAlbumTitles[indexPath.row]
            cell.photoAlbumTypeLbl!.text = photoAlbumTypeName (type: photoAlbumType[indexPath.row].rawValue)
        }
        //END
        
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        
        return cell
    }
    //END
    //Find the photo album list and try to match to the number in the array so when you go to settings the user selected photo album is already set.
    /*
    func getUserSelectedPhotoAlbumRow ()-> Int {
        var photoAlbumArray : [String] = []
        var row = -1
        if photoAccessApproved {
            let readPhotoAlbumData = ViewController.getAllPhotoAlbumTitles()
            photoAlbumArray = readPhotoAlbumData.titles
            for i in 0..<photoAlbumArray.count {
                if (photoAlbumArray[i] == userSelectedPhotoAlbum) {
                    row = i
                }
            }
        }
        return row
    }
    */
    
    @IBAction func fridgeDoorMovementChange(_ sender: UISwitch) {
        if (sender.isOn == true){
            print ("Fridge door movement will interupt slide show")
            fridgeDoorMovementUserEnabled = true
            fridgeDoorSensitivitySld.isEnabled = true
            
        
        }
        else{
            print ("Fridge door movement will not interupt slide show")
            fridgeDoorMovementUserEnabled = false
            fridgeDoorSensitivitySld.isEnabled = false
        }
    }
    
    @IBAction func screenSaverSettingChange(_ sender: UISwitch) {
        if (sender.isOn == true){
            print ("screensaver feature enabled")
            screenSaverUserEnabled = true
        }
        else{
            print ("screensaver feature disabled")
            screenSaverUserEnabled = false
        }
    }
    
    @IBAction func fridgeDoorSensitivityChange(_ sender: UISlider) {
        fridgeDoorSensitivity = sender.value
        if fridgeDoorSensitivity < 0.16 {fridgeDoorMovementSensitivityLbl.text = NSLocalizedString("Fridge door movement sensitivity:_High", comment: "")}
        
        if fridgeDoorSensitivity >= 0.16 && fridgeDoorSensitivity <= 0.32 {fridgeDoorMovementSensitivityLbl.text = NSLocalizedString("Fridge door movement sensitivity:_Mid", comment: "")}
        
        if fridgeDoorSensitivity > 0.32 {fridgeDoorMovementSensitivityLbl.text = NSLocalizedString("Fridge door movement sensitivity:_Low", comment: "")}
        
        print ("fridge door sensitivity changed: \(fridgeDoorSensitivity)")
    }
    
    @IBAction func PhotoIntervalDelayStepper(_ sender: UIStepper) {
        photoDisplayTimeLbl.text = (NSLocalizedString("Select how long you want the photo to be displayed for: ", comment:"")) + String(format: "%.0f ",sender.value) + (NSLocalizedString("sec.", comment:""))
        photoDelayBetweenPhotos = sender.value
    }
    
    @IBAction func SlideShowStartDelayStepper(_ sender: UIStepper) {
        timeDelaySlideShowStartLbl.text = (NSLocalizedString("Select delay before slide show starts after inactivity: ", comment:"")) + String(format: "%.0f ",sender.value)  + (NSLocalizedString("min.", comment:""))
        screenSaverDelayBeforeStart = sender.value * 60 //change to seconds
    }
    
    func outputGyroData(gyro: CMGyroData){
        
        let fridgeDoorMovedx: Double = abs(gyro.rotationRate.x)
        let fridgeDoorMovedy: Double = abs(gyro.rotationRate.y)
        let fridgeDoorMovedz: Double = abs(gyro.rotationRate.z)
        let movement = fridgeDoorMovedx + fridgeDoorMovedy + fridgeDoorMovedz
        movementLevelPB.progress = Float(movement)
        movementLevelPB.progressTintColor = attentionTextColor
    }
    
    func updateScreen(){
        
        eventAccessApproved = EventStoreAuthorizations()
        photoAccessApproved = PhotoAuthorizations()
        
        updateInAppStatus()
        
        topHeaderLbl.textColor = mainTextColor
        topHeaderLbl.text = NSLocalizedString("Slide Show Settings", comment: "")
        topHeaderImg?.image = topHeaderImage
        
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        
        backgroundImageView?.image = backgroundImage
    
        settingsWindowView!.layer.shadowColor = UIColor.black.cgColor
        settingsWindowView!.layer.shadowOpacity = shadowOpacityView
        settingsWindowView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        settingsWindowView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        settingsWindowView?.backgroundColor    = windowColor
        settingsWindowView?.layer.cornerRadius = cornerRadiusWindow
        settingsWindowView?.layer.borderWidth  = borderWidthWindow
        settingsWindowView?.layer.borderColor  = borderColor.cgColor

        vibrationMinImg?.image = vibrationMinImage
        vibrationMaxImg?.image = vibrationMaxImage
        
        enableSlideShowLbl.textColor = mainTextColor
        enableSlideShowLbl.text = NSLocalizedString("Enable timed Slide Show", comment: "")
        
        selectPhotoAlbumLbl.textColor = mainTextColor
        selectPhotoAlbumLbl.text = NSLocalizedString("Select which Photo Album to use:", comment: "")
        
        fridgeDoorInteruptSlideShowLbl.textColor = mainTextColor
        fridgeDoorInteruptSlideShowLbl.text = NSLocalizedString("Slide Show to stop after movement is detected (Fridge door opens)", comment: "")
        
        timeDelaySlideShowStartLbl.textColor = mainTextColor
        photoDisplayTimeLbl.textColor = mainTextColor
        
        slideShowStartDelayStepper.tintColor = mainTextColor
        photoDelayStepper.tintColor =  mainTextColor
        screenSaverSw.tintColor = mainTextColor
        fridgeDoorMovementSw.tintColor = mainTextColor
        fridgeDoorSensitivitySld.tintColor = mainTextColor
        
        //BEGIN - Initialise, show the correct values for in labels and stepper
        photoDelayStepper.value = photoDelayBetweenPhotos
        PhotoIntervalDelayStepper(photoDelayStepper)
        
        slideShowStartDelayStepper.value = screenSaverDelayBeforeStart/60 //display minutes
        SlideShowStartDelayStepper(slideShowStartDelayStepper)
        
        fridgeDoorMovementSensitivityLbl.textColor = mainTextColor
        fridgeDoorMovementSensitivityLbl.text = NSLocalizedString("Fridge door movement sensitivity:", comment: "")

        fridgeDoorSensitivitySld.value = fridgeDoorSensitivity
        fridgeDoorSensitivityChange(fridgeDoorSensitivitySld)
        
        //BEGIN - Update the user selected screen saver button state correct
        if screenSaverUserEnabled == true {screenSaverSw.isOn = true}
        else {screenSaverSw.isOn = false }
        //END
        
        //BEGIN - Update the user selected fridge door movement button state correct
        if fridgeDoorMovementUserEnabled == true {fridgeDoorMovementSw.isOn = true}
        else {fridgeDoorMovementSw.isOn = false }
        //END
        
        photoAlbumList.separatorColor = tableSeperatorColor
        photoAlbumList.reloadData()

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
    
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close View")
        self.dismiss(animated: true, completion: nil)
    }
}

