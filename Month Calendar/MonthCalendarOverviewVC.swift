//
//  MonthCalendarOverviewVC.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 14/8/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit

var currentDate = Date()
var selectedDate = Date()
var displayedMonth = 0
var displayedYear = 0
var displayedDay = 0
var currentDay = 0
var currentMonth  = 0
var currentYear = 0
//var dayCellWidth:CGFloat = 100
let numberOffDaysToLoad: Int = 30 //needs to be even so even numbers next to the selected date
//var calendarViewWidth:CGFloat = 100 //Thisvalue is used once layouts are layout to devide by 7 colums for the week
var dayButtonPressed:Int  = 0 //When user changes the moths Month, you need to know which day was pressed, so when returning to the month it can be displayed

var weekStartDay:Int = 1 // Sunday start of the week for month calendar

//var monthOffsetCounter = 0
var monthNumberArray :[Int] = [
    0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,
    0,0,0,0,0,0,0,
    0,0,0,0,0,0,0] //Sun,Mon,Tue,Wed,Thur,Fri,Sat this array holds the month number start from the Sunday over 5 rows


//var monthEventsTitle = [[String]]()
//var monthCalendarColors = [[CGColor]]()

class MonthCalendarOverviewVC: UIViewController,UIScrollViewDelegate {
   
    @IBOutlet var topHeaderView: UIImageView!
    @IBOutlet var headerDateLbl: UILabel!
    @IBOutlet var monthSV: UIScrollView!
    @IBOutlet var backgroundView: UIImageView?
    
    
    
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var monthSelectionView: UIView?

    @IBOutlet var addEventBtn: UIButton?
    
    @IBOutlet var month1PageLbl: UILabel!
    @IBOutlet var month2PageLbl: UILabel!
    @IBOutlet var month3PageLbl: UILabel!
    @IBOutlet var month4PageLbl: UILabel!
    @IBOutlet var month5PageLbl: UILabel!
    @IBOutlet var month6PageLbl: UILabel!
    @IBOutlet var month7PageLbl: UILabel!
    @IBOutlet var month8PageLbl: UILabel!
    @IBOutlet var month9PageLbl: UILabel!
    @IBOutlet var month10PageLbl: UILabel!
    @IBOutlet var month11PageLbl: UILabel!
    @IBOutlet var month12PageLbl: UILabel!
    
    @IBOutlet var month1PageBtn: UIButton!
    @IBOutlet var month2PageBtn: UIButton!
    @IBOutlet var month3PageBtn: UIButton!
    @IBOutlet var month4PageBtn: UIButton!
    @IBOutlet var month5PageBtn: UIButton!
    @IBOutlet var month6PageBtn: UIButton!
    @IBOutlet var month7PageBtn: UIButton!
    @IBOutlet var month8PageBtn: UIButton!
    @IBOutlet var month9PageBtn: UIButton!
    @IBOutlet var month10PageBtn: UIButton!
    @IBOutlet var month11PageBtn: UIButton!
    @IBOutlet var month12PageBtn: UIButton!
    
    @IBOutlet var month1PageView: UIView!
    @IBOutlet var month2PageView: UIView!
    @IBOutlet var month3PageView: UIView!
    @IBOutlet var month4PageView: UIView!
    @IBOutlet var month5PageView: UIView!
    @IBOutlet var month6PageView: UIView!
    @IBOutlet var month7PageView: UIView!
    @IBOutlet var month8PageView: UIView!
    @IBOutlet var month9PageView: UIView!
    @IBOutlet var month10PageView: UIView!
    @IBOutlet var month11PageView: UIView!
    @IBOutlet var month12PageView: UIView!
    
    @IBOutlet var weekDayView: UIView!
    @IBOutlet var MondayLbl:    UILabel!
    @IBOutlet var TuesdayLbl:   UILabel!
    @IBOutlet var WednesdayLbl: UILabel!
    @IBOutlet var ThursdayLbl:  UILabel!
    @IBOutlet var FridayLbl:    UILabel!
    @IBOutlet var SaturdayLbl:  UILabel!
    @IBOutlet var SundayLbl:    UILabel!
    
    @IBOutlet var nextYearBtn: UIButton!
    @IBOutlet var openYearChevronBtn: UIButton!
    //var updateCalendarTimer: Timer?
    
    
    
    
    func setColorsYearOverview()
    {
        month1PageView.layer.borderColor = attentionTextColor.cgColor
        month2PageView.layer.borderColor = attentionTextColor.cgColor
        month3PageView.layer.borderColor = attentionTextColor.cgColor
        month4PageView.layer.borderColor = attentionTextColor.cgColor
        month5PageView.layer.borderColor = attentionTextColor.cgColor
        month6PageView.layer.borderColor = attentionTextColor.cgColor
        month7PageView.layer.borderColor = attentionTextColor.cgColor
        month8PageView.layer.borderColor = attentionTextColor.cgColor
        month9PageView.layer.borderColor = attentionTextColor.cgColor
        month10PageView.layer.borderColor = attentionTextColor.cgColor
        month11PageView.layer.borderColor = attentionTextColor.cgColor
        month12PageView.layer.borderColor = attentionTextColor.cgColor
        
        month1PageView.layer.cornerRadius = 6
        month2PageView.layer.cornerRadius = 6
        month3PageView.layer.cornerRadius = 6
        month4PageView.layer.cornerRadius = 6
        month5PageView.layer.cornerRadius = 6
        month6PageView.layer.cornerRadius = 6
        month7PageView.layer.cornerRadius = 6
        month8PageView.layer.cornerRadius = 6
        month9PageView.layer.cornerRadius = 6
        month10PageView.layer.cornerRadius = 6
        month11PageView.layer.cornerRadius = 6
        month12PageView.layer.cornerRadius = 6
       
        month1PageLbl.textColor = mainTextColor
        month2PageLbl.textColor = mainTextColor
        month3PageLbl.textColor = mainTextColor
        month4PageLbl.textColor = mainTextColor
        month5PageLbl.textColor = mainTextColor
        month6PageLbl.textColor = mainTextColor
        month7PageLbl.textColor = mainTextColor
        month8PageLbl.textColor = mainTextColor
        month9PageLbl.textColor = mainTextColor
        month10PageLbl.textColor = mainTextColor
        month11PageLbl.textColor = mainTextColor
        month12PageLbl.textColor = mainTextColor
     
        MondayLbl.textColor = mainTextColor
        TuesdayLbl.textColor = mainTextColor
        WednesdayLbl.textColor = mainTextColor
        ThursdayLbl.textColor = mainTextColor
        FridayLbl.textColor = mainTextColor
        SaturdayLbl.textColor = mainTextColor
        SundayLbl.textColor = mainTextColor
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //This needs to be loaded only once, so do not move to viewwillappear, else the selected date moves every day
        displayedDay = Calendar.current.component(.day, from: Date())
        displayedMonth = Calendar.current.component(.month, from: Date())
        displayedYear = Calendar.current.component(.year, from: Date())
        //END
        let fmt = DateFormatter()
        let monthSymbols = fmt.shortMonthSymbols
        
        month1PageLbl.text = monthSymbols?[0]
        month2PageLbl.text = monthSymbols?[1]
        month3PageLbl.text = monthSymbols?[2]
        month4PageLbl.text = monthSymbols?[3]
        month5PageLbl.text = monthSymbols?[4]
        month6PageLbl.text = monthSymbols?[5]
        month7PageLbl.text = monthSymbols?[6]
        month8PageLbl.text = monthSymbols?[7]
        month9PageLbl.text = monthSymbols?[8]
        month10PageLbl.text = monthSymbols?[9]
        month11PageLbl.text = monthSymbols?[10]
        month12PageLbl.text = monthSymbols?[11]
        
        let fmt1 = DateFormatter()
        let weekSymbols = fmt1.shortWeekdaySymbols
        
       
        
        switch weekStartDay
        {
        case 1:
            MondayLbl.text = weekSymbols![1]
            TuesdayLbl.text = weekSymbols![2]
            WednesdayLbl.text = weekSymbols![3]
            ThursdayLbl.text = weekSymbols![4]
            FridayLbl.text = weekSymbols![5]
            SaturdayLbl.text = weekSymbols![6]
            SundayLbl.text = weekSymbols![0]
        
        case 2:
            MondayLbl.text = weekSymbols![2]
            TuesdayLbl.text = weekSymbols![3]
            WednesdayLbl.text = weekSymbols![4]
            ThursdayLbl.text = weekSymbols![5]
            FridayLbl.text = weekSymbols![6]
            SaturdayLbl.text = weekSymbols![0]
            SundayLbl.text = weekSymbols![1]
        
        case 3:
            MondayLbl.text = weekSymbols![3]
            TuesdayLbl.text = weekSymbols![4]
            WednesdayLbl.text = weekSymbols![5]
            ThursdayLbl.text = weekSymbols![6]
            FridayLbl.text = weekSymbols![0]
            SaturdayLbl.text = weekSymbols![1]
            SundayLbl.text = weekSymbols![2]
        
        case 4:
            MondayLbl.text = weekSymbols![4]
            TuesdayLbl.text = weekSymbols![5]
            WednesdayLbl.text = weekSymbols![6]
            ThursdayLbl.text = weekSymbols![0]
            FridayLbl.text = weekSymbols![1]
            SaturdayLbl.text = weekSymbols![2]
            SundayLbl.text = weekSymbols![3]
        case 5:
            MondayLbl.text = weekSymbols![5]
            TuesdayLbl.text = weekSymbols![6]
            WednesdayLbl.text = weekSymbols![0]
            ThursdayLbl.text = weekSymbols![1]
            FridayLbl.text = weekSymbols![2]
            SaturdayLbl.text = weekSymbols![3]
            SundayLbl.text = weekSymbols![4]
        case 6:
            MondayLbl.text = weekSymbols![6]
            TuesdayLbl.text = weekSymbols![0]
            WednesdayLbl.text = weekSymbols![1]
            ThursdayLbl.text = weekSymbols![2]
            FridayLbl.text = weekSymbols![3]
            SaturdayLbl.text = weekSymbols![4]
            SundayLbl.text = weekSymbols![5]
            
        case 7:
            MondayLbl.text = weekSymbols![0]
            TuesdayLbl.text = weekSymbols![1]
            WednesdayLbl.text = weekSymbols![2]
            ThursdayLbl.text = weekSymbols![3]
            FridayLbl.text = weekSymbols![4]
            SaturdayLbl.text = weekSymbols![5]
            SundayLbl.text = weekSymbols![6]
            
        default:
            print ("Error - week day names fell through!")
            
        }
        
        nextYearBtn.setTitle("", for: .normal)
        
        //updateMonthPageButtons(monthNumber:displayedMonth, yearNumber: displayedYear, loadEvents: false)
        
        //FIX UP, might be needed
        //getEventsFromCalendarStore(reqMonth: displayedMonth, reqYear: displayedYear, calendarFilterID: userCalendarListID)
        
    
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
    
    
    
    //used
    func updateMonthPageButtons(monthNumber:Int, yearNumber: Int){
        //getEventsFromCalendarStore(reqMonth: monthNumber, reqYear: yearNumber, calendarFilterID: userCalendarListID)
        screenSaverCounter = 0 //reset the timer when user is scrolling.
        
        
        if monthNumber == 1 {
            month1PageView.layer.borderWidth = 3
            month1PageView.backgroundColor = .clear
            displayedMonth = 1
            
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //pdateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
        }
        else{month1PageView.layer.borderWidth = 0}
        
        if monthNumber == 2 {
            month2PageView.layer.borderWidth = 3
            month2PageView.backgroundColor = .clear
            displayedMonth = 2
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
        }
        else{month2PageView.layer.borderWidth = 0}
        
        if monthNumber == 3 {
            month3PageView.layer.borderWidth = 3
            month3PageView.backgroundColor = .clear
            displayedMonth = 3
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
        }
        else{month3PageView.layer.borderWidth = 0}
        
        if monthNumber == 4 {
            month4PageView.layer.borderWidth = 3
            month4PageView.backgroundColor = .clear
            displayedMonth = 4
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
        }
        else{month4PageView.layer.borderWidth = 0}
        
        if monthNumber == 5 {
            month5PageView.layer.borderWidth = 3
            month5PageView.backgroundColor = .clear
            displayedMonth = 5
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
        }
        else{month5PageView.layer.borderWidth = 0}
        
        if monthNumber == 6 {
            month6PageView.layer.borderWidth = 3
            month6PageView.backgroundColor = .clear
            displayedMonth = 6
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
         }
        else{month6PageView.layer.borderWidth = 0}
        
        if monthNumber == 7 {
            month7PageView.layer.borderWidth = 3
            month7PageView.backgroundColor = .clear
            displayedMonth = 7
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
        }
        else{month7PageView.layer.borderWidth = 0}
        
        if monthNumber == 8 {
            month8PageView.layer.borderWidth = 3
            month8PageView.backgroundColor = .clear
            displayedMonth = 8
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
         }
        else{month8PageView.layer.borderWidth = 0}
        
        if monthNumber == 9 {
            month9PageView.layer.borderWidth = 3
            month9PageView.backgroundColor = .clear
            displayedMonth = 9
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
        }
        else{month9PageView.layer.borderWidth = 0}
        
        if monthNumber == 10 {
            month10PageView.layer.borderWidth = 3
            month10PageView.backgroundColor = .clear
            displayedMonth = 10
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
         }
        else{month10PageView.layer.borderWidth = 0}
        
        if monthNumber == 11 {
            month11PageView.layer.borderWidth = 3
            month11PageView.backgroundColor = .clear
            displayedMonth = 11
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
         }
        else{month11PageView.layer.borderWidth = 0}
        
        if monthNumber == 12 {
            month12PageView.layer.borderWidth = 3
            month12PageView.backgroundColor = .clear
            displayedMonth = 12
            //updateMonthCalenderFrame(reqMont: monthNumber, reqYear: yearNumber)
            //updateMonthCalender(reqMont: monthNumber, reqYear: yearNumber)
            updateDateHeader(reqMonth: monthNumber, reqYear: yearNumber)
        }
        else{month12PageView.layer.borderWidth = 0}
        
        
        //BEGIN - Update the marker in the individual calendar Months
    }
    
    
    func updateMonthCalender(reqMonth: Int, reqYear: Int) {
        //BEGIN I Neeed this value so I can calculate number of colums in collectionview
        monthSV.backgroundColor = .clear
        monthSV.contentSize.height = 1350
        monthSV.delegate = self
       
        monthNumberArray = self.initMonthArray (reqMonth: reqMonth, reqYear: reqYear)
        
        
        //BEGIN - Remove all subviews, as this function is called more than once
        for v in monthSV.subviews{
            v.removeFromSuperview()
        }
        //END
        let calendarViewWidth: Int = Int(UIScreen.main.bounds.width)-5
        let cellWidth:Int = Int((calendarViewWidth - 70) / 7)
        let cellHeight = 200
        //BEGIN - number of day correction for leap year
        //let numberOfDaysInMonth = numberOfDaysInMonth (Month: reqMont, Year: reqYear)
        var dateComponent = DateComponents()
        dateComponent.month = reqMonth
        dateComponent.year = reqYear
        
        //var tempTitleString:[[String]] = [[]]
        //var tempEventColors:[[CGColor]] = [[]]
        var tempTitleString = Array(repeating: [String](), count: 31)
        var tempEventColors = Array(repeating: [CGColor](), count: 31)
        
        if reqYear == thisYear {
            switch (reqMonth){
                
            case 1:
                tempTitleString = month1EventsTitle
                tempEventColors = month1CalendarColours
            case 2:
                tempTitleString = month2EventsTitle
                tempEventColors = month2CalendarColours
            case 3:
                tempTitleString = month3EventsTitle
                tempEventColors = month3CalendarColours
            case 4:
                tempTitleString = month4EventsTitle
                tempEventColors = month4CalendarColours
            case 5:
                tempTitleString = month5EventsTitle
                tempEventColors = month5CalendarColours
            case 6:
                tempTitleString = month6EventsTitle
                tempEventColors = month6CalendarColours
            case 7:
                tempTitleString = month7EventsTitle
                tempEventColors = month7CalendarColours
            case 8:
                tempTitleString = month8EventsTitle
                tempEventColors = month8CalendarColours
            case 9:
                tempTitleString = month9EventsTitle
                tempEventColors = month9CalendarColours
            case 10:
                tempTitleString = month10EventsTitle
                tempEventColors = month10CalendarColours
            case 11:
                tempTitleString = month11EventsTitle
                tempEventColors = month11CalendarColours
            case 12:
                tempTitleString = month12EventsTitle
                tempEventColors = month12CalendarColours
            default:
                print ("ERROR - Switch fell through! - 567")
            }
        }
        
        if reqYear == nextYear {
            switch (reqMonth){
                
            case 1:
                tempTitleString = month13EventsTitle
                tempEventColors = month13CalendarColours
            case 2:
                tempTitleString = month14EventsTitle
                tempEventColors = month14CalendarColours
            case 3:
                tempTitleString = month15EventsTitle
                tempEventColors = month15CalendarColours
            case 4:
                tempTitleString = month16EventsTitle
                tempEventColors = month16CalendarColours
            case 5:
                tempTitleString = month17EventsTitle
                tempEventColors = month17CalendarColours
            case 6:
                tempTitleString = month18EventsTitle
                tempEventColors = month18CalendarColours
            case 7:
                tempTitleString = month19EventsTitle
                tempEventColors = month19CalendarColours
            case 8:
                tempTitleString = month20EventsTitle
                tempEventColors = month20CalendarColours
            case 9:
                tempTitleString = month21EventsTitle
                tempEventColors = month21CalendarColours
            case 10:
                tempTitleString = month22EventsTitle
                tempEventColors = month22CalendarColours
            case 11:
                tempTitleString = month23EventsTitle
                tempEventColors = month23CalendarColours
            case 12:
                tempTitleString = month24EventsTitle
                tempEventColors = month24CalendarColours
            default:
                print ("ERROR - Switch fell through! - 567")
            }
        }
        
        
        for n in 0...41 {
            if monthNumberArray[n] == -1
            {
                //cell.dayCell.isHidden = true
                //cell.myLabel.isHidden = true
                //cell.isHidden = true
                //DO NOTHING YOU DO NOT NEED TO ADD A VIEW
            }
            else
            {
                let columnNumberDay = n % 7
                let rowNumberMonth = (n / 7)
                dateComponent.day =  monthNumberArray[n]
                var day = (monthNumberArray[n])
                //print ("PRE-------------------\(day)")
                day = day - 1
                //print ("-------------------\(day)")
                
                //print (tempTitleString)
                let tempDate = Calendar.current.date(from: dateComponent)
                
                //var groupedEventsTitle = Array(repeating: [String](), count: 31)
                //var groupedCalendarColours = Array(repeating: [CGColor](), count: 31)
                
                
                let tempView = createDayView (x: (columnNumberDay*(cellWidth+10)), y: (rowNumberMonth * (cellHeight+10)), width: cellWidth, height: 200, selectedDate: tempDate!, events: tempTitleString[day], eventColor: tempEventColors[day])
                
                monthSV.addSubview(tempView)
            }
        }
    }
 
    func redrawMonthCalender(reqMonth: Int, reqYear: Int ,tempTitleString: [[String]], tempEventColors: [[CGColor]] ){
        //BEGIN I Neeed this value so I can calculate number of colums in collectionview
        monthSV.backgroundColor = .clear
        monthSV.contentSize.height = 1350
        monthSV.delegate = self
       
        monthNumberArray = self.initMonthArray (reqMonth: reqMonth, reqYear: reqYear)
        
        
        //BEGIN - Remove all subviews, as this function is called more than once
        for v in monthSV.subviews{
            v.removeFromSuperview()
        }
        //END
        let calendarViewWidth: Int = Int(UIScreen.main.bounds.width)-5
        let cellWidth:Int = Int((calendarViewWidth - 70) / 7)
        let cellHeight = 200
        //BEGIN - number of day correction for leap year
        //let numberOfDaysInMonth = numberOfDaysInMonth (Month: reqMont, Year: reqYear)
        var dateComponent = DateComponents()
        dateComponent.month = reqMonth
        dateComponent.year = reqYear
        
        
        
        
        for n in 0...41 {
            if monthNumberArray[n] == -1
            {
                //cell.dayCell.isHidden = true
                //cell.myLabel.isHidden = true
                //cell.isHidden = true
                //DO NOTHING YOU DO NOT NEED TO ADD A VIEW
            }
            else
            {
                let columnNumberDay = n % 7
                let rowNumberMonth = (n / 7)
                dateComponent.day =  monthNumberArray[n]
                var day = (monthNumberArray[n])
                //print ("PRE-------------------\(day)")
                day = day - 1
                //print ("-------------------\(day)")
                
                //print (tempTitleString)
                let tempDate = Calendar.current.date(from: dateComponent)
                
                //var groupedEventsTitle = Array(repeating: [String](), count: 31)
                //var groupedCalendarColours = Array(repeating: [CGColor](), count: 31)
                
                
                let tempView = createDayView (x: (columnNumberDay*(cellWidth+10)), y: (rowNumberMonth * (cellHeight+10)), width: cellWidth, height: 200, selectedDate: tempDate!, events: tempTitleString[day], eventColor: tempEventColors[day])
                
                monthSV.addSubview(tempView)
            }
        }
    }
    
    
@objc func screenModeHasChanged()
    {
        print ("I updated the screen MODE")
        refreshCalendar()
        updateScreen()
    }
    
    override func viewWillAppear(_ animated: Bool){
        thisYear = Calendar.current.component(.year, from: Date())
        nextYear = thisYear + 1
        
        print ("Monthview will appear")
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = true //start slideshow when in this viewcontroller
        
        //BEGIN - get access so yuo speed up, by not asking for it all the time
        eventAccessApproved = EventStoreAuthorizations()
        //END
        
        //BEGIN - monitor if Calendar has been loaded in
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.screensaverRequested), name: Notification.Name("ScreensaverNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshCalendar), name: Notification.Name("updateMonthNotification"), object: nil)
        
        currentDate = Date()
        eventStartDate = Date()
        selectedDate = eventStartDate
        currentDay = Calendar.current.component(.day, from: Date())
        currentMonth  = Calendar.current.component(.month, from: Date())
        currentYear = Calendar.current.component(.year, from: Date())
        
        //BEGIN - this is also called when you edit an entry
        updateScreen()
        
        
        refreshCalendar()
        
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
        
        print ("View did appear and I update the shown calendar")
       
    
        //BEGIN - Start updating the 15 minutes timer for updating the calender and Today Calendar events, I picked 60 minutes as the background process to retrieve new calendar data is also synced every 60 minutes
        /*
        if updateCalendarTimer == nil {
            updateCalendarTimer = Timer.scheduledTimer(timeInterval: calendarUpdateFrequency, target: self, selector: #selector(self.refreshCalendar), userInfo: nil, repeats: true)
        }*/
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print ("I am scrolling so do not start screen saver,  I am doing stuff")
        
        screenSaverCounter = 0 //Reset the screen saver counter
    }
    
    @objc func refreshCalendar()
    {
        updateMonthPageButtons(monthNumber:displayedMonth, yearNumber: displayedYear) //Update the the Month buttons
        updateMonthCalender(reqMonth: displayedMonth, reqYear: displayedYear)          //Update the Calendar, assuming data is already loaded
        updateDateHeader(reqMonth: displayedMonth, reqYear: displayedYear)            //Update the header
        
        //BEGIN - This loads a fresh set of events, so if user came from settings and changed the calendar he wants to see, it will updated pretty quick, if the calendar is not cached it will be loaded in.
        DispatchQueue.main.async
        {
            var tempMonthEventsTitle = Array(repeating: [String](), count: 31)
            var tempMonthCalendarColours = Array(repeating: [CGColor](), count: 31)
            (tempMonthEventsTitle,tempMonthCalendarColours) = loadCalendarMonthData(reqMonth: displayedMonth, reqYear: displayedYear, reqCalendars: userDayCalendars)
            self.redrawMonthCalender(reqMonth: displayedMonth, reqYear: displayedYear ,tempTitleString: tempMonthEventsTitle, tempEventColors: tempMonthCalendarColours)
        }
        //END
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print ("TimerExpiredSegue20")
        
        performSegue(withIdentifier: "TimerExpiredSegue20", sender: nil)
    }
    //END
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //updateCalendarTimer?.invalidate()
        //updateCalendarTimer = nil
        
        print ("Stop notification")
        NotificationCenter.default.removeObserver(self)
    }
    
    func updateScreen(){
        setColorsYearOverview()
        openYearChevronBtn?.setImage(expandDrawerImage, for: .normal)
        openYearChevronBtn?.setImage(expandDrawerPressedImage, for: .highlighted)
        openYearChevronBtn!.layer.shadowColor = UIColor.black.cgColor
        openYearChevronBtn!.layer.shadowOpacity = shadowOpacityButtons
        openYearChevronBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        openYearChevronBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        topHeaderView?.image = topHeaderImage
        
        addEventBtn?.setImage(EditCalendarBtnImage, for: .normal)
        addEventBtn?.setImage(EditCalendarPressedBtnImage, for: .highlighted)
        addEventBtn!.layer.shadowColor = UIColor.black.cgColor
        addEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        addEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        addEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        addEventBtn!.layer.shadowColor = UIColor.black.cgColor
        addEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        addEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        addEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        month1PageBtn.setTitle("", for: .normal)
        month2PageBtn.setTitle("", for: .normal)
        month3PageBtn.setTitle("", for: .normal)
        month4PageBtn.setTitle("", for: .normal)
        month5PageBtn.setTitle("", for: .normal)
        month6PageBtn.setTitle("", for: .normal)
        month7PageBtn.setTitle("", for: .normal)
        month8PageBtn.setTitle("", for: .normal)
        month9PageBtn.setTitle("", for: .normal)
        month10PageBtn.setTitle("", for: .normal)
        month11PageBtn.setTitle("", for: .normal)
        month12PageBtn.setTitle("", for: .normal)
        
        backgroundView?.image = backgroundImage
        
        monthSelectionView!.layer.shadowColor = UIColor.black.cgColor
        monthSelectionView!.layer.shadowOpacity = shadowOpacityView
        monthSelectionView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        monthSelectionView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        monthSelectionView?.backgroundColor    = windowColor
        monthSelectionView?.layer.cornerRadius = cornerRadiusWindow
        monthSelectionView?.layer.borderWidth  = borderWidthWindow
        monthSelectionView?.layer.borderColor  = borderColor.cgColor
        
        //selectedDateLbl.textColor = mainTextColor
        headerDateLbl.textColor = mainTextColor
     }
    
    func initMonthArray (reqMonth: Int, reqYear: Int) -> [Int] //USED
    {
        //Week start day
        //1 = Sunday
        //2 = Monday
        //3 = Tuesday
        //4 = Wednesday
        //5 = Thursday
        //6 = Friday
        //7 = Saturday
        
        
        
        var tempMonthArray :[Int] = [
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1
        ]
        
        //Sun,Mon,Tue,Wed,Thur,Fri,Sat this array holds the month number start from the Sunday over 5 rows
        
        var dateComponent = DateComponents()
        dateComponent.day = 1
        dateComponent.month = reqMonth
        dateComponent.year = reqYear
        let firstDateOfTheMonth = Calendar.current.date(from: dateComponent)
        
        //BEGIN - integer from 1 - 7, with 1 being Sunday and 7 being Saturday
        let weekDayInt = Calendar.current.component(.weekday, from: firstDateOfTheMonth!)
        
        //BEGIN - number of day correction for leap year
        let numberOfDaysInMonth = numberOfDaysInMonth (Month: reqMonth, Year: reqYear)
        var startOfMonthItem:Int = 0
        switch (weekStartDay) {
        case 1: //Sunday = 1
            if weekDayInt == 1 {startOfMonthItem = 0}
            if weekDayInt == 2 {startOfMonthItem = 1}
            if weekDayInt == 3 {startOfMonthItem = 2}
            if weekDayInt == 4 {startOfMonthItem = 3}
            if weekDayInt == 5 {startOfMonthItem = 4}
            if weekDayInt == 6 {startOfMonthItem = 5}
            if weekDayInt == 7 {startOfMonthItem = 6}
            print ("Sunday")
        case 2: //Monday = 2
            if weekDayInt == 1 {startOfMonthItem = 6}
            if weekDayInt == 2 {startOfMonthItem = 0}
            if weekDayInt == 3 {startOfMonthItem = 1}
            if weekDayInt == 4 {startOfMonthItem = 2}
            if weekDayInt == 5 {startOfMonthItem = 3}
            if weekDayInt == 6 {startOfMonthItem = 4}
            if weekDayInt == 7 {startOfMonthItem = 5}
            print ("Monday")
        case 3: //Tuesday = 3
            if weekDayInt == 1 {startOfMonthItem = 5}
            if weekDayInt == 2 {startOfMonthItem = 6}
            if weekDayInt == 3 {startOfMonthItem = 0}
            if weekDayInt == 4 {startOfMonthItem = 1}
            if weekDayInt == 5 {startOfMonthItem = 2}
            if weekDayInt == 6 {startOfMonthItem = 3}
            if weekDayInt == 7 {startOfMonthItem = 4}
            print ("Tuesday")
        case 4: //Wednesday = 4
            if weekDayInt == 1 {startOfMonthItem = 4}
            if weekDayInt == 2 {startOfMonthItem = 5}
            if weekDayInt == 3 {startOfMonthItem = 6}
            if weekDayInt == 4 {startOfMonthItem = 0}
            if weekDayInt == 5 {startOfMonthItem = 1}
            if weekDayInt == 6 {startOfMonthItem = 2}
            if weekDayInt == 7 {startOfMonthItem = 3}
            print ("Wednesday")
        case 5: //Thursday = 5
            if weekDayInt == 1 {startOfMonthItem = 3}
            if weekDayInt == 2 {startOfMonthItem = 4}
            if weekDayInt == 3 {startOfMonthItem = 5}
            if weekDayInt == 4 {startOfMonthItem = 6}
            if weekDayInt == 5 {startOfMonthItem = 0}
            if weekDayInt == 6 {startOfMonthItem = 1}
            if weekDayInt == 7 {startOfMonthItem = 2}
            print ("Thursday")
        case 6: //Friday = 6
            if weekDayInt == 1 {startOfMonthItem = 2}
            if weekDayInt == 2 {startOfMonthItem = 3}
            if weekDayInt == 3 {startOfMonthItem = 4}
            if weekDayInt == 4 {startOfMonthItem = 5}
            if weekDayInt == 5 {startOfMonthItem = 6}
            if weekDayInt == 6 {startOfMonthItem = 0}
            if weekDayInt == 7 {startOfMonthItem = 1}
            print ("Friday")
        case 7: //Saturday = 7
            if weekDayInt == 1 {startOfMonthItem = 1}
            if weekDayInt == 2 {startOfMonthItem = 2}
            if weekDayInt == 3 {startOfMonthItem = 3}
            if weekDayInt == 4 {startOfMonthItem = 4}
            if weekDayInt == 5 {startOfMonthItem = 5}
            if weekDayInt == 6 {startOfMonthItem = 6}
            if weekDayInt == 7 {startOfMonthItem = 0}
            print ("Saturday")
        default:
            print ("ERROR - Week day switch fell through")
        }
        
        
        //BEGIN update the arrays for the selected month
        //let startOfMonthItem = (weekDayInt -  ) + (weekStartDay-1)
        
        for n in 0...numberOfDaysInMonth-1 {
            tempMonthArray[Int(startOfMonthItem + n)] = n + 1
        }
        
        return tempMonthArray
    }
    
    func initMonthArrayOld (reqMonth: Int, reqYear: Int) -> [Int] //USED
    {
        var tempMonthArray :[Int] = [
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1,
             -1,-1,-1,-1,-1,-1,-1
        ] //Sun,Mon,Tue,Wed,Thur,Fri,Sat this array holds the month number start from the Sunday over 5 rows
        
        var dateComponent = DateComponents()
        dateComponent.day = 1
        dateComponent.month = reqMonth
        dateComponent.year = reqYear
        let firstDateOfTheMonth = Calendar.current.date(from: dateComponent)
        
        //BEGIN - integer from 1 - 7, with 1 being Sunday and 7 being Saturday
        let weekDayInt = Calendar.current.component(.weekday, from: firstDateOfTheMonth!)
        
        //BEGIN - number of day correction for leap year
        let numberOfDaysInMonth = numberOfDaysInMonth (Month: reqMonth, Year: reqYear)
        
        
        //BEGIN update the arrays for the selected month
        let startOfMonthItem = weekDayInt - 1
        
        for n in 0...numberOfDaysInMonth-1 {
            tempMonthArray[Int(startOfMonthItem + n)] = n + 1
        }
        
        return tempMonthArray
    }
    @IBAction func monthSelectionButtonPressed(sender: UIButton){
        displayedMonth = sender.tag
        //getEventsFromCalendarStore(reqMonth: displayedMonth, reqYear: displayedYear, calendarFilterID: userCalendarListID)
        refreshCalendar()
        
    }
    
    @IBAction func monthSelectionButtonPressedDown(sender: UIButton){
        
        switch (sender.tag) {
        case 1:
            month1PageView.backgroundColor = buttonPressedColor
            
        case 2:
            month2PageView.backgroundColor = buttonPressedColor
            
        case 3:
            month3PageView.backgroundColor = buttonPressedColor
           
        case 4:
            month4PageView.backgroundColor = buttonPressedColor
           
        case 5:
            month5PageView.backgroundColor = buttonPressedColor
         
        case 6:
            month6PageView.backgroundColor = buttonPressedColor
            
        case 7:
            month7PageView.backgroundColor = buttonPressedColor
            
        case 8:
            month8PageView.backgroundColor = buttonPressedColor
            
        case 9:
            month9PageView.backgroundColor = buttonPressedColor
            
        case 10:
            month10PageView.backgroundColor = buttonPressedColor
           
        case 11:
            month11PageView.backgroundColor = buttonPressedColor
           
        case 12:
            month12PageView.backgroundColor = buttonPressedColor
            
        default:
            print ("switch fell Through")
        }
    }
    
    @IBAction func monthSelectionButtonCanceled(sender: UIButton){
        switch (sender.tag) {
        case 1:
            month1PageView.backgroundColor = .clear
           
        case 2:
            month2PageView.backgroundColor = .clear
            
        case 3:
            month3PageView.backgroundColor = .clear
         
        case 4:
            month4PageView.backgroundColor = .clear
            
        case 5:
            month5PageView.backgroundColor = .clear
           
        case 6:
            month6PageView.backgroundColor = .clear
            
        case 7:
            month7PageView.backgroundColor = .clear
           
        case 8:
            month8PageView.backgroundColor = .clear
            
        case 9:
            month9PageView.backgroundColor = .clear
            
        case 10:
            month10PageView.backgroundColor = .clear
          
        case 11:
            month11PageView.backgroundColor = .clear
            
        case 12:
            month12PageView.backgroundColor = .clear
            
        default:
            print ("switch fell Through")
        }
    }
    
    
   
    func updateDateHeader(reqMonth: Int, reqYear: Int) {
        var dateComponent = DateComponents()
        dateComponent.day = 1
        dateComponent.month = reqMonth
        dateComponent.year = reqYear
        
        let tempDate = Calendar.current.date(from: dateComponent)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM YYYY", options: 0, locale: Locale.current)
        
        headerDateLbl!.text = dateFormatter.string(from: tempDate!)
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        print ("Close the Month Calendart View")
        
        screenSaverAllowed = true //allow to show the screen saver again once you are out off the settings screen
        //BEGIN - stop and remove the timer
        self.dismiss(animated: true, completion: nil)
        //END
    }
    
    func createDayView (x: Int, y: Int, width: Int, height: Int, selectedDate: Date, events: [String], eventColor: [CGColor]) -> UIView
    {
        var calendarRows = events.count
        let textspacing = 20
        var moreEventsThanCanBeShownInCell = false
        let maxRow = 8
        if calendarRows > (maxRow) {
            moreEventsThanCanBeShownInCell = true
            calendarRows = maxRow
        }
        
        if calendarRows > maxRow {calendarRows = maxRow} // Max calendar check
        let textStartPostitionY = 5
        //let timeLabelWidth = 70
        let myView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOpacity = shadowOpacityView
        myView.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        myView.layer.shadowRadius = CGFloat(shadowRadiusView)
        myView.backgroundColor    = windowColor
        myView.layer.cornerRadius = subWindowborderRadius
        
        myView.layer.borderWidth  = borderWidthWindow
        myView.layer.borderColor  = borderColor.cgColor
        
        
        let myButton = UIButton()
        
        myButton.setTitle("", for: .normal)
        myButton.setTitleColor(.blue, for: .normal)
        let selectedDay = Calendar.current.component(.day, from: selectedDate)
        myButton.tag = selectedDay
        
        myButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        myButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        myView.addSubview(myButton)
        
        let calendar = Calendar.current
        if calendar.isDateInWeekend(selectedDate) {myView.backgroundColor    = subWindowColor }
        
        let label = UILabel(frame: CGRect(x: 5, y: 0, width: width, height: 30))
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.backgroundColor = .clear
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.textColor = mainTextColor
        label.text = "\(Calendar.current.component(.day, from: selectedDate))"
        
        //let selectedDay = Calendar.current.component(.day, from: selectedDate)
        let selectedMonth = Calendar.current.component(.month, from: selectedDate)
        let selectedYear = Calendar.current.component(.year, from: selectedDate)
        
        label.textColor = mainTextColor
        myView.layer.borderWidth  = borderWidthWindow
        myView.layer.borderColor  = borderColor.cgColor
        
        if currentDay == selectedDay
        {
            if currentMonth == selectedMonth
            {
                if currentYear == selectedYear
                {
                    label.textColor = attentionTextColor
                    myView.layer.borderWidth  = 2
                    myView.layer.borderColor   = attentionTextColor.cgColor
                }
            }
        }
        
        
        myView.addSubview(label)
        
        if calendarRows != 0 {
            for row in 0...calendarRows-1
            {
                //let startTime = requestedEventData.startTime[row]
                //let stopTime = requestedEventData.endTime[row]
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
                    let imageView = UIImageView(frame: CGRect(x: 5, y: 30+(textStartPostitionY+(row * textspacing)), width: 4, height: 30))
                    imageView.image = UIImage(named: "CellIDImg_S")?.withRenderingMode(.alwaysTemplate)
                    //imageView.tintColor = UIColor.init(cgColor: .red)
                    imageView.tintColor = UIColor.init(cgColor: eventColor[row])
                    
                    imageView.contentMode = .center
                    myView.addSubview(imageView)
                    
                    
                    let label = UILabel(frame: CGRect(x: 14, y: 30+(textStartPostitionY+(row * textspacing)), width: width-14, height: 30))
                    label.font = UIFont.systemFont(ofSize: 15.0)
                    label.backgroundColor = .clear
                    label.lineBreakMode = .byTruncatingTail
                    label.textAlignment = .left
                    label.textColor = mainTextColor
                    label.text = events[row]
                    myView.addSubview(label)
                }
            }
        }
        return myView
    }
    
    
    @objc func buttonPressed(sender: UIButton)
    {
        screenSaverCounter = 0 //reset the timer.
        
        var dateComponent = DateComponents()
        dateComponent.day = sender.tag
        dateComponent.month = displayedMonth
        dateComponent.year = displayedYear
        selectedDate  = Calendar.current.date(from: dateComponent)!
        eventStartDate = selectedDate
        performSegue(withIdentifier: "CalendarEditSegue", sender: nil)
        
    }
    
    
    
    
}
