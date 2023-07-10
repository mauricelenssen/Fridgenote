//
//  CalendarNameVC.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 4/9/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class CalendarNameVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var calendarIDtableView: UITableView?
    @IBOutlet var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarIDtableView!.separatorColor = tableSeperatorColor
        calendarIDtableView!.backgroundColor = windowColor
        
        popupView!.layer.shadowColor = UIColor.black.cgColor
        popupView!.layer.shadowOpacity = shadowOpacityView
        popupView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        popupView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        popupView?.backgroundColor    = windowColor
        popupView?.layer.cornerRadius = cornerRadiusWindow
        popupView?.layer.borderWidth  = borderWidthWindow
        popupView?.layer.borderColor  = borderColor.cgColor
        
        let nib1 = UINib.init(nibName: "CalendarTypeTVCell", bundle: nil)
        self.calendarIDtableView!.register(nib1, forCellReuseIdentifier: "CalendarTypeTVCell")
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let calendarsOnDevice = readUserEditableCalendars()
        //BEGIN - update the Calendar ID labels and image
        
        userSelectedCalendarTintColor = UIColor.init(cgColor: calendarsOnDevice.calendarColor[indexPath.row])
        userSelectedCalendarID = calendarsOnDevice.id[indexPath.row]
        userSelectedCalendarName = calendarsOnDevice.name[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("updateEventNotification"), object: nil, userInfo: ["key":"value"])
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = buttonPressedColor
        closeScreen()
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let calendarsOnDevice = readUserEditableCalendars()
        return calendarsOnDevice.name.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = calendarIDtableView!.dequeueReusableCell(withIdentifier: "CalendarTypeTVCell", for: indexPath) as! CalendarTypeTVCell
        
        let calendarsOnDevice = readUserEditableCalendars()
        
        let calendarImageID = UIImage(named: "CellIDImg_M")?.withRenderingMode(.alwaysTemplate)
        cell.calendarTypeLbl.text = calendarsOnDevice.name[indexPath.row]
        cell.calendarTypeLbl.textColor = mainTextColor
        cell.calendarTypeImg.image = calendarImageID
        cell.calendarTypeImg.tintColor = UIColor.init(cgColor: calendarsOnDevice.calendarColor[indexPath.row])
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none //do not show a selection color
        return cell
    }
    
    @IBAction func closeScreen(){
        self.dismiss(animated: true, completion: nil)
    }
}
