//
//  TimerExpired2ViewController.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 30/5/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import AVFoundation

var alarmTimer: Timer?
var numberofAlarmCounter:Int = 0    //this counts the number of times the alarm has ring when timer expires



class TimerExpired2ViewController: UIViewController {

    @IBOutlet weak var alarmIV: UIImageView!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        print ("View will appear, Kitchen Timer Loop")
        AudioServicesPlaySystemSound (systemSoundID) //Play Alarm
        
        //BEGIN - Start the 2 sec Timer, for playing alarm sound
        numberofAlarmCounter = 0 //Reset the Alarm counter
        alarmTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.playAlarmSound), userInfo: nil, repeats: true)
        //END
        //alarmIV.shake()
    }
    
    override func viewDidLayoutSubviews() {
        //BEGIN copied from https://stackoverflow.com/questions/27987048/shake-animation-for-uitextfield-uiview-in-swift
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 1000
        animation.autoreverses = true
        
        animation.fromValue = NSValue(cgPoint: CGPoint(x: alarmIV.center.x - 10, y: alarmIV.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: alarmIV.center.x + 10, y: alarmIV.center.y))
        alarmIV.layer.add(animation, forKey: "position")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("View will disappear, Kitchen Timer Loop")
        alarmTimer?.invalidate()
    }
    
    
    
    @objc func playAlarmSound (){
        if numberofAlarmCounter < numberOfAlarmRepeats-1 {
            AudioServicesPlaySystemSound (systemSoundID) //Play Alarm
            numberofAlarmCounter = numberofAlarmCounter+1
        }
    }
    
    @IBAction func screenPressed(_ sender: Any) {
        screenSaverAllowed = true // allow the screensaver after the timer expired
        timerExpired = false
        timerRunning = false
        timerSeconds = 0
        self.dismiss(animated: true, completion: nil)
     }
}
