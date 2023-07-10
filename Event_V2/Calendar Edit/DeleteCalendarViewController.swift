//
//  DeleteCalendarViewController.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 7/7/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit


class DeleteCalendarViewController: UIViewController {
    @IBOutlet var calendarInfoView: UIView!
    
    @IBOutlet var deletePopupView: UIView!
    @IBOutlet var deletePopupLbl: UILabel!
    
    @IBOutlet var eventNameLbl: UILabel!
    //@IBOutlet var allDayLbl: UILabel!
    //@IBOutlet var allDayTickImg: UIImageView?
    @IBOutlet var startDateLbl: UILabel!
    @IBOutlet var startDateHeaderLbl: UILabel!
    @IBOutlet var stopDateHeaderLbl: UILabel!
    @IBOutlet var stopDateLbl: UILabel!
    
    
    @IBOutlet var calendarNameHeaderLbl: UILabel!
    @IBOutlet var calendarIDImg: UIImageView!
    @IBOutlet var calendarNameLbl: UILabel!
    @IBOutlet var spinnerIV: UIImageView!
    
    //@IBOutlet var repeatLbl: UILabel!
    //@IBOutlet var alarmLbl: UILabel!
    //@IBOutlet var alarmTickImg: UIImageView?
    
    @IBOutlet var deleteEventBtn: UIButton!
    @IBOutlet var cancelEventBtn: UIButton!
    @IBOutlet var updateEventBtn: UIButton!
    //@IBOutlet var deleteActivitySpinner: UIActivityIndicatorView!
    
    @IBOutlet var eventDurationHeaderLbl: UILabel!
    @IBOutlet var eventDurationLbl: UILabel!
    @IBOutlet var eventAlarmHeaderLbl: UILabel!
    @IBOutlet var eventAlarmLbl: UILabel!
    @IBOutlet var eventRepeatHeaderLbl: UILabel!
    @IBOutlet var eventRepeatLbl: UILabel!
    var closeTimer: Timer? = nil
    
    var activityTimer: Timer? = nil
    var errorCounter: Int = 0
    
    func recurenceTextOfEventID(reqEventID:String ) -> String{
        //let eventToCheck = eventStore.event(withIdentifier:reqEventID)
        var recurrenceReturnString = "Custom"
        let selectedEvent = readCalendarEventWithID(reqEventID:reqEventID)
        var selectedRecurrence = Recurrence()
        //BEGIN - only read a recurrence if there is one, else the app will crash
        if selectedEvent.hasRecurrence {selectedRecurrence = readCalendarRecurrenceEventWithID(reqEventID: reqEventID)
            recurrenceReturnString = recurrenceText (recurrence: selectedRecurrence)
        }
        else
        {
            recurrenceReturnString = "\(NSLocalizedString("None", comment: ""))"
        }
        return recurrenceReturnString
        //END
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calendarInfoView!.layer.shadowColor = UIColor.black.cgColor
        calendarInfoView!.layer.shadowOpacity = shadowOpacityView
        calendarInfoView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        calendarInfoView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        calendarInfoView?.backgroundColor    = windowColor
        calendarInfoView?.layer.cornerRadius = cornerRadiusWindow
        calendarInfoView?.layer.borderWidth  = borderWidthWindow
        calendarInfoView?.layer.borderColor  = borderColor.cgColor
        
        deletePopupView!.layer.shadowColor = UIColor.black.cgColor
        deletePopupView!.layer.shadowOpacity = shadowOpacityView
        deletePopupView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        deletePopupView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        deletePopupView!.backgroundColor    = windowColor
        deletePopupView!.layer.cornerRadius = cornerRadiusWindow
        deletePopupView!.layer.borderWidth  = borderWidthWindow
        deletePopupView!.layer.borderColor  = borderColor.cgColor
       
        
        let selectedEvent = readCalendarEventWithID(reqEventID:userSelectedEventID)
        //let selectedEvent = eventStore.event(withIdentifier: userSelectedEventID)
        //deleteActivitySpinner.isHidden = true //hide the activity indicator when poup appears
        spinnerIV.isHidden = true //hide the delete spinner
        deletePopupLbl.textColor = mainTextColor
        deletePopupLbl.text = NSLocalizedString("Deleting Calendar", comment: "")
        
        eventNameLbl.textColor = mainTextColor
        eventNameLbl.text = selectedEvent.eventName
        
        
        //BEGIN - Event Duration
        eventDurationHeaderLbl.textColor = subTextColor
        eventDurationHeaderLbl.text = NSLocalizedString("Duration:", comment: "")
        
        //Alarm
        eventAlarmHeaderLbl?.textColor = subTextColor
        eventAlarmHeaderLbl.text = NSLocalizedString("Alarm:", comment: "")
        eventAlarmLbl?.textColor = mainTextColor
        eventAlarmLbl.text = convertSecondsInAlarmStr(seconds: selectedEvent.alarmSeconds)
        //END
        
        //BEGIN - Recurrence
        eventRepeatHeaderLbl.textColor = subTextColor
        eventRepeatHeaderLbl.text = NSLocalizedString("Repeat:", comment: "")
    
        eventRepeatLbl.textColor = mainTextColor
        eventRepeatLbl.text = recurenceTextOfEventID(reqEventID: userSelectedEventID)
        //eventRepeatLbl.sizeToFit()
        
        //END
        
        //Start/Stop Date
        let dateFormatter = DateFormatter()
        if selectedEvent.allDayEvent {
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EdMMMYY", options: 0, locale: Locale.current)
            eventDurationLbl?.text = (NSLocalizedString("All Day", comment: ""))
            eventDurationLbl?.textColor = mainTextColor
        }
        else {
            let components = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: selectedEvent.startDate as Date, to: selectedEvent.stopDate as Date)
            eventDurationLbl?.text = updateDurationString (min: components.minute ?? 0, hour: components.hour ?? 0, day:components.day ?? 0, month: components.month ?? 0, year: components.year ?? 0)
            eventDurationLbl?.textColor = mainTextColor
            
            if isDeviceIn24HoursFormat() == true {
                print ("24")
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EdMMMYYhh mm", options: 0, locale: Locale.current)
            }
            else {
               print ("12")
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EdMMMYYhmma", options: 0, locale: Locale.current)
            }
        }
    
        startDateHeaderLbl?.textColor = subTextColor
        startDateHeaderLbl?.text = NSLocalizedString("Start: ", comment: "")
        startDateLbl?.textColor = mainTextColor
        startDateLbl?.text = dateFormatter.string(from: selectedEvent.startDate as Date)
        
        //you can't hide the stop date as the event might be all day, but span over a number of days.
        stopDateHeaderLbl?.textColor = subTextColor
        stopDateHeaderLbl?.text = NSLocalizedString("End: ", comment: "")
        stopDateLbl?.textColor = mainTextColor
        stopDateLbl?.text = dateFormatter.string(from: selectedEvent.stopDate as Date)
        //END
        
        
        //Calendar Name
        calendarNameHeaderLbl?.textColor = subTextColor
        calendarNameHeaderLbl?.text = NSLocalizedString("Calendar:", comment: "")
        let calendarImageID = UIImage(named: "CellIDImg_M")?.withRenderingMode(.alwaysTemplate)
        calendarIDImg!.image = calendarImageID
        calendarIDImg!.tintColor = UIColor(cgColor: selectedEvent.calendarColor)
        calendarNameLbl?.textColor = mainTextColor
        calendarNameLbl.text = selectedEvent.calendarName
            
        
        
        deleteEventBtn?.setImage(deletePopupBtnImage, for: .normal)
        deleteEventBtn?.setImage(deletePopupBtnPressedImage, for: .highlighted)
        
        deleteEventBtn!.layer.shadowColor = UIColor.black.cgColor
        deleteEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        deleteEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        deleteEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        cancelEventBtn?.setImage(cancelPopupBtnImage, for: .normal)
        cancelEventBtn?.setImage(cancelPopupBtnPressedImage, for: .highlighted)
        
        cancelEventBtn!.layer.shadowColor = UIColor.black.cgColor
        cancelEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        cancelEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        cancelEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        updateEventBtn?.setImage(updateButtonImage, for: .normal)
        updateEventBtn?.setImage(updatePressedButtonImage, for: .highlighted)
        
        updateEventBtn!.layer.shadowColor = UIColor.black.cgColor
        updateEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        updateEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        updateEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        /*
        if (dayMode == true) {
            deleteActivitySpinner.style = .gray
        }
        else{
            deleteActivitySpinner.style = .white
        }*/
        
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    
    override func viewWillAppear(_ animated: Bool){
        //BEGIN - get access so yuo speed up, by not asking for it all the time
        screenSaverCounter = 0 //Reset the screen saver counter
        eventAddedSucces = EventStoreAuthorizations()
        //END
        
        userRequestedToUpdateEvent = false
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AlarmNotification"), object: nil)
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerExpiredSegue3")
        performSegue(withIdentifier: "TimerExpiredSegue3", sender: nil)
    }
    //END
    
    @IBAction func deleteEventPressed(_ sender: Any) {
        //BEGIN - Hide the to Calendarview so the delete view comes visible, under it
        calendarInfoView.isHidden = true
        //END
        
        
        //BEGIN - Start Spinning the spinner
        spinnerIV.image = UIImage(named: "DeleteSpinnerDay")
        spinnerIV.contentMode = .center
        spinnerIV.isHidden = false
        let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
            rotationAnimation.duration = 1.5
            rotationAnimation.isCumulative = true
            rotationAnimation.repeatCount = .infinity
        
        self.spinnerIV.layer.add(rotationAnimation, forKey: "rotationAnimation")
        //END
        
        
        let eventToRemove = eventStore.event(withIdentifier:userSelectedEventID)
        
        if eventToRemove != nil {
            
            if eventToRemove!.hasRecurrenceRules == true {
                do {
                    try eventStore.remove(eventToRemove!, span: .futureEvents, commit: true)
                    self.startDeletionTimer()
                    print ("Tried to Delete future event")
                    
                } catch {
                    print ("Error! - Could not delete event")
                }
            }
            if eventToRemove!.hasRecurrenceRules == false {
                do {
                    try eventStore.remove(eventToRemove!, span: .thisEvent, commit: true)
                    self.startDeletionTimer()
                    print ("Tried to Delete this event only")
                    
                } catch {
                    print ("Error! - Could not delete event")
                }
            }
        }
    }

    func startDeletionTimer(){
        
        errorCounter = 0 // reset the error counter when you start
        deletePopupLbl.text = NSLocalizedString("Deleting Calendar Event", comment: "")
        
        //deleteActivitySpinner!.isHidden = false
        //deleteActivitySpinner!.startAnimating()
        activityTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.checkIfEventIsDeleted), userInfo: nil, repeats: true)
        checkIfEventIsDeleted()
    }
    
    @objc func checkIfEventIsDeleted() {
        let eventToRemove = eventStore.event(withIdentifier:userSelectedEventID)
        errorCounter=errorCounter+1
        print ("Delete Timer loop")
        if eventToRemove != nil {
            if errorCounter == 5 {
                //BEGIN if the event is not deleted after 5 seconds stop trying
                spinnerIV?.layer.removeAnimation(forKey: "rotationAnimation")
                //BEGIN - Stop animation and dispay error cross
                let loadingImages = (0...12).map { UIImage(named: "Error_Animation_\($0).png")! }
                spinnerIV.animationImages = loadingImages
                spinnerIV.animationRepeatCount = 1
                spinnerIV.animationDuration = 0.4
                spinnerIV.image = loadingImages.last
                spinnerIV.startAnimating()
                //END
                
                deletePopupLbl!.textColor = .red
                deletePopupLbl!.text = NSLocalizedString("Error - Could Not Delete Event", comment: "")
            }
            if errorCounter == 7 {
                //Remove the Popup, and user had 7-5 = 2 second to read message
                activityTimer?.invalidate() //Stop the timer
                closeScreen2()
            }
        }
        else {
            if (errorCounter == 2){
                print ("Event is deleted!")
                //BEGIN - Send a notification the calendar in the previous view needs to be updated
                NotificationCenter.default.post(name: Notification.Name("updateAfterDeleteNotification"), object: nil, userInfo: ["key":"value"])
                //END
                
                //BEGIN - Start the bin animation
                self.spinnerIV?.layer.removeAnimation(forKey: "rotationAnimation")
                let loadingImages = (0...12).map { UIImage(named: "Delete_Animation_\($0).png")! }
                self.spinnerIV.animationImages = loadingImages
                self.spinnerIV.animationRepeatCount = 1
                self.spinnerIV.animationDuration = 0.4
                self.spinnerIV.image = loadingImages.last
                self.spinnerIV.startAnimating()
                
                //BEGIN - yuo need to delay the closing of the screen else you won't see the finished animation
                closeTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.closeScreen2), userInfo: nil, repeats: true)
                //END
                activityTimer?.invalidate() //Stop the timer
                
            }
        }
    }
    
    @IBAction func closeScreen(){
        //BEGIN - Send a notification the calendar in the previous view needs to be updated
        NotificationCenter.default.post(name: Notification.Name("updateAfterDeleteNotification"), object: nil, userInfo: ["key":"value"])
        //END
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeScreen2(){
        closeTimer?.invalidate()
        self.spinnerIV?.layer.removeAnimation(forKey: "rotationAnimation")
        
        //BEGIN - Send a notification the calendar in the previous view needs to be updated
        NotificationCenter.default.post(name: Notification.Name("updateAfterDeleteNotification"), object: nil, userInfo: ["key":"value"])
        //END
        self.dismiss(animated: true, completion: nil)
    }
        
        
   
    
    
    
    @IBAction func updateBtnPressed(){
        //BEGIN - Set update flag
        userRequestedToUpdateEvent = true
        //End
        
        //BEGIN - load all the variables for the event to update
        let selectedEvent = readCalendarEventWithID(reqEventID:userSelectedEventID)
        calendarEventNameString = selectedEvent.eventName
        eventStartDate = selectedEvent.startDate as Date
        //userSelectedEventDuration = selectedEvent.duration
        userSelectedCalendarID = selectedEvent.calendarID
        userSelectedAllDay = selectedEvent.allDayEvent
        eventStartDate = selectedEvent.startDate as Date
        eventStopDate = selectedEvent.stopDate as Date
        userSelectedCalendarTintColor = UIColor.init(cgColor: selectedEvent.calendarColor)
        userSelectedCalendarName = selectedEvent.calendarName
        userSetRecurrence.hasreccurence = selectedEvent.hasRecurrence
        if selectedEvent.eventHasAlarm {
            userSelectedAlarmSeconds = Double(selectedEvent.alarmSeconds)
        }
        else {
            userSelectedAlarmSeconds = 0
        }
        //BEGIN - only read a recurrence if there is one, else the app will crash
        if selectedEvent.hasRecurrence {userSetRecurrence = readCalendarRecurrenceEventWithID(reqEventID: userSelectedEventID)}
        //END
        
        //BEGIN set the local variables so when the customer goes back to the event it display the correct recurrence setup
        
        //BEGIN - Clear All Recurrence String Arrays, before you fill them
        weekDaySelected = [false,false,false,false,false,false,false]
        weekDayLabelsSelected = [true,false,false,false,false,false,false,false,false]
        weekDayYearLabelsSelected  = [true,false,false,false,false,false,false,false,false]
        wichPartOfTheWeekDayYearLabelsSelected = [true,false,false,false,false,false]
        wichPartOfTheWeekDayLabelsSelected = [true,false,false,false,false,false]
        monthDaySelected = [false,false,false,false,false,false,false,
                                       false,false,false,false,false,false,false,
                                       false,false,false,false,false,false,false,
                                      false,false,false,false,false,false,false,
                                      false,false,false,false]
        yearMonthSelected = [false,false,false,false,false,false,false,false, false,false,false,false,]
        //END
        
        
        if userSetRecurrence.type == .daily { numberOfCustomDaysToRepeat = userSetRecurrence.interval }
        
        if userSetRecurrence.type == .weekly {
            numberOfWeeksToRepeat = userSetRecurrence.interval
        
            //BEGIN - Set which day of the week the recurrence has to comply to
            if userSetRecurrence.daysOfTheWeek != nil && userSetRecurrence.daysOfTheWeek?.isEmpty ==  false{
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) {
                    print ("Sunday")
                    weekDaySelected[0] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) {
                    print ("Monday")
                    weekDaySelected[1] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) {
                    print ("Tuesday")
                    weekDaySelected[2] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) {
                    print ("Wednesday")
                    weekDaySelected[3] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) {
                    print ("Thursday")
                    weekDaySelected[4] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) {
                    print ("Friday")
                    weekDaySelected[5] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) {
                    print ("Saturday")
                    weekDaySelected[6] = true
                }
            }
            //END
            
        }
        
        
        if userSetRecurrence.type == .monthly {
            numberOfMonthsToRepeat = userSetRecurrence.interval
            onTheSelection = true
            eachSelection = false
            
            
            if userSetRecurrence.daysOfTheWeek != nil && userSetRecurrence.daysOfTheWeek?.isEmpty ==  false{
                onTheSelection = false // This makes sure when user returns to recurrence screen the correct toggle value 'on the' is active
                eachSelection = true
                weekDayLabelsSelected = [false,false,false,false,false,false,false,false,false]
                
                //BEGIN - NEW SECTION
                let singleString = userSetRecurrence.daysOfTheWeek![0]
                let weekDay = singleString.dayOfTheWeek
                
                if weekDay == .sunday {
                    print ("Sunday")
                    weekDayLabelsSelected[0] = true
                }
                if weekDay == .monday {
                    print ("Monday")
                    weekDayLabelsSelected[1] = true
                }
                if weekDay == .tuesday {
                    print ("Tuesday")
                    weekDayLabelsSelected[2] = true
                }
                if weekDay == .wednesday{
                    print ("Wednesday")
                    weekDayLabelsSelected[3] = true
                }
                if weekDay == .thursday {
                    print ("Thursday")
                    weekDayLabelsSelected[4] = true
                }
                if weekDay == .friday {
                    print ("Friday")
                    weekDayLabelsSelected[5] = true
                }
                if weekDay == .saturday {
                    print ("Saturday")
                    weekDayLabelsSelected[6] = true
                }
                //END
            
            
                //Check if weekday filter has been set
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) == false {
                    weekDayLabelsSelected = [false,false,false,false,false,false,false,true,false]}
                
                //Check if weekend filter has been set
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) {
                    weekDayLabelsSelected = [false,false,false,false,false,false,false,false,true]}
           }
            //END
        
            //BEGIN - Populate the selected day of the month Array
            if userSetRecurrence.daysOfTheMonth != nil && userSetRecurrence.daysOfTheMonth?.isEmpty ==  false{
                onTheSelection = true // This makes sure when user returns to recurrence screen the correct toggle value 'on the' is non-active
                eachSelection = false
                if userSetRecurrence.daysOfTheMonth!.contains(1) { monthDaySelected[0] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(2) { monthDaySelected[1] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(3) { monthDaySelected[2] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(4) { monthDaySelected[3] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(5) { monthDaySelected[4] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(6) { monthDaySelected[5] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(7) { monthDaySelected[6] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(8) { monthDaySelected[7] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(9) { monthDaySelected[8] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(10) { monthDaySelected[9] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(11) { monthDaySelected[10] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(12) { monthDaySelected[11] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(13) { monthDaySelected[12] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(14) { monthDaySelected[13] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(15) { monthDaySelected[14] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(16) { monthDaySelected[15] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(17) { monthDaySelected[16] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(18) { monthDaySelected[17] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(19) { monthDaySelected[18] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(20) { monthDaySelected[19] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(21) { monthDaySelected[20] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(22) { monthDaySelected[21] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(23) { monthDaySelected[22] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(24) { monthDaySelected[23] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(25) { monthDaySelected[24] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(26) { monthDaySelected[25] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(27) { monthDaySelected[26] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(28) { monthDaySelected[27] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(29) { monthDaySelected[28] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(30) { monthDaySelected[29] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(31) { monthDaySelected[30] = true }
                if userSetRecurrence.daysOfTheMonth!.contains(-1) { monthDaySelected[31] = true }
            }
            //END
            
            //BEGIN - Set variable array 1,2,3,4,5th week or last week
            if userSetRecurrence.setPositions != nil && userSetRecurrence.setPositions?.isEmpty ==  false{
                onTheSelection = false // This makes sure when user returns to recurrence screen the correct toggle value 'on the' is non-active
                eachSelection = true
                wichPartOfTheWeekDayLabelsSelected = [false,false,false,false,false,false] // clear array
                if userSetRecurrence.setPositions!.contains(1) {wichPartOfTheWeekDayLabelsSelected[0] = true }
                if userSetRecurrence.setPositions!.contains(2) {wichPartOfTheWeekDayLabelsSelected[1] = true }
                if userSetRecurrence.setPositions!.contains(3) {wichPartOfTheWeekDayLabelsSelected[2] = true }
                if userSetRecurrence.setPositions!.contains(4) {wichPartOfTheWeekDayLabelsSelected[3] = true }
                if userSetRecurrence.setPositions!.contains(5) {wichPartOfTheWeekDayLabelsSelected[4] = true }
                if userSetRecurrence.setPositions!.contains(-1) {wichPartOfTheWeekDayLabelsSelected[5] = true }
            }
            //END
            
            // BEGIN if the other calendar app uses weekday to set which part of the week is recurring below function will deal with it
            if userSetRecurrence.daysOfTheWeek != nil && userSetRecurrence.daysOfTheWeek?.isEmpty ==  false{
                let singleString = userSetRecurrence.daysOfTheWeek![0]
                let partOfTheWeek = singleString.weekNumber
                //BEGIN the part of the week has been set
                if partOfTheWeek != 0 {
                    print ("the week number I found is: \(partOfTheWeek)")
                    wichPartOfTheWeekDayLabelsSelected = [false,false,false,false,false,false] // clear array
                    if partOfTheWeek == 1 {wichPartOfTheWeekDayLabelsSelected[0] = true }
                    if partOfTheWeek == 2 {wichPartOfTheWeekDayLabelsSelected[1] = true }
                    if partOfTheWeek == 3 {wichPartOfTheWeekDayLabelsSelected[2] = true }
                    if partOfTheWeek == 4 {wichPartOfTheWeekDayLabelsSelected[3] = true }
                    if partOfTheWeek == 5 {wichPartOfTheWeekDayLabelsSelected[4] = true }
                    if partOfTheWeek == -1 {wichPartOfTheWeekDayLabelsSelected[5] = true }
                }
                //END
            }
            //END
        }
        if userSetRecurrence.type == .yearly {
            numberOfYearsToRepeat = userSetRecurrence.interval
            eachYearSelection = false
            
            
            //BEGIN - Set which day of the week the recurrence has to comply to
            if userSetRecurrence.daysOfTheWeek != nil && userSetRecurrence.daysOfTheWeek?.isEmpty ==  false{
                eachYearSelection = true // this makes sure when user goes to recurrence the each toggle is active to reflect setting
                //BEGIN - clear the array so it can be updated with the loaded values from the event
                weekDayYearLabelsSelected  = [false,false,false,false,false,false,false,false,false]
                
                //END
                /*
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) {
                    print ("Sunday")
                    weekDayYearLabelsSelected[0] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) {
                    print ("Monday")
                    weekDayYearLabelsSelected[1] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) {
                    print ("Tuesday")
                    weekDayYearLabelsSelected[2] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) {
                    print ("Wednesday")
                    weekDayYearLabelsSelected[3] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) {
                    print ("Thursday")
                    weekDayYearLabelsSelected[4] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) {
                    print ("Friday")
                    weekDayYearLabelsSelected[5] = true
                }
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) {
                    print ("Saturday")
                    weekDayYearLabelsSelected[6] = true
                }*/
                //BEGIN - NEW SECTION
                let singleString = userSetRecurrence.daysOfTheWeek![0]
                let weekDay = singleString.dayOfTheWeek
                
                if weekDay == .sunday {
                    print ("Sunday")
                    weekDayYearLabelsSelected[0] = true
                }
                if weekDay == .monday {
                    print ("Monday")
                    weekDayYearLabelsSelected[1] = true
                }
                if weekDay == .tuesday {
                    print ("Tuesday")
                    weekDayYearLabelsSelected[2] = true
                }
                if weekDay == .wednesday{
                    print ("Wednesday")
                    weekDayYearLabelsSelected[3] = true
                }
                if weekDay == .thursday {
                    print ("Thursday")
                    weekDayYearLabelsSelected[4] = true
                }
                if weekDay == .friday {
                    print ("Friday")
                    weekDayYearLabelsSelected[5] = true
                }
                if weekDay == .saturday {
                    print ("Saturday")
                    weekDayYearLabelsSelected[6] = true
                }
                //END
                
                
                
                
                //Check if weekday filter has been set
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) == false {
                    weekDayYearLabelsSelected = [false,false,false,false,false,false,false,true,false]}
                
                //Check if weekend filter has been set
                if userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) == false && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) && userSetRecurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) {
                    weekDayYearLabelsSelected = [false,false,false,false,false,false,false,false,true]}
            }
            
            
            //BEGIN - Yearly recurrence only, populate the selected month
            if userSetRecurrence.monthsOfTheYear != nil && userSetRecurrence.monthsOfTheYear?.isEmpty ==  false{
                if userSetRecurrence.monthsOfTheYear!.contains(1) { yearMonthSelected[0] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(2) { yearMonthSelected[1] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(3) { yearMonthSelected[2] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(4) { yearMonthSelected[3] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(5) { yearMonthSelected[4] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(6) { yearMonthSelected[5] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(7) { yearMonthSelected[6] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(8) { yearMonthSelected[7] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(9) { yearMonthSelected[8] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(10) { yearMonthSelected[9] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(11) { yearMonthSelected[10] = true }
                if userSetRecurrence.monthsOfTheYear!.contains(12) { yearMonthSelected[11] = true }
            }
            
           
        
        
            //BEGIN - Set variable array 1,2,3,4,5th week or last week
            
            if userSetRecurrence.setPositions != nil && userSetRecurrence.setPositions?.isEmpty ==  false{
                eachYearSelection = true // this makes sure when user goes to recurrence the each toggle is active to reflect setting
                wichPartOfTheWeekDayYearLabelsSelected = [false,false,false,false,false,false] // clear array
                if userSetRecurrence.setPositions!.contains(1) {wichPartOfTheWeekDayYearLabelsSelected[0] = true }
                if userSetRecurrence.setPositions!.contains(2) {wichPartOfTheWeekDayYearLabelsSelected[1] = true }
                if userSetRecurrence.setPositions!.contains(3) {wichPartOfTheWeekDayYearLabelsSelected[2] = true }
                if userSetRecurrence.setPositions!.contains(4) {wichPartOfTheWeekDayYearLabelsSelected[3] = true }
                if userSetRecurrence.setPositions!.contains(5) {wichPartOfTheWeekDayYearLabelsSelected[4] = true }
                if userSetRecurrence.setPositions!.contains(-1) {wichPartOfTheWeekDayYearLabelsSelected[5] = true }
            }
            //END
            
            // BEGIN if the other calendar app uses weekday to set which part of the week is recurring below function will deal with it
            if userSetRecurrence.daysOfTheWeek != nil && userSetRecurrence.daysOfTheWeek?.isEmpty ==  false{
                let singleString = userSetRecurrence.daysOfTheWeek![0]
                let partOfTheWeek = singleString.weekNumber
                //BEGIN the part of the week has been set
                if partOfTheWeek != 0 {
                    print ("the week number I found is: \(partOfTheWeek)")
                    wichPartOfTheWeekDayYearLabelsSelected = [false,false,false,false,false,false] // clear array
                    if partOfTheWeek == 1 {wichPartOfTheWeekDayYearLabelsSelected[0] = true }
                    if partOfTheWeek == 2 {wichPartOfTheWeekDayYearLabelsSelected[1] = true }
                    if partOfTheWeek == 3 {wichPartOfTheWeekDayYearLabelsSelected[2] = true }
                    if partOfTheWeek == 4 {wichPartOfTheWeekDayYearLabelsSelected[3] = true }
                    if partOfTheWeek == 5 {wichPartOfTheWeekDayYearLabelsSelected[4] = true }
                    if partOfTheWeek == -1 {wichPartOfTheWeekDayYearLabelsSelected[5] = true }
                }
                //END
            }
        }
        NotificationCenter.default.post(name: Notification.Name("updateEventNotification"), object: nil, userInfo: ["key":"value"])
        //END
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
