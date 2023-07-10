//
//  AlarmViewController.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 7/9/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit



class AlarmViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var calendarAlarmTableView: UITableView?
    @IBOutlet var popupView: UIView!
    
    var eventAlarmValues: [Double] = [0, -300,  -1800,  -3600,  -7200,  -86400, -172800, -604800, -1209600, -2419200] //In seconds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarAlarmTableView!.separatorColor = tableSeperatorColor
        calendarAlarmTableView!.backgroundColor = windowColor
        
        popupView!.layer.shadowColor = UIColor.black.cgColor
        popupView!.layer.shadowOpacity = shadowOpacityView
        popupView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        popupView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        popupView?.backgroundColor    = windowColor
        popupView?.layer.cornerRadius = cornerRadiusWindow
        popupView?.layer.borderWidth  = borderWidthWindow
        popupView?.layer.borderColor  = borderColor.cgColor
        let nib2 = UINib.init(nibName: "AlarmTableViewCell", bundle: nil)
        self.calendarAlarmTableView!.register(nib2, forCellReuseIdentifier: "AlarmTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerSegue")
        performSegue(withIdentifier: "TimerSegue", sender: nil)
    }
    //END
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        //BEGIN - Remove all notifications
        NotificationCenter.default.removeObserver(self)
        //END
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return eventAlarmValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = calendarAlarmTableView!.dequeueReusableCell(withIdentifier: "AlarmTableViewCell", for: indexPath) as! AlarmTableViewCell
        cell.alarmLbl.text = convertSecondsInAlarmStr(seconds: Int(eventAlarmValues[indexPath.row]))
        
        //eventAlarmLabels[indexPath.row]
        cell.alarmLbl.textColor = mainTextColor
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none //do not show a selection color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //userSelectedAlarm = indexPath.row
        userSelectedAlarmSeconds = eventAlarmValues[indexPath.row]
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = buttonPressedColor
        
        
        
        NotificationCenter.default.post(name: Notification.Name("updateEventNotification"), object: nil, userInfo: ["key":"value"])
        closeScreen()
        
    }
    
    @IBAction func closeScreen(){
        self.dismiss(animated: true, completion: nil)
}

}
