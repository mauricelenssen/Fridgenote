//
//  FamilyCalendarSettingsVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 16/3/2023.
//  Copyright © 2023 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit

// The user can only seelct number of calendars, else they will fall otuside the screen
let maxNumberOfFamilyCalenders = Int((screenHeight-50-5-5-5-5-30)/105)

//BEGIN - this array hold the selected calendar ID, it is used in Family calendar table view
var calendarFamilyListID: [String] = []
var calendarFamilyListTick: [Bool] = []
var familyCalendarOrder: [EKCalendar] = []
var familyCalendarName: [String] = []
var familyCalendarColor: [CGColor] = []
var familyCalendarType: [Int] = []

//END


class FamilyCalendarSettingsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //BEGIN - Header Controls
    @IBOutlet var topHeaderView: UIView!
    @IBOutlet var topHeaderImg: UIImageView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var topHeaderLbl: UILabel!
    //END
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var settingsWindowView: UIView!
    @IBOutlet var calendarSelectionLbl: UILabel!
    
    @IBOutlet var calendarList: UITableView!
    @IBOutlet var calendarListOrdered: UITableView!
    @IBOutlet var eventAttentionLbl: UILabel!
    @IBOutlet var eventAttentionSwitch: UISwitch!
    
    
    
    @objc func screenModeHasChanged()
    {
        print ("I updated the screen MODE")
        updateScreen()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarList.isEditing = false
        self.calendarListOrdered.isEditing = true
        
        let nib1 = UINib.init(nibName: "FamilyCalendarTableViewCell", bundle: nil)
        self.calendarList!.register(nib1, forCellReuseIdentifier: "FamilyCalendarTableViewCell")
        
        let nib2 = UINib.init(nibName: "FamilyCalendarOrderedTableViewCell", bundle: nil)
        self.calendarListOrdered!.register(nib2, forCellReuseIdentifier: "FamilyCalendarOrderedTableViewCell")
    }
    

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
 
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let familyCalendarsSelectedMoved = familyCalendarsSelected[sourceIndexPath.row]
        let familyCalendarNameMoved = familyCalendarName[sourceIndexPath.row]
        let familyCalendarColorMoved = familyCalendarColor[sourceIndexPath.row]
        let familyCalendarTypeMoved = familyCalendarType[sourceIndexPath.row]
        
        familyCalendarsSelected.remove(at: sourceIndexPath.row)
        familyCalendarName.remove(at: sourceIndexPath.row)
        familyCalendarColor.remove(at: sourceIndexPath.row)
        familyCalendarType.remove(at: sourceIndexPath.row)
        
        familyCalendarsSelected.insert(familyCalendarsSelectedMoved, at: destinationIndexPath.row)
        familyCalendarName.insert(familyCalendarNameMoved, at: destinationIndexPath.row)
        familyCalendarColor.insert(familyCalendarColorMoved, at: destinationIndexPath.row)
        familyCalendarType.insert(familyCalendarTypeMoved, at: destinationIndexPath.row)
        
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
        saveUserDefaults() //save all settings
        NotificationCenter.default.removeObserver(self)
    }
    
   
    // Table View Functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let calendarData = readUserCalendarData()
        if tableView == calendarList
        {
            if isCalendarSelectedByUser(calendarID: calendarData.id[indexPath.row]) == true
            {
                //BEGIN - Remove the Calendar
                for n in 0..<familyCalendarsSelected.count
                {
                    if familyCalendarsSelected[n] == calendarData.id[indexPath.row]
                    {
                        familyCalendarsSelected.remove(at: n)
                        familyCalendarName.remove(at: n)
                        familyCalendarColor.remove(at: n)
                        familyCalendarType.remove(at: n)
                        break
                    }
                }
                //END
            }
            else
            {
                if familyCalendarsSelected.count < maxNumberOfFamilyCalenders
                {
                    //BEGIN - Add the calendar
                    familyCalendarsSelected.append(calendarData.id[indexPath.row])
                    familyCalendarName.append (calendarData.name[indexPath.row])
                    familyCalendarColor.append (calendarData.calendarColor[indexPath.row])
                    familyCalendarType.append (calendarData.type[indexPath.row])
                    //END
                }
            }
        }
        else
        {
            print ("other table Selected")
       }
        calendarList.reloadData()
        calendarListOrdered.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == calendarList
        {
            let calendarData = readUserCalendarData()
            return calendarData.name.count
        }
        else
        {
            return familyCalendarName.count
        }
    }
    
    //Function for upcoming calendar only
    func isCalendarSelectedByUser (calendarID: String)-> Bool
    {
        for x in 0..<familyCalendarsSelected.count
        {
            if familyCalendarsSelected[x] == calendarID
            {
                return true
            }
        }
        return false
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        if tableView == calendarList
        {
            var tableCell: UITableViewCell?
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyCalendarTableViewCell", for: indexPath) as! FamilyCalendarTableViewCell
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
            return tableCell ?? UITableViewCell()
        }
        else
        {
            var tableCell: UITableViewCell?
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyCalendarOrderedTableViewCell", for: indexPath) as! FamilyCalendarOrderedTableViewCell
            
            
            
            //cell.contentView.backgroundColor = .clear
            //cell.backgroundColor = .clear
            
            let cellColour = UIColor.init(cgColor: familyCalendarColor[indexPath.row])
            cell.backgroundColor = cellColour
            var subColour = mainTextColor
            if cellColour.isDarkColor
            {
                subColour = cellColour.lighter()
            }
            else
            {
                subColour = cellColour.darker()
            }
            
            cell.calendarNameLbl?.textColor = subColour
            cell.calendarTypeLbl?.textColor = subColour
            
            cell.contentView.backgroundColor = cellColour
            cell.backgroundColor = cellColour
            
            
            cell.calendarNameLbl?.text = familyCalendarName[indexPath.row]
            
            switch (familyCalendarType[indexPath.row]) {
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
            return tableCell ?? UITableViewCell()
        }
    }
    
    
    func updateScreen(){
        eventAccessApproved = EventStoreAuthorizations()
        photoAccessApproved = PhotoAuthorizations()
        backgroundImageView?.image = backgroundImage
    
        topHeaderLbl.textColor = mainTextColor
        topHeaderLbl.text = NSLocalizedString("Calendar Overview", comment: "")
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
        calendarSelectionLbl.text = NSLocalizedString("Select up to ", comment: "") + ("\(maxNumberOfFamilyCalenders)") + NSLocalizedString(" calendars in order to show in the 'Calendar Overview' window.", comment: "") 
    
        calendarList.backgroundColor = .clear
        calendarList.separatorColor = tableSeperatorColor
        
        calendarListOrdered.backgroundColor = .clear
        calendarListOrdered.separatorColor = tableSeperatorColor
        
        eventAttentionLbl.textColor = mainTextColor
        eventAttentionLbl.text = NSLocalizedString("Display events in high attention colours", comment: "")
        
        
        //BEGIN - Update the switches to the user defaulted state
        if colouredFamilyCalendar == true {eventAttentionSwitch.isOn = true}
        else {eventAttentionSwitch.isOn = false }
        //END
        calendarList.reloadData()
        //END
        
        
    }
    
    @IBAction func colouredFamilyCalendarSwitchChange(_ sender: UISwitch) {
        if (sender.isOn == true){
            print ("Calendar Events to be coloured")
            colouredFamilyCalendar = true
        }
        else{
            print ("Calendar Events classic look")
            colouredFamilyCalendar = false
        }
    }
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close View")
        self.dismiss(animated: true, completion: nil)
    }
}


