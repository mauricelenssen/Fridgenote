//
//  WeekOverviewVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 1/10/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

var numOfWeek:Int = 3
var selectedYear:Int = 2019
var startDate: NSDate = Date() as NSDate
var weekOffset: Int = 0 //This value hold the offset to the current week which has to be displayed.
var calendarViewWidth: Int = 0
var calendarViewHeight: Int = 0
var weekEventsTitle = [[String]]()
var weekCalendarColours = [[CGColor]]()
var weekEventsTime = [[String]]()
var weekDate = Array(repeating: Date(), count: 7)

class WeekOverviewVC: UIViewController {
    @IBOutlet var addEventBtn: UIButton?
    
    @IBOutlet var background: UIImageView!
    @IBOutlet var topHeaderView: UIImageView!
    
    @IBOutlet var monthHeaderLbl: UILabel!
    @IBOutlet var closeBtn: UIButton!
    
    
    @IBOutlet var weekView: UIView!
    @IBOutlet var weekSelectionView: UIView!
    
    @IBOutlet var nextWeekBtn: UIButton!
    @IBOutlet var previousWeekBtn: UIButton!
    
    var updateCalendarTimer: Timer?
    
    func updateWeekView(){
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
            
        calendarViewWidth = Int(UIScreen.main.bounds.width)
        calendarViewHeight = Int(UIScreen.main.bounds.height)-50-50
        
        
        print ("View did Load")
        
        let calendar = Calendar(identifier: .iso8601)
        numOfWeek = calendar.component(.weekOfYear, from: Date())
        displayedDay = Calendar.current.component(.day, from: Date())
        displayedMonth = Calendar.current.component(.month, from: Date())
        displayedYear = Calendar.current.component(.year, from: Date())
        //END
        currentDay = Calendar.current.component(.day, from: Date())
        currentMonth  = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        updateScreen()
        
    }
    
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print ("TimerExpiredSegue5")
        performSegue(withIdentifier: "TimerExpiredSegue5", sender: nil)
    }
    //END
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        updateCalendarTimer?.invalidate()
        updateCalendarTimer = nil
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AlarmNotification"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //BEGIN - update the week Overview
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = true //prevent slide show to start when in this viewcontroller
        //BEGIN - get access so you speed up, by not asking for it all the time
        eventAccessApproved = EventStoreAuthorizations()
        //END
        
        var dateComponents = DateComponents()
        dateComponents.weekOfYear = numOfWeek
        dateComponents.weekday = 2 //this makes sure the date is reflecting Mondays month name
        dateComponents.year = displayedYear
        
        let dateFormatter = DateFormatter()
        let userCalendar = Calendar(identifier: .iso8601)
        let tempDate = userCalendar.date(from: dateComponents)
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM", options: 0, locale: Locale.current)
        monthHeaderLbl.textColor = clockColor
        monthHeaderLbl.text = dateFormatter.string(from: tempDate!)
        
        //Set current week number and year, so user can the week view can ad the correct week
        let calendar = Calendar(identifier: .iso8601)
        numOfWeek = calendar.component(.weekOfYear, from: Date())
        displayedDay = Calendar.current.component(.day, from: Date())
        displayedMonth = Calendar.current.component(.month, from: Date())
        displayedYear = Calendar.current.component(.year, from: Date())
        //END
        currentDay = Calendar.current.component(.day, from: Date())
        currentMonth  = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        
        //BEGIN - Start updating the 15 minutes timer for updating the calender and Today Calendar events, I picked 60 minutes as the background process to retrieve new calendar data is also synced every 60 minutes
        weekOffset = 0 //This value hold the offset to the current week which has to be displayed, so when you return it shows correct week
        
        
        (weekEventsTitle,weekCalendarColours,weekEventsTime) = getWeekEventsFromCalendarStore(reqWeek: numOfWeek, reqYear: displayedYear, reqWeekOffset: weekOffset, requestedCalendars: userDayCalendars)
        refreshCalendar()
        
        if updateCalendarTimer == nil {
            updateCalendarTimer = Timer.scheduledTimer(timeInterval: calendarUpdateFrequency, target: self, selector: #selector(self.refreshCalendar), userInfo: nil, repeats: true)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.screensaverRequested), name: Notification.Name("ScreensaverNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
        print ("updating the Week view")
        //END
    }
    
    @objc func screensaverRequested()
    {
        print ("The Screensaver is requested")
        
        if (userSelectedPhotoAlbum == "") {
            performSegue(withIdentifier: "NoPhotoAlbumSegue", sender: nil)
        }
        else {
            performSegue(withIdentifier: "ScreenSaverSegue", sender: nil)
        }
    }
    
    @objc func screenModeHasChanged()
    {
        print ("I updated the screen MODE")
        updateScreen()
        refreshCalendar()
    }
    
    func updateScreen() {
        //BEGIN - setup tables
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        addEventBtn?.setImage(EditCalendarBtnImage, for: .normal)
        addEventBtn?.setImage(EditCalendarPressedBtnImage, for: .highlighted)
        addEventBtn!.layer.shadowColor = UIColor.black.cgColor
        addEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        addEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        addEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        nextWeekBtn?.setImage(forwardImage, for: .normal)
        nextWeekBtn?.setImage(forwardPressedImage, for: .highlighted)
        nextWeekBtn!.layer.shadowColor = UIColor.black.cgColor
        nextWeekBtn!.layer.shadowOpacity = shadowOpacityButtons
        nextWeekBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        
        previousWeekBtn?.setImage(backImage, for: .normal)
        previousWeekBtn?.setImage(backPressedImage, for: .highlighted)
        previousWeekBtn!.layer.shadowColor = UIColor.black.cgColor
        previousWeekBtn!.layer.shadowOpacity = shadowOpacityButtons
        previousWeekBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        
        weekSelectionView!.layer.shadowColor = UIColor.black.cgColor
        weekSelectionView!.layer.shadowOpacity = shadowOpacityView
        weekSelectionView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        weekSelectionView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        weekSelectionView?.backgroundColor    = windowColor
        weekSelectionView?.layer.cornerRadius = cornerRadiusWindow
        weekSelectionView?.layer.borderWidth  = borderWidthWindow
        weekSelectionView?.layer.borderColor  = borderColor.cgColor
        
        weekView?.backgroundColor    = .clear
      
        
        //BEGIN - setup views
        background.image = backgroundImage
        topHeaderView?.image = topHeaderImage
    }
    
    func fillWeekOverview (weekOffsetNumber:Int, weekNumber:Int, year:Int)
    {
        
        var dateComponents = DateComponents()
        dateComponents.weekOfYear = weekNumber
        dateComponents.weekday = 2 //this makes sure the date is reflecting Mondays month name
        dateComponents.year = year
        
        //let userCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let userCalendar = Calendar(identifier: .iso8601)
        var tempDate = userCalendar.date(from: dateComponents)
        
        tempDate = Calendar.current.date(byAdding: .day, value: (7*(weekOffsetNumber)), to: tempDate!)!
        
        let cellWidth = Int((calendarViewWidth-30)/2)
        let cellWidthWeekend = Int((cellWidth-10)/2)
        let cellHeight = Int((calendarViewHeight-40)/3)
        
        //weekSV.contentSize.width = CGFloat(calendarViewWidth+100)
        //MONDAY
        var modifiedDate = Calendar.current.date(byAdding: .day, value: 0, to: tempDate!)!
        weekView.addSubview(createDayForWeekView (x: 10, y: 10, width: cellWidth, height: cellHeight, selectedDate: modifiedDate))
        weekDate[0] = modifiedDate //this cariable stores the date ,so when user taps it, the correct Edit view shows the correct date.
        
        let myButton0 = UIButton()
        myButton0.setTitle("", for: .normal)
        myButton0.tag = 0 //Monday
        myButton0.frame = CGRect(x: 10, y: 10, width: cellWidth, height: cellHeight)
        myButton0.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        weekView.addSubview(myButton0)
       
        //TUESDAY
        modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate!)!
        weekView.addSubview(createDayForWeekView (x: 10 , y: cellHeight+20, width: cellWidth, height: cellHeight, selectedDate: modifiedDate))
        weekDate[1] = modifiedDate //this cariable stores the date ,so when user taps it, the correct Edit view shows the correct date.
        
        let myButton1 = UIButton()
        myButton1.setTitle("", for: .normal)
        myButton1.tag = 1 //Tuesday
        myButton1.frame = CGRect(x: 10, y: cellHeight+20, width: cellWidth, height: cellHeight)
        myButton1.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        weekView.addSubview(myButton1)
        
        
        
        //WEDNESDAY
        modifiedDate = Calendar.current.date(byAdding: .day, value: 2, to: tempDate!)!
        weekView.addSubview(createDayForWeekView (x: 10 , y: cellHeight+cellHeight+30, width: cellWidth, height: cellHeight, selectedDate: modifiedDate))
        weekDate[2] = modifiedDate //this cariable stores the date ,so when user taps it, the correct Edit view shows the correct date.
        
        let myButton2 = UIButton()
        myButton2.setTitle("", for: .normal)
        myButton2.tag = 2 //Wednesday
        myButton2.frame = CGRect(x: 10, y: cellHeight+cellHeight+30, width: cellWidth, height: cellHeight)
        myButton2.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        weekView.addSubview(myButton2)
        
        
        //THURSDAY
        modifiedDate = Calendar.current.date(byAdding: .day, value: 3, to: tempDate!)!
        weekView.addSubview(createDayForWeekView (x: cellWidth + 20  , y: 10, width: cellWidth, height: cellHeight, selectedDate: modifiedDate))
        weekDate[3] = modifiedDate //this cariable stores the date ,so when user taps it, the correct Edit view shows the correct date.
        
        let myButton3 = UIButton()
        myButton3.setTitle("", for: .normal)
        myButton3.tag = 3 //Wednesday
        myButton3.frame = CGRect(x: cellWidth + 20, y: 10, width: cellWidth, height: cellHeight)
        myButton3.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        weekView.addSubview(myButton3)
        
        //FRIDAY
        modifiedDate = Calendar.current.date(byAdding: .day, value: 4, to: tempDate!)!
        weekView.addSubview(createDayForWeekView (x: cellWidth+20 , y: cellHeight+20, width: cellWidth, height: cellHeight, selectedDate: modifiedDate))
        weekDate[4] = modifiedDate //this cariable stores the date ,so when user taps it, the correct Edit view shows the correct date.
        
        let myButton4 = UIButton()
        myButton4.setTitle("", for: .normal)
        myButton4.tag = 4 //Thursday
        myButton4.frame = CGRect(x: cellWidth + 20, y: cellHeight+20, width: cellWidth, height: cellHeight)
        myButton4.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        weekView.addSubview(myButton4)
        
        //SATURDAY
        modifiedDate = Calendar.current.date(byAdding: .day, value: 5, to: tempDate!)!
        weekView.addSubview(createDayForWeekView (x: cellWidth+20 , y: cellHeight+cellHeight+30, width: cellWidthWeekend, height: cellHeight, selectedDate: modifiedDate))
        weekDate[5] = modifiedDate //this cariable stores the date ,so when user taps it, the correct Edit view shows the correct date.
        
        let myButton5 = UIButton()
        myButton5.setTitle("", for: .normal)
        myButton5.tag = 5 //Saturday
        myButton5.frame = CGRect(x: cellWidth + 20, y: cellHeight+cellHeight+30, width: cellWidthWeekend, height: cellHeight)
        myButton5.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        weekView.addSubview(myButton5)
        
        //SUNDAY
        modifiedDate = Calendar.current.date(byAdding: .day, value: 6, to: tempDate!)!
        weekView.addSubview(createDayForWeekView (x: cellWidth+cellWidthWeekend+30 , y: cellHeight+cellHeight+30, width: cellWidthWeekend, height: cellHeight, selectedDate: modifiedDate))
        weekDate[6] = modifiedDate //this cariable stores the date ,so when user taps it, the correct Edit view shows the correct date.
        
        let myButton6 = UIButton()
        myButton6.setTitle("", for: .normal)
        myButton6.tag = 6 //Sunday
        myButton6.frame = CGRect(x: cellWidth+cellWidthWeekend+30, y: cellHeight+cellHeight+30, width: cellWidthWeekend, height: cellHeight)
        myButton6.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        weekView.addSubview(myButton6)
        
     }
    
    @IBAction func NextWeekBtnPressed(_ sender: Any) {
        weekOffset = weekOffset + 1
        refreshCalendar()
    }
    
    @IBAction func PreviousWeekBtnPressed(_ sender: Any) {
        weekOffset = weekOffset - 1
        refreshCalendar()
    }
    
    @IBAction func CloseWeekOverview(_ sender: Any) {
        print ("Close the Week View")
        
        screenSaverAllowed = true //allow to show the screen saver again once you are out off the settings screen
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func isALongYear (userYear: Int) -> Bool {
        // a Long year with 53 weeks is defined as: years in which 1 January or 31 December are Thursdays
        var dateComponents = DateComponents()
        dateComponents.year = userYear
        dateComponents.day = 1
        dateComponents.month = 1
        let userCalendar = Calendar(identifier: .iso8601)
        let firstOfJanDate = userCalendar.date(from: dateComponents)
        dateComponents.day = 31
        dateComponents.month = 12
        let thirtyFirstOfDecDate = userCalendar.date(from: dateComponents)
        
        let weekDayFirstOfJan = userCalendar.component(.weekday, from: firstOfJanDate!)
        let weekDaythirtyFirstOfDec = userCalendar.component(.weekday, from: thirtyFirstOfDecDate!)
        //check if these data are Thursday
        if weekDayFirstOfJan == 5 || weekDaythirtyFirstOfDec == 5 {
            return true
        }
        else {
            return false
        }
    }
    
    func createDayForWeekView (x: Int, y: Int, width: Int, height: Int, selectedDate: Date) -> UIView
    {
        
        let dateFormatter1 = DateFormatter()
        let dateFormatter2 = DateFormatter()
        
        dateFormatter1.dateFormat = DateFormatter.dateFormat(fromTemplate: "d EEEE", options: 0, locale: Locale.current)
        dateFormatter2.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM d EEEE", options: 0, locale: Locale.current)
        
        let selectedDay = Calendar.current.component(.day, from: selectedDate)
        let selectedMonth = Calendar.current.component(.month, from: selectedDate)
        let selectedYear = Calendar.current.component(.year, from: selectedDate)
        let selectedWeekDay = Calendar.current.component(.weekday, from: selectedDate)
        
        print ("the day give to me is :\(selectedWeekDay)")
        
        var tempTitleString: [String] = []
        var tempEventColours: [CGColor] = []
        var tempTimeString: [String] = []
        
        let myView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        switch (selectedWeekDay)
        {
        case 1:
            tempTitleString  = weekEventsTitle[6]
            tempEventColours = weekCalendarColours[6]
            tempTimeString   = weekEventsTime[6]
        
        case 2:
            tempTitleString  = weekEventsTitle[0]
            tempEventColours = weekCalendarColours[0]
            tempTimeString   = weekEventsTime[0]
        case 3:
            tempTitleString  = weekEventsTitle[1]
            tempEventColours = weekCalendarColours[1]
            tempTimeString   = weekEventsTime[1]
        case 4:
            tempTitleString  = weekEventsTitle[2]
            tempEventColours = weekCalendarColours[2]
            tempTimeString   = weekEventsTime[2]
        case 5:
            tempTitleString  = weekEventsTitle[3]
            tempEventColours = weekCalendarColours[3]
            tempTimeString   = weekEventsTime[3]
        case 6:
            tempTitleString  = weekEventsTitle[4]
            tempEventColours = weekCalendarColours[4]
            tempTimeString   = weekEventsTime[4]
        case 7:
            tempTitleString  = weekEventsTitle[5]
            tempEventColours = weekCalendarColours[5]
            tempTimeString   = weekEventsTime[5]
        default:
            print ("Error - 342")
        }
        
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOpacity = shadowOpacityView
        myView.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        myView.layer.shadowRadius = CGFloat(shadowRadiusView)
        myView.backgroundColor    = windowColor
        myView.layer.cornerRadius = subWindowborderRadius
        
        myView.layer.borderWidth  = borderWidthWindow
        myView.layer.borderColor  = borderColor.cgColor
        
        let calendar = Calendar.current
        if calendar.isDateInWeekend(selectedDate) {myView.backgroundColor    = subWindowColor }
        //Calendar date and day of the week
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: width, height: 30))
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.backgroundColor = .clear
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.textColor = mainTextColor
        if selectedDay == 1 {
            label.text = dateFormatter2.string(from: selectedDate)
        }
        else
        {
            label.text = dateFormatter1.string(from: selectedDate)
        }
        //The month changed mid week
        
        if currentYear == selectedYear && currentMonth == selectedMonth && currentDay == selectedDay
        {
            label.textColor = attentionTextColor
            myView.layer.borderWidth  = 2
            myView.layer.borderColor   = attentionTextColor.cgColor
        }
        else
        {
            label.textColor = mainTextColor
            myView.layer.borderWidth  = borderWidthWindow
            myView.layer.borderColor  = borderColor.cgColor
        }
        
        
        var calendarRows = tempTitleString.count
        var moreEventsThanCanBeShownInCell = false
        let maxRow = 6
        if calendarRows > (maxRow) {
            moreEventsThanCanBeShownInCell = true
            calendarRows = maxRow
        }
        
        if calendarRows > 6 {calendarRows = 6} // Max 6 calendar events
        let textspacing = 25
        let textStartPostitionY = 5
        //let timeLabelWidth = 70
        if calendarRows != 0 {
            for row in 0...calendarRows-1
            {
                if row == maxRow-1 && moreEventsThanCanBeShownInCell
                {
                    let label = UILabel(frame: CGRect(x: 14, y: 30+(textStartPostitionY+(row * textspacing)), width: width-14, height: 30))
                    label.font = UIFont.systemFont(ofSize: 15.0)
                    label.backgroundColor = .clear
                    label.lineBreakMode = .byTruncatingTail
                    label.textAlignment = .left
                    label.textColor = mainTextColor
                    label.text = NSLocalizedString("More Events", comment: "")
                    myView.addSubview(label)
                }
                else
                {
                    let imageView = UIImageView(frame: CGRect(x: 5, y: 30+(textStartPostitionY+(row * textspacing)+5), width: 4, height: 20))
                    imageView.image = UIImage(named: "CellIDImg_S")?.withRenderingMode(.alwaysTemplate)
                    imageView.tintColor = UIColor.init(cgColor: tempEventColours[row])
                    imageView.contentMode = .center
                    myView.addSubview(imageView)
                    
                    let label = UILabel(frame: CGRect(x: 14, y: 30+(textStartPostitionY+(row * textspacing)), width: width-14-70, height: 30))
                    label.font = UIFont.systemFont(ofSize: 15.0)
                    label.backgroundColor = .clear
                    label.lineBreakMode = .byTruncatingTail
                    label.textAlignment = .left
                    label.textColor = mainTextColor
                    label.text = tempTitleString[row]
                    myView.addSubview(label)
                    
                    let timeLbl = UILabel(frame: CGRect(x: width-70, y: 30+(textStartPostitionY+(row * textspacing)), width: 65, height: 30))
                    //timeLbl.font = UIFont.systemFont(ofSize: 15.0)
                    timeLbl.font = UIFont.monospacedDigitSystemFont(ofSize: 15.0, weight: UIFont.Weight.regular)
                    timeLbl.backgroundColor = .clear
                    timeLbl.lineBreakMode = .byClipping
                    timeLbl.textAlignment = .right
                    
                    timeLbl.textColor = subTextColor
                    timeLbl.text = tempTimeString[row]
                    myView.addSubview(timeLbl)
                }
            }
        }
        
        
        myView.addSubview(label)
        
        return myView
    }
    
   
    @objc func refreshCalendar()
    {
        print ("I updated the Calendar, so you should see the new entry")
        (weekEventsTitle,weekCalendarColours, weekEventsTime) = getWeekEventsFromCalendarStore(reqWeek: numOfWeek, reqYear: displayedYear, reqWeekOffset: weekOffset, requestedCalendars: userDayCalendars)
        //BEGIN - Remove all subviews, as this function is called more than once
        for v in weekView.subviews{
            v.removeFromSuperview()
        }
        //END
        
        fillWeekOverview (weekOffsetNumber:weekOffset, weekNumber: numOfWeek, year: displayedYear)
        
        //BEGIN - Update the month header since you scrolled to next month
        var dateComponents = DateComponents()
        dateComponents.weekOfYear = numOfWeek
        dateComponents.weekday = 2 //this makes sure the date is reflecting Mondays month name
        dateComponents.year = displayedYear
        
        let dateFormatter = DateFormatter()
        let userCalendar = Calendar(identifier: .iso8601)
        var tempDate = userCalendar.date(from: dateComponents)
        tempDate = Calendar.current.date(byAdding: .day, value: (7*(weekOffset)), to: tempDate!)!
        displayedYear = Calendar.current.component(.year, from: tempDate!)
        displayedMonth = Calendar.current.component(.month, from: tempDate!)
        
        if currentYear == displayedYear
        {
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM", options: 0, locale: Locale.current)
        }
        else
        {
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM YYYY", options: 0, locale: Locale.current)
        }
        monthHeaderLbl.text = dateFormatter.string(from: tempDate!)
        monthHeaderLbl.textColor = clockColor
    }
    
    
    @objc func buttonPressed(sender: UIButton)
    {
        screenSaverCounter = 0 //reset the timer.
        print ("The date pressed is: \(weekDate[sender.tag])")
        eventStartDate = weekDate[sender.tag]
        performSegue(withIdentifier: "CalendarEditSegue", sender: nil)
        
    }
}
