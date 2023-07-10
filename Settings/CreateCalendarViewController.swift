//
//  CreateCalendarViewController.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 15/7/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit

var calendarNames: Array<String> = []
var calendarTypes: Array<Int> = []
var calendarIDs:  Array<String> = []
var calendarColor:  Array<CGColor> = []
var calendarSelectedID: String = ""
var calendarSelected: Array<Bool> = []
var userWantToCreateNewCalendar:Bool = true //used so when you segue to nodify the calendar it knows to create a new one or not

class CreateCalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
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
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var updateBtn: UIButton!
    @IBOutlet var createBtn: UIButton!
    
    
    @objc func screenModeHasChanged()
        {
            print ("I updated the screen MODE")
            updateScreen()
            //updateCalendarData()
        }
    
    
    override func viewWillAppear(_ animated: Bool){
        updateCalendarData()
        
        
        let nib = UINib.init(nibName: "CalendarCreationTableViewCell", bundle: nil)
        self.calendarList!.register(nib, forCellReuseIdentifier: "CalendarCreationTableViewCell")
        
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //BEGIN - Update the calendar List as user deleted it and the list has to be updated
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateCalendarListRequested), name: Notification.Name("DeleteCalendarNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        //END
        
        
        
        
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in settings screen
        eventAccessApproved = EventStoreAuthorizations()
        photoAccessApproved = PhotoAuthorizations()
        updateScreen()
    }
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        
        NotificationCenter.default.removeObserver(self) //Remove All notifications
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerSegue")
        performSegue(withIdentifier: "TimerSegue", sender: nil)
    }
    //END
    
    // BEGIN - Update the calendar List as user updated/deleted a calendar in the other viewcontroller.
    @objc func updateCalendarListRequested(){
        print("Update the Calendar List Notification received")
        updateCalendarData()
        calendarList.reloadData()
    }
    
    
    
    
    func updateScreen(){
        topHeaderLbl.textColor = mainTextColor
        topHeaderLbl.text = NSLocalizedString("Calendar Creation or Edit", comment: "")
        topHeaderImg?.image = topHeaderImage
        
        deleteBtn?.setImage(deletePopupBtnImage, for: .normal)
        deleteBtn?.setImage(deletePopupBtnPressedImage, for: .highlighted)
        deleteBtn!.layer.shadowColor = UIColor.black.cgColor
        deleteBtn!.layer.shadowOpacity = shadowOpacityButtons
        deleteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        deleteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        updateBtn?.setImage(updateButtonImage, for: .normal)
        updateBtn?.setImage(updatePressedButtonImage, for: .highlighted)
        updateBtn!.layer.shadowColor = UIColor.black.cgColor
        updateBtn!.layer.shadowOpacity = shadowOpacityButtons
        updateBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        updateBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        createBtn?.setImage(addCalendarEventImage, for: .normal)
        createBtn?.setImage(addCalendarEventPressedImage, for: .highlighted)
        createBtn!.layer.shadowColor = UIColor.black.cgColor
        createBtn!.layer.shadowOpacity = shadowOpacityButtons
        createBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        createBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
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
        calendarSelectionLbl.textColor = mainTextColor
        calendarSelectionLbl.text = NSLocalizedString("Select the calendar to Edit.", comment: "")

        calendarList.backgroundColor = .clear
        
        calendarList.separatorColor = tableSeperatorColor
        calendarList.reloadData()
    
        
        //END
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = buttonPressedColor
        calendarSelectedID = calendarIDs[indexPath.row]
        updateCalendarData()
        
        calendarSelected[indexPath.row] = true
        calendarList.reloadData()
        print ("Selected Calendar Name is: \(calendarNames[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let calendarData = readUserCalendarData()
        return calendarData.name.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCreationTableViewCell", for: indexPath) as! CalendarCreationTableViewCell
            
        //BEGIN - place tick box next to selected calender
        if calendarSelected[indexPath.row]
        {
            cell.calendarIDIv.image = UIImage(named: "TickSelected")?.withRenderingMode(.alwaysTemplate)
            cell.calendarIDIv.tintColor = UIColor.init(cgColor: calendarColor[indexPath.row])
        }
        else{
            cell.calendarIDIv.image = UIImage(named: "TickNotSelected")?.withRenderingMode(.alwaysTemplate)
            cell.calendarIDIv.tintColor = UIColor.init(cgColor: calendarColor[indexPath.row])
        }
        
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none //do not show a selection color
        
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
        return cell
    }
    
    @IBAction func createCalendarButtonPressed()
    {
        userWantToCreateNewCalendar = true
        performSegue(withIdentifier: "CalendarEditSegue", sender: nil)
    }
    
    @IBAction func modifyCalendarButtonPressed()
    {
        userWantToCreateNewCalendar = false
        //You need to do this, else when NO calendar is selected, it wil use the previous one.
        var userSelectedCalendar: Bool = false
        if calendarSelected.count != 0
        {
            for x in 0..<calendarNames.count{
                if calendarSelected[x] {
                    userSelectedCalendar = true
                }
            }
        }
        if userSelectedCalendar {performSegue(withIdentifier: "CalendarEditSegue", sender: nil) }
        
    }
    
    @IBAction func deleteCalendarButtonPressed()
    {
        //You need to do this, else when NO calendar is selected, it wil use the previous one.
        var userSelectedCalendar: Bool = false
        if calendarSelected.count != 0
        {
            for x in 0..<calendarNames.count{
                if calendarSelected[x] {
                    userSelectedCalendar = true
                }
            }
        }
        if userSelectedCalendar {performSegue(withIdentifier: "DeleteCalendarPopupSegue", sender: nil) }
    }
    
    func createNewCalendar(withName: String) {
        if eventAccessApproved {
            let calendar = EKCalendar(for: .event, eventStore: eventStore)
            
            calendar.title = withName
            calendar.cgColor = UIColor.purple.cgColor
            
            guard let source = bestPossibleEKSource() else {
                return // source is required, otherwise calendar cannot be saved
            }
            calendar.source = source
            try! eventStore.saveCalendar(calendar, commit: true)
        }
        updateCalendarData()
   }
    
    func bestPossibleEKSource() -> EKSource? {
        
        let `default` = eventStore.defaultCalendarForNewEvents?.source
        let iCloud = eventStore.sources.first(where: { $0.title == "iCloud" }) // this is fragile, user can rename the source
        let local = eventStore.sources.first(where: { $0.sourceType == .local })
        
        return `default` ?? iCloud ?? local
    }
   
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close View")
        self.dismiss(animated: true, completion: nil)
    }

    func updateCalendarData()
    {
        let calendarData = readUserCalendarData()
        calendarNames = calendarData.name
        calendarTypes = calendarData.type
        calendarIDs = calendarData.id
        calendarColor = calendarData.calendarColor
        calendarSelected.removeAll()
        for _ in 0..<calendarNames.count {
            calendarSelected.append(false)
        }
    }
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
}
