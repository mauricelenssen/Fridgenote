//
//  ScreenBrightnessSettingsVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 9/7/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class ScreenBrightnessSettingsVC: UIViewController {
    //BEGIN - Header Controls
    @IBOutlet var topHeaderView: UIView!
    @IBOutlet var topHeaderImg: UIImageView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var topHeaderLbl: UILabel!
    //END
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var settingsWindowView: UIView!
    
    @IBOutlet var dayTimeLbl: UILabel!
    @IBOutlet var nightTimeLbl: UILabel!
    @IBOutlet var sleepTimeLbl: UILabel!
    @IBOutlet var themeLbl: UILabel!
    
    @IBOutlet var dayTimeSettingsLbl: UILabel!
    @IBOutlet var nightTimeSettingsLbl: UILabel!
    @IBOutlet var sleepTimeSettingsLbl: UILabel!
    
    @IBOutlet var dayTimeStepperValue: UIStepper!
    @IBOutlet var nightTimeStepperValue: UIStepper!
    @IBOutlet var sleepTimeStepperValue: UIStepper!
    
    @IBOutlet var dayScreenBrightnessSld: UISlider!
    @IBOutlet var nightScreenBrightnessSld: UISlider!
    @IBOutlet var sleepScreenBrightnessSld: UISlider!
    
    @IBOutlet var brightnessMinImg0: UIImageView!
    @IBOutlet var brightnessMaxImg0: UIImageView!
    @IBOutlet var brightnessMinImg1: UIImageView!
    @IBOutlet var brightnessMaxImg1: UIImageView!
    @IBOutlet var brightnessMinImg2: UIImageView!
    @IBOutlet var brightnessMaxImg2: UIImageView!
    
    @IBOutlet var screenModeSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        saveUserDefaults() //save all settings
        NotificationCenter.default.removeObserver(self)
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
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
    }
    
    
    override func viewWillAppear(_ animated: Bool){
       print ("Info View Appear")
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
    
    @IBAction func screenModeChange(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            screenTheme = 0
            setStyle(daytime: true)
            updateScreen()
            print ("Light Theme")
        case 1:
            screenTheme = 1
            setStyle(daytime: false)
            updateScreen()
            print ("Dark Theme")
        case 2:
            screenTheme = 2
            let partOfDay = checkPartOfTheDay()
            // Return 0 = Day
            // Return 1 = Night
            // Return 2 = Sleep
            if partOfDay == 0 {
                setStyle(daytime: true)
            }
            else{
                setStyle(daytime: false)
            }
            updateScreen()
            print ("Auto Theme")
            
        default:
            print ("ERROR - I received an unkown tag number for theme")
            break
        }
    }
    
    //BEGIN - this function returns a clean time string based on the double containing the minutes
    func returntimeString(timeValue:Double)-> (String){
        
        let minutes = Int(timeValue.truncatingRemainder(dividingBy:60))
        let hours = Int(timeValue/60)
        
        let calendar = Calendar.current
        let now = Date()
        
        let selectedTime = calendar.date(
            bySettingHour: hours,
            minute: minutes,
            second: 0,
            of: now)!
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        // get the date time String from the date object
        let newString = formatter.string(from: selectedTime) // October 8, 2016 at 10:48:53 PM
        return newString
    }
    //END
    @IBAction func dayTimeStepper(_ sender: UIStepper) {
        dayTime = Double(sender.value)
        dayTimeSettingsLbl.text = NSLocalizedString("Day time start at: ", comment: "") + returntimeString(timeValue:dayTime)
        
    }
    @IBAction func sleepTimeStepper(_ sender: UIStepper) {
        sleepTime = Double(sender.value)
        sleepTimeSettingsLbl.text = NSLocalizedString("Night time start at: ", comment: "") + returntimeString(timeValue:sleepTime)
    }
    @IBAction func nightTimeStepper(_ sender: UIStepper) {
        nightTime = Double(sender.value)
        nightTimeSettingsLbl.text = NSLocalizedString("Evening time start at: ", comment: "") + returntimeString(timeValue:nightTime)
        
    }
    
    @IBAction func dayTimeScreenBrightnessChange(_ sender: UISlider) {
        screenDayTimeBrightness = (sender.value)
        UIScreen.main.brightness = CGFloat(screenDayTimeBrightness)
    }
    
    @IBAction func nighTimeScreenBrightnessChange(_ sender: UISlider) {
        screenNightTimeBrightness = (sender.value)
        UIScreen.main.brightness = CGFloat(screenNightTimeBrightness)
    }
    
    @IBAction func sleepScreenBrightnessChange(_ sender: UISlider) {
        screenSleepTimeBrightness = (sender.value)
        UIScreen.main.brightness = CGFloat(screenSleepTimeBrightness)
    }
    
    func updateScreen(){
        topHeaderLbl.textColor = mainTextColor
        topHeaderLbl.text = NSLocalizedString("Screen Brightness Settings", comment: "")
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
        
        backgroundImageView?.image = backgroundImage
        
        brightnessMinImg0?.image = brightnessMinImage
        brightnessMaxImg0?.image = brightnessMaxImage
        brightnessMinImg1?.image = brightnessMinImage
        brightnessMaxImg1?.image = brightnessMaxImage
        brightnessMinImg2?.image = brightnessMinImage
        brightnessMaxImg2?.image = brightnessMaxImage
        
        dayScreenBrightnessSld.value   = Float(screenDayTimeBrightness)
        nightScreenBrightnessSld.value = Float(screenNightTimeBrightness)
        sleepScreenBrightnessSld.value = Float(screenSleepTimeBrightness)
        
        dayTimeStepperValue.value = dayTime
        dayTimeLbl.text = returntimeString(timeValue:dayTime)
        
        nightTimeStepperValue.value = nightTime
        nightTimeLbl.text = returntimeString(timeValue:nightTime)
        
        sleepTimeStepperValue.value = sleepTime
        sleepTimeLbl.text = returntimeString(timeValue:sleepTime)
       
        themeLbl.textColor = mainTextColor
        themeLbl.text = NSLocalizedString("Screen theme:", comment: "")
        
        dayTimeLbl.textColor = mainTextColor
        dayTimeLbl.text = NSLocalizedString("Day mode screen brightness:", comment: "")
        
        nightTimeLbl.textColor = mainTextColor
        nightTimeLbl.text = NSLocalizedString("Evening mode screen Brightness:", comment: "")
        
        sleepTimeLbl.textColor = mainTextColor
        sleepTimeLbl.text = NSLocalizedString("Night mode screen Brightness:", comment: "")
        
        dayTimeSettingsLbl.textColor = mainTextColor
        nightTimeSettingsLbl.textColor = mainTextColor
        sleepTimeSettingsLbl.textColor = mainTextColor
        
        dayScreenBrightnessSld.tintColor     = mainTextColor
        nightScreenBrightnessSld.tintColor   = mainTextColor
        sleepScreenBrightnessSld.tintColor   = mainTextColor
        
        dayTimeStepperValue.tintColor   = mainTextColor
        dayTimeStepper(dayTimeStepperValue)
        
        nightTimeStepperValue.tintColor   = mainTextColor
        nightTimeStepper(nightTimeStepperValue)
        
        sleepTimeStepperValue.tintColor   = mainTextColor
        sleepTimeStepper(sleepTimeStepperValue)
        
        screenModeSC.selectedSegmentIndex = screenTheme
        
        screenModeSC.backgroundColor = windowColor
        if #available(iOS 13.0, *) {
            screenModeSC.selectedSegmentTintColor = attentionTextColor
        } else {
            // Fallback on earlier versions
            screenModeSC.backgroundColor = windowColor
            screenModeSC.tintColor = mainTextColor
        }
        
        let font = UIFont.systemFont(ofSize: 20)
        screenModeSC.setTitleTextAttributes([NSAttributedString.Key.font: font],for: .normal)
        
        screenModeSC.layer.borderColor = mainTextColor.cgColor
        screenModeSC.layer.borderWidth = 1
        
        
        screenModeSC.setTitle((NSLocalizedString("Light theme", comment: "")), forSegmentAt: 0)
        screenModeSC.setTitle((NSLocalizedString("Dark theme", comment: "")), forSegmentAt: 1)
        screenModeSC.setTitle((NSLocalizedString("Auto switching", comment: "")), forSegmentAt: 2)
        
    }
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close View")
        self.dismiss(animated: true, completion: nil)
    }
}
