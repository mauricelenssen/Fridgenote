//
//  CalendarDurationVC.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 4/9/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit



class CalendarDurationVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var popupView: UIView?
    @IBOutlet var calendarEventDurationtableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarEventDurationtableView!.separatorColor = tableSeperatorColor
        calendarEventDurationtableView!.backgroundColor = windowColor
        
        popupView!.layer.shadowColor = UIColor.black.cgColor
        popupView!.layer.shadowOpacity = shadowOpacityView
        popupView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        popupView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        popupView?.backgroundColor    = windowColor
        popupView?.layer.cornerRadius = cornerRadiusWindow
        popupView?.layer.borderWidth  = borderWidthWindow
        popupView?.layer.borderColor  = borderColor.cgColor
        
        let nib3 = UINib.init(nibName: "CalendarEventDurationTableViewCell", bundle: nil)
        self.calendarEventDurationtableView!.register(nib3, forCellReuseIdentifier: "CalendarEventDurationTableViewCell")
        
        //BEGIN - Fill array with duration text, I do it heare so it is faster tan to put it in table function
        eventDurationLabels.removeAll()
        for x in  0..<eventDurationMinuteValues.count{
            eventDurationLabels.append(updateDurationString (min: eventDurationMinuteValues[x], hour: eventDurationHoursValues[x], day:eventDurationDaysValues[x], month: eventDurationMonthsValues[x], year: eventDurationYearValues[x]))
         }
        //END
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool){
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
    
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
    
    

    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        //BEGIN - Remove all notifications
        NotificationCenter.default.removeObserver(self)
        //END
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print ("user selected \(eventDurationLabels[indexPath.row])")
        userSelectedEventDuration = indexPath.row
        
        var dateComponent = DateComponents()
        dateComponent.minute = eventDurationMinuteValues[indexPath.row]
        dateComponent.hour = eventDurationHoursValues[indexPath.row]
        dateComponent.day = eventDurationDaysValues[indexPath.row]
        dateComponent.month = eventDurationMonthsValues[indexPath.row]
        dateComponent.year = eventDurationYearValues[indexPath.row]
        eventStopDate = Calendar.current.date(byAdding: dateComponent, to: eventStartDate)!
        
        userSelectedAllDay = false
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
        return eventDurationLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = calendarEventDurationtableView!.dequeueReusableCell(withIdentifier: "CalendarEventDurationTableViewCell", for: indexPath) as! CalendarEventDurationTableViewCell
        cell.calendarEventDurationLbl.text = eventDurationLabels[indexPath.row]
        cell.calendarEventDurationLbl.textColor = mainTextColor
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none //do not show a selection color
        return cell
    }
    
    @IBAction func closeScreen(){
        self.dismiss(animated: true, completion: nil)
    }
}
