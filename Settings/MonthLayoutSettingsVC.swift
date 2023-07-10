//
//  MonthLayoutSettingsVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 21/11/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class MonthLayoutSettingsVC: UIViewController {
    @IBOutlet var topHeaderView: UIView!
    @IBOutlet var topHeaderImg: UIImageView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var topHeaderLbl: UILabel!
    @IBOutlet var weekStartLbL: UILabel!
    //END
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var settingsWindowView: UIView!
    @IBOutlet var startOfWeekSC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool){
        print ("Month Layout View Appear")
        //UINavigationBar.appearance().backgroundColor = .green        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        //END
        
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in settings screen
        
        updateScreen()
       
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
        }
    
    func updateScreen(){
        topHeaderLbl.textColor = mainTextColor
        topHeaderLbl.text = NSLocalizedString("Month View Layout", comment: "")
        
        
        weekStartLbL.textColor = mainTextColor
        weekStartLbL.text = NSLocalizedString("Start week on:", comment: "")
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
        
        startOfWeekSC.backgroundColor = windowColor
        if #available(iOS 13.0, *) {
            startOfWeekSC.selectedSegmentTintColor = attentionTextColor
        } else {
            // Fallback on earlier versions
            startOfWeekSC.backgroundColor = windowColor
            startOfWeekSC.tintColor = mainTextColor
        }
        
        let font = UIFont.systemFont(ofSize: 20)
        startOfWeekSC.setTitleTextAttributes([NSAttributedString.Key.font: font],for: .normal)
        
        startOfWeekSC.layer.borderColor = mainTextColor.cgColor
        startOfWeekSC.layer.borderWidth = 1
      
        
        let fmt1 = DateFormatter()
        let weekSymbols = fmt1.shortWeekdaySymbols
        startOfWeekSC.selectedSegmentIndex = weekStartDay-1
        
        //Sun, Mon, Tue, Wed, Thu, Fri, Sat
        startOfWeekSC.setTitle((NSLocalizedString(weekSymbols![0], comment: "")), forSegmentAt: 0)
        startOfWeekSC.setTitle((NSLocalizedString(weekSymbols![1], comment: "")), forSegmentAt: 1)
        startOfWeekSC.setTitle((NSLocalizedString(weekSymbols![2], comment: "")), forSegmentAt: 2)
        startOfWeekSC.setTitle((NSLocalizedString(weekSymbols![3], comment: "")), forSegmentAt: 3)
        startOfWeekSC.setTitle((NSLocalizedString(weekSymbols![4], comment: "")), forSegmentAt: 4)
        startOfWeekSC.setTitle((NSLocalizedString(weekSymbols![5], comment: "")), forSegmentAt: 5)
        startOfWeekSC.setTitle((NSLocalizedString(weekSymbols![6], comment: "")), forSegmentAt: 6)
     }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    @IBAction func startOfweekChange(_ sender: UISegmentedControl) {
        weekStartDay = sender.selectedSegmentIndex+1
        
        
    }
    
    
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close View")
        saveUserDefaults()
        self.dismiss(animated: true, completion: nil)
    }
}
