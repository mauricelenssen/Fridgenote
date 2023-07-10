//
//  CalendarEditVC.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 11/10/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit
import StoreKit

var calendarEventNameString: String = ""  //Stores the text for the Calendar Event Name
var calendarEventDescriptionString: String = " "  //Stores the text for the Calendar Description Name, not used asnymore
var userSelectedCalendarID: String = "" // default not set calendar ID, need to be set
var userSelectedCalendarTintColor: UIColor = UIColor.green
var userSelectedCalendarName: String = ""
var userRequestedToUpdateEvent: Bool = false

//BEGIN - These values ar euse to build the table with duration labels
var eventDurationLabels: [String] = [] //these lebales will be automatically generate, so do not delete.
var eventDurationMinuteValues: [Int] = [15,30,0 ,0,0,0,0,0,0,0,0,0 ,0 ,0 ,0,0]
var eventDurationHoursValues: [Int]  = [0 ,0 ,1 ,2,4,0,0,0,0,0,0,0 ,0 ,0 ,0,0]
var eventDurationDaysValues: [Int]   = [0 ,0 ,0 ,0,0,2,3,4,5,6,7,14,21,28,0,0]
var eventDurationMonthsValues:[Int]  = [0 ,0 ,0 ,0,0,0,0,0,0,0,0,0 ,0 ,0 ,1,0]
var eventDurationYearValues:[Int]    = [0 ,0 ,0 ,0,0,0,0,0,0,0,0,0 ,0 ,0 ,0,1]
//END

var userSelectedAlarmSeconds: Double = 0 //in Seconds

var userSelectedEventID: String = ""
var userSelectedEventDuration: Int = 0 //event have a default time of 15 min, see above, make sure if you change also below settings
var userSelectedAllDay: Bool = true 

//BEGIN - Set de default recurrence
struct Recurrence {
    var hasreccurence: Bool = false
    var type: EKRecurrenceFrequency = .daily
    var interval: Int = 0
    var daysOfTheWeek: [EKRecurrenceDayOfWeek]? = []
    var daysOfTheMonth: [NSNumber]? = []
    var monthsOfTheYear: [NSNumber]? = []
    var weeksOfTheYear: [NSNumber]? = []
    var daysOfTheYear: [NSNumber]? = []
    var setPositions: [NSNumber]? = []
    var end: EKRecurrenceEnd? = .none
    
    
}
var userSetRecurrence = Recurrence()
//END


class CalendarEditVC: UIViewController,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,SKPaymentTransactionObserver {
    
    //@IBOutlet var createEventBtn: UIButton!
    @IBOutlet var headerLbl: UILabel!
    @IBOutlet var background: UIImageView!
    @IBOutlet var topHeaderView: UIImageView!
    
    //@IBOutlet var startDatePicker: UIDatePicker!
    @IBOutlet var calendarIDBtn: UIButton!
    
    @IBOutlet var eventName: UITextField?
    @IBOutlet var calendarTableView: UITableView?
    @IBOutlet var calendarIDLbl: UILabel?
    @IBOutlet var calendarIDImg: UIImageView?
    @IBOutlet var calendarIDView: UIView?
    @IBOutlet var calendarView: UIView!
    @IBOutlet var eventEditView: UIView!
    @IBOutlet var calendarRecurrenceBtn: UIButton!
    @IBOutlet var calendarRecurrenceLbl: UILabel!
    @IBOutlet var calendarEventDurationBtn: UIButton!
    @IBOutlet var calendarEventDurationLbl: UILabel!
    @IBOutlet var calendarRecurrenceView: UIView!
    @IBOutlet var calendarEventDurationView: UIView!
    @IBOutlet var closeBtn: UIButton!

    @IBOutlet var durationHeadingLbl: UILabel!
    @IBOutlet var calendarNameHeadingLbl: UILabel!
    @IBOutlet var repeatHeadingLbl: UILabel!
    @IBOutlet var alarmLbl: UILabel!
    @IBOutlet var alarmHeadingLbl: UILabel!
    @IBOutlet var editLineView: UIView!
    
    //@IBOutlet var allDayLbl: UILabel!
    //@IBOutlet var allDayTickImg: UIImageView!
    
    //@IBOutlet var cancelEventBtn: UIButton!
    
    @IBOutlet var addEventBtn: UIButton!
    @IBOutlet var headerDateLbl: UILabel!
    
    @IBOutlet var selectedDayLbl: UILabel!
    @IBOutlet var selectedMonthLbl: UILabel!
    @IBOutlet var selectedYearLbl: UILabel!
    @IBOutlet var selectedTimeLbl: UILabel!
    
    @IBOutlet var upDayBtn: UIButton!
    @IBOutlet var upMonthBtn: UIButton!
    @IBOutlet var upYearBtn: UIButton!
    @IBOutlet var upHourBtn: UIButton!
    @IBOutlet var upMinuteBtn: UIButton!
    
    @IBOutlet var downDayBtn: UIButton!
    @IBOutlet var downMonthBtn: UIButton!
    @IBOutlet var downYearBtn: UIButton!
    @IBOutlet var downHourBtn: UIButton!
    @IBOutlet var downMinuteBtn: UIButton!
    
    @IBOutlet var amPmBtn: UIButton!
    @IBOutlet var specificTimeLbl: UILabel!
    
    @IBOutlet var specificTimeBtn: UIButton!
    @IBOutlet var inAppBtn: UIButton!
    
    
    
    
    let calendarIDtableView = UITableView()
    let calendarRecurrencetableView = UITableView()
    let calendarEventDurationtableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        let nib = UINib.init(nibName: "MyCustomCell", bundle: nil)
        self.calendarTableView!.register(nib, forCellReuseIdentifier: "MyCustomCell")
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @IBAction func unlockAppFeatures() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print ("Unable to make a payment")
        }
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({
            switch $0.transactionState {
            case .purchasing:
                print ("purchasing")
            case .purchased:
                print ("purchased")
                SKPaymentQueue.default().finishTransaction($0)
                inAppPurchased = true
                inAppBtn.isHidden = true
                saveUserDefaults() //store the inAppPurchased variable
            case .failed:
                print ("failed")
                SKPaymentQueue.default().finishTransaction($0)
            case .restored:
                print ("restored")
                break
            case .deferred:
                print ("deferred")
                break
            @unknown default:
                break
            }
       })
    }
    
    
    
    
    func updateScreen (){
        
        specificTimeBtn?.setImage(expandDrawerImage, for: .normal)
        specificTimeBtn?.setImage(expandDrawerPressedImage, for: .highlighted)
        specificTimeBtn!.layer.shadowColor = UIColor.black.cgColor
        specificTimeBtn!.layer.shadowOpacity = shadowOpacityButtons
        specificTimeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        specificTimeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        
        updateAmPmButton()
        updateDateHeader(selectedDate: eventStartDate)
        selectedDayLbl?.textColor = mainTextColor
        selectedMonthLbl?.textColor = mainTextColor
        selectedYearLbl?.textColor = mainTextColor
        selectedTimeLbl?.textColor = mainTextColor
        
        calendarEventNameString = "" //on return the text box is empty again, else previous value is displayed
        eventName!.layer.borderWidth  = 1
        eventName!.layer.borderColor = subTextColor.cgColor
        eventName!.backgroundColor = windowColor
        eventName?.attributedPlaceholder = NSAttributedString(string: (NSLocalizedString("Type the name of your Calendar Event here!", comment: "")), attributes: [NSAttributedString.Key.foregroundColor : subTextColor])
        eventName!.textColor = mainTextColor
        
        //allDayLbl.textColor = mainTextColor
        //allDayLbl.text = NSLocalizedString("All Day Event", comment: "")
        specificTimeLbl.textColor = mainTextColor
        specificTimeLbl.text = NSLocalizedString("Event Time", comment: "")
        durationHeadingLbl?.textColor = mainTextColor
        durationHeadingLbl?.text = NSLocalizedString("Duration:", comment: "")
        
        alarmLbl?.textColor = mainTextColor
        alarmHeadingLbl?.textColor = mainTextColor
        alarmHeadingLbl?.text = NSLocalizedString("Alarm:", comment: "")
        calendarNameHeadingLbl?.textColor = mainTextColor
        calendarNameHeadingLbl?.text = NSLocalizedString("Calendar:", comment: "")
        repeatHeadingLbl?.textColor = mainTextColor
        repeatHeadingLbl?.text = NSLocalizedString("Repeat:", comment: "")
        topHeaderView?.image = topHeaderImage
        
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        
        calendarIDtableView.delegate = self
        calendarIDtableView.dataSource = self
        calendarRecurrencetableView.delegate = self
        calendarRecurrencetableView.dataSource = self
        calendarEventDurationtableView.delegate = self
        calendarEventDurationtableView.dataSource = self
        
        //BEGIN
        background.image = backgroundImage
        headerLbl?.textColor = mainTextColor
        headerLbl?.text = NSLocalizedString("Create a Calendar Event", comment: "")
        
        updateInAppStatus()
        
        calendarView!.layer.shadowColor = UIColor.black.cgColor
        calendarView!.layer.shadowOpacity = shadowOpacityView
        calendarView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        calendarView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        calendarView?.backgroundColor    = windowColor
        calendarView?.layer.cornerRadius = cornerRadiusWindow
        calendarView?.layer.borderWidth  = borderWidthWindow
        calendarView?.layer.borderColor  = borderColor.cgColor
        
        eventEditView!.layer.shadowColor = UIColor.black.cgColor
        eventEditView!.layer.shadowOpacity = shadowOpacityView
        eventEditView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        eventEditView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        eventEditView?.backgroundColor    = windowColor
        eventEditView?.layer.cornerRadius = cornerRadiusWindow
        eventEditView?.layer.borderWidth  = borderWidthWindow
        eventEditView?.layer.borderColor  = borderColor.cgColor
        
        calendarTableView!.separatorColor = tableSeperatorColor
        calendarIDtableView.separatorColor = tableSeperatorColor
        calendarIDtableView.backgroundColor = windowColor
        
        calendarRecurrencetableView.separatorColor = tableSeperatorColor
        calendarRecurrencetableView.backgroundColor = windowColor
        
        calendarEventDurationtableView.separatorColor = tableSeperatorColor
        calendarEventDurationtableView.backgroundColor = windowColor
        //BEGIN - Set Calendar ID labels and image
        let defaultCalender = getDefaultCalender()
        userSelectedCalendarID = defaultCalender.id
        userSelectedCalendarName = defaultCalender.name
        userSelectedCalendarTintColor = UIColor.init(cgColor: defaultCalender.calendarColor)
    
        let calendarImageID = UIImage(named: "CellIDImg_M")?.withRenderingMode(.alwaysTemplate)
        calendarIDImg!.image = calendarImageID
        calendarIDImg!.tintColor = userSelectedCalendarTintColor
        calendarIDLbl?.textColor = mainTextColor
        calendarIDLbl?.text = userSelectedCalendarName
        //END
    
        
        
        upDayBtn?.setImage(upBtnImage, for: .normal)
        upDayBtn?.setImage(upPressedBtnImage, for: .highlighted)
        upDayBtn!.layer.shadowColor = UIColor.black.cgColor
        upDayBtn!.layer.shadowOpacity = shadowOpacityButtons
        upDayBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upDayBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        upMonthBtn?.setImage(upBtnImage, for: .normal)
        upMonthBtn?.setImage(upPressedBtnImage, for: .highlighted)
        upMonthBtn!.layer.shadowColor = UIColor.black.cgColor
        upMonthBtn!.layer.shadowOpacity = shadowOpacityButtons
        upMonthBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upMonthBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        upYearBtn?.setImage(upBtnImage, for: .normal)
        upYearBtn?.setImage(upPressedBtnImage, for: .highlighted)
        upYearBtn!.layer.shadowColor = UIColor.black.cgColor
        upYearBtn!.layer.shadowOpacity = shadowOpacityButtons
        upYearBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upYearBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        upHourBtn?.setImage(upBtnImage, for: .normal)
        upHourBtn?.setImage(upPressedBtnImage, for: .highlighted)
        upHourBtn!.layer.shadowColor = UIColor.black.cgColor
        upHourBtn!.layer.shadowOpacity = shadowOpacityButtons
        upHourBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upHourBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        upMinuteBtn?.setImage(upBtnImage, for: .normal)
        upMinuteBtn?.setImage(upPressedBtnImage, for: .highlighted)
        upMinuteBtn!.layer.shadowColor = UIColor.black.cgColor
        upMinuteBtn!.layer.shadowOpacity = shadowOpacityButtons
        upMinuteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upMinuteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        downDayBtn?.setImage(downBtnImage, for: .normal)
        downDayBtn?.setImage(downPressedBtnImage, for: .highlighted)
        downDayBtn!.layer.shadowColor = UIColor.black.cgColor
        downDayBtn!.layer.shadowOpacity = shadowOpacityButtons
        downDayBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        downDayBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        downMonthBtn?.setImage(downBtnImage, for: .normal)
        downMonthBtn?.setImage(downPressedBtnImage, for: .highlighted)
        downMonthBtn!.layer.shadowColor = UIColor.black.cgColor
        downMonthBtn!.layer.shadowOpacity = shadowOpacityButtons
        downMonthBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        downMonthBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        downYearBtn?.setImage(downBtnImage, for: .normal)
        downYearBtn?.setImage(downPressedBtnImage, for: .highlighted)
        downYearBtn!.layer.shadowColor = UIColor.black.cgColor
        downYearBtn!.layer.shadowOpacity = shadowOpacityButtons
        downYearBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        downYearBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        downHourBtn?.setImage(downBtnImage, for: .normal)
        downHourBtn?.setImage(downPressedBtnImage, for: .highlighted)
        downHourBtn!.layer.shadowColor = UIColor.black.cgColor
        downHourBtn!.layer.shadowOpacity = shadowOpacityButtons
        downHourBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        downHourBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        downMinuteBtn?.setImage(downBtnImage, for: .normal)
        downMinuteBtn?.setImage(downPressedBtnImage, for: .highlighted)
        downMinuteBtn!.layer.shadowColor = UIColor.black.cgColor
        downMinuteBtn!.layer.shadowOpacity = shadowOpacityButtons
        downMinuteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        downMinuteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        addEventBtn?.setImage(addCalendarEventImage, for: .normal)
        addEventBtn?.setImage(addCalendarEventPressedImage, for: .highlighted)
        addEventBtn!.layer.shadowColor = UIColor.black.cgColor
        addEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        addEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        addEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        
        //BEGIN - update the calendar Settings
        updateCalendarEventSettings()
        //END
    }
    
    
    @IBAction func addDayPressed() {
        if isDeviceDateInDayMonthFormat() {
            eventStartDate = Calendar.current.date(byAdding: .day, value: 1, to: eventStartDate as Date)!
        }
        else
        {
            eventStartDate = Calendar.current.date(byAdding: .month, value: 1, to: eventStartDate as Date)!
        }
        updateDateHeader(selectedDate: eventStartDate)
    }

    @IBAction func decreaseDayPressed() {
        if isDeviceDateInDayMonthFormat() {
            eventStartDate = Calendar.current.date(byAdding: .day, value: -1, to: eventStartDate as Date)!
        }
        else
        {
            eventStartDate = Calendar.current.date(byAdding: .month, value: -1, to: eventStartDate as Date)!
        }
        updateDateHeader(selectedDate: eventStartDate)
    }
    
    @IBAction func addMonthPressed() {
        
        if isDeviceDateInDayMonthFormat() {
            eventStartDate = Calendar.current.date(byAdding: .month, value: 1, to: eventStartDate as Date)!
        }
        else
        {
            eventStartDate = Calendar.current.date(byAdding: .day, value: 1, to: eventStartDate as Date)!
            
        }
        updateDateHeader(selectedDate: eventStartDate)
    }
    
    @IBAction func decreaseMonthPressed() {
        if isDeviceDateInDayMonthFormat() {
            eventStartDate = Calendar.current.date(byAdding: .month, value: -1, to: eventStartDate as Date)!
        }
        else
        {
            eventStartDate = Calendar.current.date(byAdding: .day, value: -1, to: eventStartDate as Date)!
        }
        updateDateHeader(selectedDate: eventStartDate)
    }

    @IBAction func addYearPressed() {
        eventStartDate = Calendar.current.date(byAdding: .year, value: 1, to: eventStartDate as Date)!
        updateDateHeader(selectedDate: eventStartDate)
    }
    
    @IBAction func decreaseYearPressed() {
        eventStartDate = Calendar.current.date(byAdding: .year, value: -1, to: eventStartDate as Date)!
        updateDateHeader(selectedDate: eventStartDate)
    }
    
    @IBAction func addHourPressed() {
        eventStartDate = Calendar.current.date(byAdding: .hour, value: 1, to: eventStartDate as Date)!
        updateDateHeader(selectedDate: eventStartDate)
    }
    @IBAction func decreaseHourPressed() {
        eventStartDate = Calendar.current.date(byAdding: .hour, value: -1, to: eventStartDate as Date)!
        updateDateHeader(selectedDate: eventStartDate)
    }
    
    @IBAction func addMinutePressed() {
        eventStartDate = Calendar.current.date(byAdding: .minute, value: 5, to: eventStartDate as Date)!
        updateDateHeader(selectedDate: eventStartDate)
    }
    @IBAction func decreaseMinutePressed() {
        eventStartDate = Calendar.current.date(byAdding: .minute, value: -5, to: eventStartDate as Date)!
        updateDateHeader(selectedDate: eventStartDate)
    }
    
    @IBAction func amPmButtonPressed() {
        
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from:eventStartDate)
        let minute = calendar.component(.minute, from: eventStartDate)
        print ("am pm: \(hour) : \(minute)")
        
        print ("Current seelcted time: \(eventStartDate)")
        if (hour >= 12) && (minute >= 0) {
            print ("am")
            eventStartDate = Calendar.current.date(byAdding: .hour, value: -12, to: eventStartDate as Date)!
            print (eventStartDate)
        }
        else{
            print ("pm")
            eventStartDate = Calendar.current.date(byAdding: .hour, value: +12, to: eventStartDate as Date)!
            print (eventStartDate)
        }
        //updateAmPmButton()
        updateDateHeader(selectedDate: eventStartDate)
    }
    
    
    
    @IBAction func updateEventName(_ sender: Any) {
        if eventName!.text!.count > 0
        {
            self.eventName!.layer.borderWidth = textfieldBorderWidthNormal
            self.eventName!.layer.cornerRadius = textfieldRadius
            self.eventName!.layer.borderColor = mainTextColor.cgColor
        }
        else
        {
            self.eventName!.layer.borderWidth = textfieldBorderWidthHighlight
            self.eventName!.layer.cornerRadius = textfieldRadius
            self.eventName!.layer.borderColor = attentionTextColor.cgColor
        }
        calendarEventNameString = eventName!.text!
    }
    
    @IBAction func closeKeyboard(_ sender: Any) {
        //print ("Close the shortcut View")
        //DEBUG
        if eventName!.text == ""{
            calendarEventNameString = ""
        }
        else{
            calendarEventNameString = eventName!.text!
        }
    }
    
    func updateDateHeader(selectedDate: Date) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEEEdMMMMyyyy", options: 0, locale: Locale.current)
        headerDateLbl.textColor = mainTextColor
        headerDateLbl!.text  = dateFormatter.string(from: selectedDate as Date)
        
        let userSelectedDay = Calendar.current.component(.day, from: eventStartDate)
        let userSelectedYear = Calendar.current.component(.year, from: eventStartDate)
        selectedYearLbl.text = ("\(userSelectedYear)")
        
        //BEGIN - Swap the day and month label if you detect a US Locale
        if isDeviceDateInDayMonthFormat() {
            dateFormatter.dateFormat = "MMM"
            selectedMonthLbl.text = dateFormatter.string(from: eventStartDate as Date)
            selectedDayLbl.text = ("\(userSelectedDay)")
        }
        else{
            dateFormatter.dateFormat = "MMM"
            selectedMonthLbl.text = ("\(userSelectedDay)")
            selectedDayLbl.text = dateFormatter.string(from: eventStartDate as Date)
        }
        
        dateFormatter.dateFormat = "h:mm"
        selectedTimeLbl.text = dateFormatter.string(from: eventStartDate as Date)
        updateAmPmButton()
        //eventStartDate = eventStartDate
        calendarTableView!.reloadData() //Update the calendar so user can see when event started
    
    }
    
    func updateAmPmButton(){
        //CHECK if am or pm time
        let hour =  Calendar.current.component(.hour, from: eventStartDate)
        let minute = Calendar.current.component(.minute, from: eventStartDate)
        
        //print ("UPDATE am pm -> \(hour):\(minute)")
        if (hour >= 12) && (minute >= 0) {
            //print ("pm")
            amPmBtn?.setImage(pmBtnImage, for: .normal)
            amPmBtn!.layer.shadowColor = UIColor.black.cgColor
            amPmBtn!.layer.shadowOpacity = shadowOpacityButtons
            amPmBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
            amPmBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        }
        else{
            //print ("pm")
            amPmBtn?.setImage(amBtnImage, for: .normal)
            amPmBtn!.layer.shadowColor = UIColor.black.cgColor
            amPmBtn!.layer.shadowOpacity = shadowOpacityButtons
            amPmBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
            amPmBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        }
        //END
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print ("TimerExpiredSegue2")
        performSegue(withIdentifier: "TimerExpiredSegue2", sender: nil)
    }
    //END
    
    @IBAction func allDayButtonPressed() {
        if userSelectedAllDay == true {userSelectedAllDay = false}
        else { userSelectedAllDay = true }
        updateCalendarEventSettings()
    }
    
    @IBAction func specificTimeButtonPressed() {
        if userSelectedAllDay == true {
            userSelectedAllDay = false
            eventStopDate = eventStartDate.addingTimeInterval(15*60) //When user selects a specfic time the default event time is 15 minutes.
            print ("Specific Time button")
        }
        else {
            userSelectedAllDay = true
            eventStopDate = eventStartDate
             print ("No specific time set")
        }
        
        updateCalendarEventSettings()
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        saveUserDefaults() //storing the number of engtries the user did on the FREE version of the app
        //BEGIN - Remove all notifications
        NotificationCenter.default.removeObserver(self)
        //END
        //NotificationCenter.default.removeObserver(self, name: Notification.Name("AlarmNotification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool){
        //BEGIN - get access so yuo speed up, by not asking for it all the time
        eventAccessApproved = EventStoreAuthorizations()
        //END
        
        
        //BEGIN - Set the selected date to the nearesthour, so you can increase with 5 minutes brackets.
        //Also clear all the variables from a previous Calendar entry
        //eventStartDate = nearestHour()!
        let selectedDay = Calendar.current.component(.day, from: eventStartDate)
        let selectedMonth = Calendar.current.component(.month, from: eventStartDate)
        let selectedYear = Calendar.current.component(.year, from: eventStartDate)
        let selectedMinute = 0
        let selectedHour = 9
        //let selectedTimezone = Calendar.current.component(.timeZone, from: eventStartDate)
        
        var dateComponent = DateComponents()
        dateComponent.day = selectedDay
        dateComponent.month = selectedMonth
        dateComponent.year = selectedYear
        dateComponent.minute = selectedMinute
        dateComponent.hour = selectedHour
        //dateComponent.timeZone = Calendar.current.component(.timeZone, from: eventStartDate)
        selectedDate = Calendar.current.date(from: dateComponent)!
        eventStartDate = selectedDate
        eventStopDate = eventStartDate
        userSelectedAllDay = true
        userRequestedToUpdateEvent = false //Default go back to adding events, you need this incase user exit previous update, when you return it will want to update
        //userSelectedAlarm = 0 //1st option is no alarm
        userSelectedAlarmSeconds = 0 //Default option is no alarm
        userSelectedEventID = ""
        userSelectedEventDuration = 0 //event have a default time of 15 min, see above, make sure if you change also below settings
        userSetRecurrence.hasreccurence = false
        
        weekDaySelected = [false,false,false,false,false,false,false]
        weekDayLabelsSelected      = [true,false,false,false,false,false,false,false,false]
        wichPartOfTheWeekDayLabelsSelected = [true,false,false,false,false,false]
        weekDayYearLabelsSelected  = [true,false,false,false,false,false,false,false,false]
        wichPartOfTheWeekDayYearLabelsSelected = [true,false,false,false,false,false]
        monthDaySelected = [false,false,false,false,false,false,false,
                                       false,false,false,false,false,false,false,
                                       false,false,false,false,false,false,false,
                                      false,false,false,false,false,false,false,
                                      false,false,false,false]
        yearMonthSelected = [false,false,false,false,false,false,false,false, false,false,false,false,]
        
        updateCalendarEventSettings()
        updateScreen()
        
        screenSaverAllowed = false // prevent the screen saver to start else it could start when keyboard is up
        userSelectedEventID = "" //clear the user selected string else it will already be selected if you selected it in month view.
        print ("Edit ViewController is appearing")
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
        
        //BEGIN - send me a notification when the calendar list needs to be updated, since we deleted an event
        NotificationCenter.default.addObserver(self, selector: #selector(updateCalendarChangesAfterDelete), name: Notification.Name("updateAfterDeleteNotification"), object: nil)
        //END
        
        //BEGIN - send me a notification when the user made changes to the calendar event he is creating or updating, so you can update labels
        NotificationCenter.default.addObserver(self, selector: #selector(updateCalendarEventSettings), name: Notification.Name("updateEventNotification"), object: nil)
        //END
        
        
        
        calendarTableView!.reloadData()
        
        
        editLineView!.layer.backgroundColor = windowColor.cgColor
        editLineView!.layer.cornerRadius = textfieldBorderWidthHighlight
        
        eventName!.layer.borderWidth = textfieldBorderWidthHighlight
        eventName!.layer.cornerRadius = textfieldRadius
        eventName!.layer.borderColor = attentionTextColor.cgColor
        
        
        
        if (dayMode == true){
            eventName!.keyboardAppearance = UIKeyboardAppearance.light
        }
        else {
            eventName!.keyboardAppearance = UIKeyboardAppearance.dark
        }
    }
    
    @objc func updateCalendarEventSettings(){
        print ("Update the Settings")
        
        eventName!.text! = calendarEventNameString
        
        if userSelectedAllDay {
            calendarEventDurationLbl?.text = (NSLocalizedString("All Day", comment: ""))
            calendarEventDurationLbl?.textColor = mainTextColor
        }
        else{
            //var durationString:String = ""
            //print ("********************* \(eventStartDate)")
            //print ("********************* \(eventStopDate)")
            
            let components = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: eventStartDate, to: eventStopDate)
            calendarEventDurationLbl?.text = updateDurationString (min: components.minute ?? 0, hour: components.hour ?? 0, day:components.day ?? 0, month: components.month ?? 0, year: components.year ?? 0)
            calendarEventDurationLbl?.textColor = mainTextColor
        }
        
        if userRequestedToUpdateEvent == true {
            addEventBtn?.setImage(updateCalendarEventImage, for: .normal)
            addEventBtn?.setImage(updateCalendarEventPressedImage, for: .highlighted)
        }
        else {
            addEventBtn?.setImage(addCalendarEventImage, for: .normal)
            addEventBtn?.setImage(addCalendarEventPressedImage, for: .highlighted)
        }
        
        calendarIDImg!.tintColor = userSelectedCalendarTintColor
        calendarIDLbl?.text = userSelectedCalendarName
        
        calendarIDLbl?.textColor = mainTextColor
        calendarIDLbl?.text = userSelectedCalendarName
        
        
        
        calendarRecurrenceLbl.text = recurrenceText(recurrence: userSetRecurrence)
        //calendarRecurrenceLbl.text = recurrenceLabels[userSelectedRecurrence]
        calendarRecurrenceLbl.textColor = mainTextColor

        alarmLbl.text = convertSecondsInAlarmStr(seconds: Int(userSelectedAlarmSeconds))
       
        alarmLbl.textColor = mainTextColor
        
        //startDatePicker.date = eventStartDate as Date
        updateDateHeader(selectedDate: eventStartDate)
        
        
        //BEGIN - Set the correct state for the date picker, depending if the user changed event duration before
        if userSelectedAllDay == true{
            upHourBtn.isHidden = true
            upMinuteBtn.isHidden = true
            downHourBtn.isHidden = true
            downMinuteBtn.isHidden = true
            selectedTimeLbl.isHidden = true
            amPmBtn.isHidden = true
            
            //allDayTickImg.image = tickImage
            specificTimeBtn?.setImage(expandDrawerImage, for: .normal)
            specificTimeBtn?.setImage(expandDrawerPressedImage, for: .highlighted)
            
        }
        else {
            upHourBtn.isHidden = false
            upMinuteBtn.isHidden = false
            downHourBtn.isHidden = false
            downMinuteBtn.isHidden = false
            selectedTimeLbl.isHidden = false
            
            if isDeviceIn24HoursFormat(){
                print ("Device is in 24 hour mode")
                amPmBtn.isHidden = true
            }
            else{
                print ("Device is in AM/PM hour mode")
                amPmBtn.isHidden = false
            }
            //allDayTickImg.image = tickNotSelectedImage
            specificTimeBtn?.setImage(collapseDrawerImage, for: .normal)
            specificTimeBtn?.setImage(collapseDrawerPressedImage, for: .highlighted)
            
        }
        //END
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let calendarEventFromData = readCalendarEventsFromDate(requestedDate:eventStartDate)
        
        userSelectedEventID = calendarEventFromData.requestedEventID[indexPath.row]
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = buttonPressedColor
        
        performSegue(withIdentifier: "SegueToDeleteCalendar", sender: nil)
    }
    
    @IBAction func CloseCalendarEdit(_ sender: UIButton) {
        print ("Close the Calendar Edit View")
        
        screenSaverAllowed = true //allow to show the screen saver again once you are out off the settings screen
        //BEGIN - stop and remove the timer
        self.dismiss(animated: true, completion: nil)
        //END
    }

    @IBAction func createEvent() {
        if eventName!.text == ""
        {
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           options: [.curveEaseInOut],
                           animations: {
                            self.editLineView!.layer.backgroundColor = attentionTextColor.cgColor
                            
            },
                           completion: { finished in
                        UIView.animate(withDuration: 0.5
                            ,
                                           delay: 0.0,
                                           options: [.curveEaseInOut],
                                           animations: {
                                            self.editLineView!.layer.backgroundColor = windowColor.cgColor
                                           },
                                           completion: { finished in
                                           
                            })
                            
            })
            print ("No input")
        }
        else
        {
            calendarEventNameString = eventName!.text!
            //BEGIN - Count how manuy entries user made befor it locks him out
            agendaCreationLimit = agendaCreationLimit - 1
            if agendaCreationLimit < 0 {agendaCreationLimit = 0}
            //END
            
            //BEGIN - stop date is start date when all day event is selected, else an event duration is add
            if (userSelectedAllDay){
                eventStopDate = eventStartDate
            }
            else{
                var dateComponent = DateComponents()
                dateComponent.minute = eventDurationMinuteValues[userSelectedEventDuration]
                dateComponent.hour = eventDurationHoursValues[userSelectedEventDuration]
                dateComponent.day = eventDurationDaysValues[userSelectedEventDuration]
                dateComponent.month = eventDurationMonthsValues[userSelectedEventDuration]
                dateComponent.year = eventDurationYearValues[userSelectedEventDuration]
                eventStopDate = Calendar.current.date(byAdding: dateComponent, to: eventStartDate)!
            }
            //END
            performSegue(withIdentifier: "SegueToCreateCalendarEvent", sender: nil)
            if userRequestedToUpdateEvent == true
            {
                //BEGIN - Remove old event so a new event can be created
                let eventToRemove = eventStore.event(withIdentifier:userSelectedEventID)
                
                if eventToRemove != nil {
                    
                    if eventToRemove!.hasRecurrenceRules == true {
                        do {
                            try eventStore.remove(eventToRemove!, span: .futureEvents, commit: true)
                            //self.startDeletionTimer()
                            userRequestedToUpdateEvent = false
                            print ("Tried to Delete future event")
                            
                        } catch {
                            print ("Error! - Could not delete event")
                        }
                    }
                    if eventToRemove!.hasRecurrenceRules == false {
                        do {
                            try eventStore.remove(eventToRemove!, span: .thisEvent, commit: true)
                            //self.startDeletionTimer()
                            userRequestedToUpdateEvent = false
                            print ("Tried to Delete this event only")
                            
                        } catch {
                            print ("Error! - Could not delete event")
                        }
                    }
                }
                //END
             }
            
            
            addEventToCalendar(title: calendarEventNameString, description: calendarEventDescriptionString, startDate: eventStartDate, endDate: eventStopDate, allDayEvent: userSelectedAllDay, calenderID: userSelectedCalendarID, recurrence: userSetRecurrence, alarmSeconds: userSelectedAlarmSeconds)
            //displayedMonth = Calendar.current.component(.month, from: eventStartDate)
            //displayedYear = Calendar.current.component(.year, from: eventStartDate)
            
        }
    }
    
    func updateInAppStatus(){
        inAppBtn!.layer.shadowColor = UIColor.black.cgColor
        inAppBtn!.layer.shadowOpacity = shadowOpacityButtons
        inAppBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        inAppBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        if inAppPurchased {
            //BEGIN - User isusing PAID Version
            inAppBtn?.isHidden = true
            inAppBtn?.setImage(lockImage, for: .normal)
            inAppBtn?.setTitleColor(attentionTextColor, for: .normal)
            inAppBtn?.setTitle(NSLocalizedString("Unlock App,", comment: "") + String(agendaCreationLimit) + NSLocalizedString(" entries left.", comment: ""), for: .normal)
        }
        else {
            //BEGIN - User is using FREE version
            inAppBtn?.isHidden = false
            inAppBtn?.setImage(lockImage, for: .normal)
            inAppBtn?.setTitleColor(attentionTextColor, for: .normal)
            inAppBtn?.setTitle(NSLocalizedString("Unlock App,", comment: "") + String(agendaCreationLimit) + NSLocalizedString(" entries left.", comment: ""), for: .normal)
            if agendaCreationLimit == 0 {
                addEventBtn.isEnabled = false}
            else {addEventBtn.isEnabled = true}
            
        }
    }
    
    @objc func updateCalendarChangesAfterDelete() {
       //update the calendar because when you Push a popup the view will appear is not called, so a deletion of event won't update your table, hence we need to check
        eventName!.text = "" //clear text field so when event is added the event name is empty again.
        calendarTableView!.reloadData()
        updateInAppStatus()
        print ("update calendar List")
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let requestedEventData = readCalendarEventsFromDate(requestedDate: eventStartDate)
        return requestedEventData.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = calendarTableView!.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as! MyCustomCell
        let requestedEventData = readCalendarEventsFromDate(requestedDate: eventStartDate)
        let dateFormatter = DateFormatter()
        
        //BEGIN - set Colors of cells
        cell.eventNameLbl.textColor = mainTextColor
        cell.eventTimeLbl.textColor = subTextColor
        
        
        let calendarImageID = UIImage(named: "CellIDImg_M")?.withRenderingMode(.alwaysTemplate)
        cell.calendarTypeImg2.image = calendarImageID
        cell.calendarTypeImg2.tintColor = UIColor.init(cgColor: requestedEventData.calendarColor[indexPath.row])
        //cell.infoImg.image = infoImage
        
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none //do not show a selection color
        cell.backgroundColor = .clear //You need this so previous selected cells are cleared again after being selected but not deleted due to cancel action
        cell.eventNameLbl.text = requestedEventData.titles[indexPath.row]
        
        let start2 = requestedEventData.startTime[indexPath.row]
        let stop2 = requestedEventData.endTime[indexPath.row]
        
        if (Calendar.current.isDate(start2 as Date, inSameDayAs:stop2 as Date)) {
            dateFormatter.dateFormat = "h:mm"
            let start2String = "\(dateFormatter.string(from: start2 as Date))"
            let stop2String  = "\(dateFormatter.string(from: stop2 as Date))"
            
            cell.eventTimeLbl.text = start2String + " ・ " + stop2String
            cell.eventTimeLbl.font = UIFont.monospacedDigitSystemFont(ofSize: 25.0, weight: UIFont.Weight.regular)
            
            if requestedEventData.AllDayEvent[indexPath.row] == true {
                //cell.eventTimeLbl.text = NSLocalizedString("All Day", comment: "")
                cell.eventTimeLbl.text = ""
            
            }
        }
        else {
            //dateFormatter.dateFormat = "d/M"
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dM", options: 0, locale: Locale.current)
            
            let start2String = "\(dateFormatter.string(from: start2 as Date))"
            let stop2String  = "\(dateFormatter.string(from: stop2 as Date))"
            cell.eventTimeLbl.text = start2String + " - " + stop2String
            cell.eventTimeLbl.font = UIFont.monospacedDigitSystemFont(ofSize: 25.0, weight: UIFont.Weight.regular)
        }
        
        cell.selectionStyle = .none //do not show a selection color
        return cell
    }
    
    func deleteEvent (eventNumber: Int){
        //let eventStore = EKEventStore()
        if (eventAccessApproved == true)
        {
            let calendarEventFromData = readCalendarEventsFromDate(requestedDate:eventStartDate)
            print ("Event ID: \(calendarEventFromData.requestedEventID[eventNumber])")
            //let selectedEvent = readCalendarEventWithID(reqEventID:calendarEventFromData.requestedEventID[eventNumber])
            //startDatePicker.date = selectedEvent.startDate as Date
            //stopDatePicker.date = selectedEvent.endDate as Date
            //eventName!.text = selectedEvent.eventName
            
            let eventToRemove = eventStore.event(withIdentifier: calendarEventFromData.requestedEventID[eventNumber])
            
            let eventHasRecurrence = (eventToRemove?.hasRecurrenceRules)!
            
            if eventHasRecurrence {
                print ("Event has recurrence!")
            }
            else
            {
                print("Event has no recurrence!")
            }
            
            if eventToRemove != nil {
                do {
                    try eventStore.remove(eventToRemove!, span: .futureEvents, commit: true)
                    print ("Tried to Delete the event")
                    calendarTableView!.reloadData()
                } catch {
                    print ("Error! - Could not delete event")
                }
            }
        }
    }
    
}
