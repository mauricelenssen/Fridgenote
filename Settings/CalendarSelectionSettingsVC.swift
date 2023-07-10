//
//  CalendarSelectionSettingsVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 8/7/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit

class CalendarSelectionSettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //BEGIN - Header Controls
    @IBOutlet var topHeaderView: UIView!
    @IBOutlet var topHeaderImg: UIImageView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var topHeaderLbl: UILabel!
    //END
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var settingsWindowView: UIView!
    @IBOutlet var calendarSelectionLbl: UILabel!
    @IBOutlet var todayCalendarSelectionLbl: UILabel!
    @IBOutlet var calendarList: UITableView!
    @IBOutlet var todayCalendarList: UITableView!
    @IBOutlet var eventAttentionLbl: UILabel!
    @IBOutlet var eventAttentionSwitch: UISwitch!
    
    
    @objc func screenModeHasChanged()
    {
        print ("I updated the screen MODE")
        updateScreen()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib1 = UINib.init(nibName: "CalendarNameTableViewCell", bundle: nil)
        self.calendarList!.register(nib1, forCellReuseIdentifier: "CalendarNameTableViewCell")
        
        let nib2 = UINib.init(nibName: "TodayCalendarTableViewCell", bundle: nil)
        self.todayCalendarList!.register(nib2, forCellReuseIdentifier: "TodayCalendarTableViewCell")
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Settings EXIT - Stop notification")
        //BEGIN update the user defaults list with only tick calendar ID's for 'Upcoming Calendar' Tile
        birthdayCalendarsSelected.removeAll()
        birthdayCalendars.removeAll()
        
        for x in 0..<userCalendarListID.count{
            if userCalendarListTick[x] == true {
                birthdayCalendarsSelected.append(userCalendarListID[x])
                
                if eventAccessApproved {
                    birthdayCalendars.append(eventStore.calendar(withIdentifier: userCalendarListID[x])!)
                }
            }
        }
        //END
        
        //BEGIN update the user defaults list with only tick calendar ID's for Today Tile
        
        dayCalendarsSelected.removeAll()
        userDayCalendars.removeAll()
        
        for x in 0..<userCalendarListID1.count{
            if userCalendarListTick1[x] == true {
                dayCalendarsSelected.append(userCalendarListID1[x])
                if eventAccessApproved {
                    userDayCalendars.append(eventStore.calendar(withIdentifier: userCalendarListID1[x])!)
                }
            }
        }
        //END
        
        saveUserDefaults() //save all settings
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // Table View Functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == calendarList {
            let calendarData = readUserCalendarData()
            if isCalendarSelectedByUser(calendarID: calendarData.id[indexPath.row]) == true
            {
                calendarNotSelectedByUser (calendarID: calendarData.id[indexPath.row])
            }
            else {
                calendarSelectedByUser (calendarID: calendarData.id[indexPath.row])
            }
            //let calendarNames = calendarData.name
            //print ("user picker calendar \(indexPath.row) | \(calendarNames[indexPath.row])")
            calendarList.reloadData()
        }
        
        if tableView == todayCalendarList {
            let calendarData = readUserCalendarData()
            let calendarNames = calendarData.name
            
            if isCalendarSelectedByUser1(calendarID: calendarData.id[indexPath.row]) == true
            {
                calendarNotSelectedByUser1 (calendarID: calendarData.id[indexPath.row])
            }
            else {
                calendarSelectedByUser1 (calendarID: calendarData.id[indexPath.row])
            }
            
            print ("user picker calendar \(indexPath.row) | \(calendarNames[indexPath.row])")
            todayCalendarList.reloadData()
        }
    }
    
    //Function for Today calendar only
    func isCalendarSelectedByUser1 (calendarID: String)-> Bool {
        var temp = false
        for x in 0..<userCalendarListID1.count{
            if userCalendarListID1[x] == calendarID {
                temp = userCalendarListTick1[x]
            }
        }
        return temp
    }
    
    func calendarSelectedByUser1 (calendarID: String){
        for x in 0..<userCalendarListID1.count{
            if userCalendarListID1[x] == calendarID {
                userCalendarListTick1[x] = true
            }
        }
    }
    
    func calendarNotSelectedByUser1 (calendarID: String){
        for x in 0..<userCalendarListID1.count{
            if userCalendarListID1[x] == calendarID {
                userCalendarListTick1[x] = false
            }
        }
    }
    //end
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == calendarList {
            let calendarData = readUserCalendarData()
            return calendarData.name.count
        }
        
        if tableView == todayCalendarList {
            let calendarData = readUserCalendarData()
            return calendarData.name.count
        }
        print ("ERROR - numverInRowsInSection")
        return -1 // Bug prone
    }
    
    //Function for upcoming calendar only
    func isCalendarSelectedByUser (calendarID: String)-> Bool {
        var temp = false
        for x in 0..<userCalendarListID.count{
            if userCalendarListID[x] == calendarID {
                temp = userCalendarListTick[x]
            }
        }
        return temp
    }
    
    func calendarSelectedByUser (calendarID: String){
        for x in 0..<userCalendarListID.count{
            if userCalendarListID[x] == calendarID {
                userCalendarListTick[x] = true
            }
        }
    }
    
    func calendarNotSelectedByUser (calendarID: String){
        for x in 0..<userCalendarListID.count{
            if userCalendarListID[x] == calendarID {
                userCalendarListTick[x] = false
            }
        }
    }
    //END
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        var tableCell: UITableViewCell?
        
        if tableView == calendarList {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarNameTableViewCell", for: indexPath) as! CalendarNameTableViewCell
            let calendarData = readUserCalendarData()
            let calendarNames = calendarData.name
            let calendarTypes = calendarData.type
            let calendarID = calendarData.id
            let calendarColors = calendarData.calendarColor
            //BEGIN - place tick box next to selected calender
            
            let tick = isCalendarSelectedByUser (calendarID: calendarID[indexPath.row])
            
            if tick == true
            {
                cell.calendarSelectionIv.image = UIImage(named: "TickSelected")?.withRenderingMode(.alwaysTemplate)
                cell.calendarSelectionIv.tintColor = UIColor.init(cgColor: calendarColors[indexPath.row])
            }
            else{
                cell.calendarSelectionIv.image = UIImage(named: "TickNotSelected")?.withRenderingMode(.alwaysTemplate)
                cell.calendarSelectionIv.tintColor = UIColor.init(cgColor: calendarColors[indexPath.row])
            }
            //END
            
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            
            cell.calendarNameLbl?.textColor = mainTextColor
            cell.calendarTypeLbl?.textColor = subTextColor
            
            cell.calendarNameLbl?.text = calendarNames[indexPath.row]
            
            switch (calendarTypes[indexPath.row]) {
            case 0:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Local", comment:"")
            case 1:
                cell.calendarTypeLbl?.text =  NSLocalizedString("iCloud", comment:"")
            case 2:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Exchange", comment:"")
            case 3:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Subscription", comment:"")
            case 4:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Birthday", comment:"")
            case 5:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Found in Mail", comment:"")
            default:
                cell.calendarTypeLbl?.text =  String ("Unknown Type!")
                break
            }
            tableCell = cell
        }
        
        if tableView == todayCalendarList {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayCalendarTableViewCell", for: indexPath) as! TodayCalendarTableViewCell
            let calendarData = readUserCalendarData()
            let calendarNames = calendarData.name
            let calendarTypes = calendarData.type
            let calendarColors = calendarData.calendarColor
            
            let calendarID = calendarData.id
            //BEGIN - place tick box next to selected calender
            let tick = isCalendarSelectedByUser1 (calendarID: calendarID[indexPath.row])
            
            if tick == true
            {
                cell.calendarSelectionIv.image = UIImage(named: "TickSelected")?.withRenderingMode(.alwaysTemplate)
                cell.calendarSelectionIv.tintColor = UIColor.init(cgColor: calendarColors[indexPath.row])
            }
            else{
                cell.calendarSelectionIv.image = UIImage(named: "TickNotSelected")?.withRenderingMode(.alwaysTemplate)
                cell.calendarSelectionIv.tintColor = UIColor.init(cgColor: calendarColors[indexPath.row])
            }
            //END
            
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            
            cell.calendarNameLbl?.textColor = mainTextColor
            cell.calendarTypeLbl?.textColor = subTextColor
            
            cell.calendarNameLbl?.text = calendarNames[indexPath.row]
            
            switch (calendarTypes[indexPath.row]) {
            case 0:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Local", comment:"")
            case 1:
                cell.calendarTypeLbl?.text =  NSLocalizedString("iCloud", comment:"")
            case 2:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Exchange", comment:"")
            case 3:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Subscription", comment:"")
            case 4:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Birthday", comment:"")
            case 5:
                cell.calendarTypeLbl?.text =  NSLocalizedString("Found in Mail", comment:"")
            default:
                cell.calendarTypeLbl?.text =  String ("Unknown Type!")
                break
            }
            tableCell = cell
        }
        
        return tableCell ?? UITableViewCell()
    }
    
    
    func updateScreen(){
        eventAccessApproved = EventStoreAuthorizations()
        photoAccessApproved = PhotoAuthorizations()
        backgroundImageView?.image = backgroundImage
    
        topHeaderLbl.textColor = mainTextColor
        topHeaderLbl.text = NSLocalizedString("Calendar Selection", comment: "")
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
    
        calendarSelectionLbl.textColor = mainTextColor
        calendarSelectionLbl.text = NSLocalizedString("Select the calendars to be shown in the 'Upcoming Event' window.", comment: "")
    
        todayCalendarSelectionLbl.textColor = mainTextColor
        todayCalendarSelectionLbl.text = NSLocalizedString("Select the calendars to be shown in the 'Today' window.", comment: "")
        
        //BEGIN - create a temp list to hold which calendar user picked
        let calendarData = readUserCalendarData()
        let numberOfCalendars = calendarData.name.count
        
        //fill the Temp array with all user default
        userCalendarListID.removeAll()
        userCalendarListTick.removeAll()
        
        for x in 0..<numberOfCalendars {
            
            userCalendarListID.append(calendarData.id[x])
            userCalendarListTick.append(isCalendarSelectedByUserDefaults  (calendarID: calendarData.id[x]))
        }
        //END
        
        calendarList.backgroundColor = .clear
        calendarList.separatorColor = tableSeperatorColor
        calendarList.reloadData()
    
        //BEGIN - create a temp list to hold which calendar user picked
        //let calendarData1 = readUserCalendarData()
        //let numberOfCalendars1 = calendarData.name.count
        
        //fill the Temp array with all user default
        userCalendarListID1.removeAll()
        userCalendarListTick1.removeAll()
        
        for x in 0..<numberOfCalendars {
            userCalendarListID1.append(calendarData.id[x])
            userCalendarListTick1.append(isTodayCalendarSelectedByUserDefaults (calendarID: calendarData.id[x]))
        }
        //END
        
        
        //BEGIN - Update the switches to the user defaulted state
        if colouredTodayCalendar == true {eventAttentionSwitch.isOn = true}
        else {eventAttentionSwitch.isOn = false }
        //END
        
        eventAttentionLbl.textColor = mainTextColor
        eventAttentionLbl.text = NSLocalizedString("Display events in high attention colours", comment: "")
        
        todayCalendarList.backgroundColor = .clear
        todayCalendarList.separatorColor = tableSeperatorColor
        todayCalendarList.reloadData()
    }
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close View")
        self.dismiss(animated: true, completion: nil)
    }


@IBAction func colouredTodayCalendarSwitchChange(_ sender: UISwitch) {
    if (sender.isOn == true){
        print ("Today Events to be coloured")
        colouredTodayCalendar = true
    }
    else{
        print ("Today Events classic look")
        colouredTodayCalendar = false
    }
}






}


