//
//  ViewController.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 15/2/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit
import CoreMotion
import Photos
import StoreKit

//BEGIN store the size of the scrollview, so you do not need to retrieve it eveerytime
var todayScrollViewSize = 0
//END

var testvariable: Int = 0


var oldDay:Int = 0 //Used to update all screens in the middle of the night

//BEGIN - Declare the upcoming event array in memory beforehand so this works faster than
//creating this array when user accesses vthe table
let allPhotoAlbumCode: String = "9pPJorYFe" //This unique code is used to identify the 'all photo Albums strings' which is manually ad dt othe phot album list

struct UpcomingEvent {
    var name: [String] = []
    var eventDate: [String] = []
    var daysTillEvent: [String] = []
    var eventIsToday : [Bool] = []
    var calendarColour: [CGColor] = []
    var startDateOfEvent: [Date] = []
}

var upcomingEventCache = UpcomingEvent()
//END

//BEGIN - Declare the weekview array in memory beforehand so this works faster than

//BEGIN - Allocate global array to store current month events, for faster accessign the data in month view
var month1EventsTitle = Array(repeating: [String](), count: 31)
var month1CalendarColours = Array(repeating: [CGColor](), count: 31)

var month2EventsTitle = Array(repeating: [String](), count: 31)
var month2CalendarColours = Array(repeating: [CGColor](), count: 31)

var month3EventsTitle = Array(repeating: [String](), count: 31)
var month3CalendarColours = Array(repeating: [CGColor](), count: 31)

var month4EventsTitle = Array(repeating: [String](), count: 31)
var month4CalendarColours = Array(repeating: [CGColor](), count: 31)

var month5EventsTitle = Array(repeating: [String](), count: 31)
var month5CalendarColours = Array(repeating: [CGColor](), count: 31)

var month6EventsTitle = Array(repeating: [String](), count: 31)
var month6CalendarColours = Array(repeating: [CGColor](), count: 31)

var month7EventsTitle = Array(repeating: [String](), count: 31)
var month7CalendarColours = Array(repeating: [CGColor](), count: 31)

var month8EventsTitle = Array(repeating: [String](), count: 31)
var month8CalendarColours = Array(repeating: [CGColor](), count: 31)

var month9EventsTitle = Array(repeating: [String](), count: 31)
var month9CalendarColours = Array(repeating: [CGColor](), count: 31)

var month10EventsTitle = Array(repeating: [String](), count: 31)
var month10CalendarColours = Array(repeating: [CGColor](), count: 31)


var month11EventsTitle = Array(repeating: [String](), count: 31)
var month11CalendarColours = Array(repeating: [CGColor](), count: 31)

var month12EventsTitle = Array(repeating: [String](), count: 31)
var month12CalendarColours = Array(repeating: [CGColor](), count: 31)

//Next Year
var month13EventsTitle = Array(repeating: [String](), count: 31)
var month13CalendarColours = Array(repeating: [CGColor](), count: 31)

var month14EventsTitle = Array(repeating: [String](), count: 31)
var month14CalendarColours = Array(repeating: [CGColor](), count: 31)

var month15EventsTitle = Array(repeating: [String](), count: 31)
var month15CalendarColours = Array(repeating: [CGColor](), count: 31)

var month16EventsTitle = Array(repeating: [String](), count: 31)
var month16CalendarColours = Array(repeating: [CGColor](), count: 31)

var month17EventsTitle = Array(repeating: [String](), count: 31)
var month17CalendarColours = Array(repeating: [CGColor](), count: 31)

var month18EventsTitle = Array(repeating: [String](), count: 31)
var month18CalendarColours = Array(repeating: [CGColor](), count: 31)

var month19EventsTitle = Array(repeating: [String](), count: 31)
var month19CalendarColours = Array(repeating: [CGColor](), count: 31)

var month20EventsTitle = Array(repeating: [String](), count: 31)
var month20CalendarColours = Array(repeating: [CGColor](), count: 31)

var month21EventsTitle = Array(repeating: [String](), count: 31)
var month21CalendarColours = Array(repeating: [CGColor](), count: 31)

var month22EventsTitle = Array(repeating: [String](), count: 31)
var month22CalendarColours = Array(repeating: [CGColor](), count: 31)

var month23EventsTitle = Array(repeating: [String](), count: 31)
var month23CalendarColours = Array(repeating: [CGColor](), count: 31)

var month24EventsTitle = Array(repeating: [String](), count: 31)
var month24CalendarColours = Array(repeating: [CGColor](), count: 31)



//END


//END
var oldPartOfTheDay:Int = -1          //This value is used so the screen mode change does not trigger all the time, just when it changes
//var transientMessageQueu : [String] = [] //This queu hold all the messages to be displayed
var dayMode = true //variable you can use select what theme is displayed
let defaults = UserDefaults.standard//user default store
var titles : [String] = []          //required for 1st calendar view
var startDates : [NSDate] = []      //required for 1st calendar view
var endDates   : [NSDate] = []      //required for 1st calendar view
var todayScrollViewSelectedDate = Date()

let eventStore = EKEventStore()     //required for calendar view
//var calendarNames :[String] = []    //Array of all calendar names
//var calendarTypes :[Int] = []       //Array of all calender type

//var timerLabel: UILabel?            //required so the timer can be updated
var timerSeconds: Int = 0           //Timer value
var timerRunning: Bool = false      //flag to indicate if the kitchen timer is running
var timerExpired: Bool = false      //flag to indicate if the timer expired window is active
let systemSoundID: SystemSoundID = 1309 //will play when timer expires
var screenSaverActive = false       //this flag tells the system if photos are being displayed so do not update other screens
var screenSaverAllowed = true       //screen saver is allowed to execute, used to disabled when timer is running

let numberOfAlarmRepeats:Int = 3    //play alarm sound only a limited time

var screenSaverCounter:Double = 0   //counter to use to count before photo slide show start

var slideShowImage: UIImage?

let maxZoomLevelPhoto: Float = 5   //This is the maximum of zoom level applied to the phot0 when shown in screensaver mode, user can change this in settings
var screenTheme:Int = 2           //0 = Always Light, 1 = Always Night, 2 = Auto Screen theme switching
//var fetchedYearCalendar: Bool = false // this flag is needed tif the calendar is not fetch and user goes to other view, when he returns they month calendar icon can be unhidden, in the viewwillappear function

enum calendarRecurrence : Int {
    case none,daily,weekly,month,year
}


enum States : Int {
    case Normal,Settings
}

enum TimerButtonStates : Int {
    case Start,Pause,Reset
}
var quickPickList1 :[String] = [NSLocalizedString("Bread", comment: ""),NSLocalizedString("Milk", comment: ""),NSLocalizedString("Eggs", comment: ""), "","","","", "", "","","","","","","","","","","","","","","","DELETE"]    //Array of 24 shopping items, including Delete.

//var currentState  = States.Normal

//BEGIN - define the button states for the timer, so you only update the button once
var timerState = TimerButtonStates.Pause
//var oldTimerState = TimerButtonStates.Pause

//END

//BEGIN - Get screen size iPad
let screenRect = UIScreen.main.bounds
let screenWidth = screenRect.size.width
let screenHeight = screenRect.size.height
//END

var clockUpdateTimer: Timer?
var calendarTimer: Timer?
var screenBrightnessTimer: Timer?  //checks every second if the screen brigness needs to be adjusted, for Day,Night or Sleep

//END





class ViewController: UIViewController,UITextViewDelegate , UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,SKPaymentTransactionObserver {
    @IBOutlet var clockLabel:      UILabel?     //Clock Label
    @IBOutlet var backgroundView:  UIImageView? //Background image
    @IBOutlet var topHeaderView:             UIImageView? //Clock Header
    @IBOutlet var topHeaderShoppingListView: UIImageView? //ShoppingList Header
    @IBOutlet var topHeaderToDoView:         UIImageView? //To Do Header
    @IBOutlet var topHeaderTodayEventView:   UIImageView? //Today Event Header
    @IBOutlet var topHeaderTimerView:        UIImageView? //Timer Header
    @IBOutlet var topHeaderBirthdayView:     UIImageView? //Birthday Header
    
    //BEGIN - MAX Birthday View
    @IBOutlet var maxTopHeaderBirthdayView:     UIImageView? //Birthday Header
    @IBOutlet var maxBirthdayWindowLbl: UILabel!
    @IBOutlet var maxBirthdayCalendarView: UIView? //Calendar showing the birthdays
    @IBOutlet var maxBirthdayCalendarTableView: UITableView! //Birthday calendar table view
    @IBOutlet var minBirthdayCalendarBtn: UIButton?    //Button go to minimum birthday calendar View
    @IBOutlet var maxBirthdayCalendarBtn: UIButton?    //Button go to maximum birthday calendar View
    //END
    
    @IBOutlet var addTodayCalendarBtn: UIButton?    //Button to add Calendar if user has not selected one yet
    @IBOutlet var addUpcomingCalendarBtn: UIButton? //Button to add upcoming Event Calendar if user has not selected one yet
    @IBOutlet var maxAddUpcomingCalendarBtn: UIButton? //Button to add upcoming Event Calendar to Max birthday view if user has not selected one yet
    
    //@IBOutlet var dateLabel:       UILabel?     //Date Label
    @IBOutlet var settingBtn:      UIButton?    //Settings Button
    @IBOutlet var searchBtn:      UIButton?    //Settings Button
    @IBOutlet var screenSaverBtn:  UIButton?    //Screen saver button
    @IBOutlet var favouritesBtn: UIButton?      //favourites button
    @IBOutlet var toDoView:        UIView?      //To do View
    @IBOutlet var toDoListDeleteBtn:       UIButton? //To do Delete text button
    @IBOutlet var reminderBtn: UIButton? //Reminder button in hear bar
    
    @IBOutlet var toDoTextField:   UITextView?  //Text field inside the To Do View
    
    @IBOutlet var shoppingListWindowLbl:       UILabel!
    @IBOutlet var shoppingListView:            UIView?      //Shopping List View
    @IBOutlet var shoppingListDeleteBtn:       UIButton?
   
    @IBOutlet var shoppingListTextField:       UITextView?  //Shopping List Text Field
    
    @IBOutlet var timerView:       UIView?      //Kitchen Timer View
    @IBOutlet var resetTimerBtn: UIButton?      //Kitchen Timer Button
    @IBOutlet var startTimerBtn: UIButton?      //Kitchen Timer Button
    @IBOutlet var minutes10Btn:  UIButton?      //Kitchen Timer Button
    @IBOutlet var minutesBtn:    UIButton?      //Kitchen Timer Button
    @IBOutlet var seconds10Btn:  UIButton?      //Kitchen Timer Button
    @IBOutlet var kitchenTimerLbl:    UILabel?  //Kitchen Timer Label
    @IBOutlet var smallKitchenTimerLbl:    UILabel?  //Small Kitchen Timer Label
    @IBOutlet var todayCalendarView: UIView?    //Calender showing today's events
    
    @IBOutlet var calendarFocusBtn: UIButton?
    @IBOutlet var monthCalendarBtn: UIButton?
    @IBOutlet var calendarEditBtn: UIButton?
    @IBOutlet var birthdayCalendarView: UIView? //Calendar showing the birthdays
    @IBOutlet var timerBtn: UIButton?
    @IBOutlet var weekOutlookBtn: UIButton?
    @IBOutlet var upcommingEventBtn: UIButton?
    
    
    //@IBOutlet var todayCalendarTableView: UITableView! //Today calendar table view
    @IBOutlet var birthdayCalendarTableView: UITableView! //Birthday calendar table view
    
    @IBOutlet var todoWindowLbl: UILabel!
    @IBOutlet var birthdayWindowLbl: UILabel!
    @IBOutlet var todayWindowLbl: UILabel!
    @IBOutlet var timerWindowLbl: UILabel!
   
    //@IBOutlet var yesterdayBtn: UIButton!
    //@IBOutlet var nextDayBtn:   UIButton!
    
    @IBOutlet var shareToDoBtn:   UIButton!
    @IBOutlet var shareShoppingListBtn:   UIButton!
    @IBOutlet var shareVw: UIView!
    @IBOutlet var transientPopup: UIView!
    @IBOutlet var transientTextLbl: UILabel?
    @IBOutlet var slideShowDelayStepper: UIStepper!      //Stepper control to set delay before slide show  starts
    
    @IBOutlet var barItem1: UITabBarItem!
    @IBOutlet var todayCalendarScrollView:  UIScrollView!
    
    
    @IBOutlet var day0OverviewPageBtn: UIButton!
    @IBOutlet var day1OverviewPageBtn: UIButton!
    @IBOutlet var day2OverviewPageBtn: UIButton!
    @IBOutlet var day3OverviewPageBtn: UIButton!
    @IBOutlet var day4OverviewPageBtn: UIButton!
    @IBOutlet var day5OverviewPageBtn: UIButton!
    @IBOutlet var day6OverviewPageBtn: UIButton!
    
    @IBOutlet var day0OverviewPageLbl: UILabel!
    @IBOutlet var day1OverviewPageLbl: UILabel!
    @IBOutlet var day2OverviewPageLbl: UILabel!
    @IBOutlet var day3OverviewPageLbl: UILabel!
    @IBOutlet var day4OverviewPageLbl: UILabel!
    @IBOutlet var day5OverviewPageLbl: UILabel!
    @IBOutlet var day6OverviewPageLbl: UILabel!
    
    @IBOutlet var day0OverviewPageView: UIView!
    @IBOutlet var day1OverviewPageView: UIView!
    @IBOutlet var day2OverviewPageView: UIView!
    @IBOutlet var day3OverviewPageView: UIView!
    @IBOutlet var day4OverviewPageView: UIView!
    @IBOutlet var day5OverviewPageView: UIView!
    @IBOutlet var day6OverviewPageView: UIView!
    
    

    @IBOutlet var inAppBtn: UIButton!
    @IBOutlet var noteBtn: UIButton!
    
    
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
     
    @IBAction func toggleTimerView()
    {
        screenSaverCounter = 0 //Reset the screen saver counter
        if birthdayCalendarViewMax {
            print ("Go MIN")
            birthdayCalendarViewMax = false
        }
        else{
            print ("Go Max")
            birthdayCalendarViewMax = true
        }
        updateTimerBtnState()
    }
    
    func updateTimerBtnState()
    {
        if birthdayCalendarViewMax {
            timerBtn?.setImage(timerImage, for: .normal)
            timerBtn?.setImage(timerPressedImage, for: .highlighted)
            maxBirthdayCalendarView!.isHidden = false
            timerView?.isHidden = true
            birthdayCalendarView!.isHidden = true
        }
        else {
            timerBtn?.setImage(timerActiveImage, for: .normal)
            timerBtn?.setImage(timerActivePressedImage, for: .highlighted)
            maxBirthdayCalendarView!.isHidden = true
            timerView?.isHidden = false
            birthdayCalendarView!.isHidden = false
        }
    }
    /*
    override func viewDidLayoutSubviews() {
        if todayScrollViewSize == 0 //only run once else you got jitter as this fucnbtion runs every time a new view is created or viewcontreller changes
        {
            print ("_____")
            DispatchQueue.main.async {self.updateDayView()}
        }
    }*/
    
    func updateDayView()
    {
        todayScrollViewSize = Int(todayCalendarScrollView.frame.width)
        print ("I update the day calendar")
        //BEGIN - Remove all subviews, as this function is called more than once
        for v in todayCalendarScrollView.subviews{
            v.removeFromSuperview()
        }
        //END
        
        let today = Date()
        var tempView:UIView
        let numberOfDaysToRetrieve = 7
        var maxHeightOfAllViews: CGFloat = 0
        for i in 0...numberOfDaysToRetrieve-1
        {
            let tempDay = Calendar.current.date(byAdding: .day, value: i, to: today)
            tempView = createDayCalendarView (x: Int(CGFloat(todayCalendarScrollView.frame.width)*CGFloat(i)), y: 0, width: Int(CGFloat(todayCalendarScrollView.frame.width)), selectedDate: tempDay!)
            todayCalendarScrollView.addSubview(tempView)
            //you need to get the view with the bigest height,so you can set the conent mode correect for all views, so useer can scroll
            if (maxHeightOfAllViews < tempView.frame.height) {maxHeightOfAllViews = tempView.frame.height}
        }
        todayCalendarScrollView.contentSize.width = todayCalendarScrollView.frame.width*CGFloat(numberOfDaysToRetrieve)
        todayCalendarScrollView.contentSize.height = maxHeightOfAllViews
    }
    
    @IBAction func dayPressedAction(sender: UIButton!){
        screenSaverCounter = 0 //Reset the screen saver counter
        print ("Page selector pressed: \(sender.tag)")
        updateWeekPage(page: Int(sender.tag))
        todayCalendarScrollView.setContentOffset(CGPoint(x: CGFloat((CGFloat(sender.tag) * todayCalendarScrollView.frame.width)), y: 0), animated: false)
        
        
        let tempDate = Calendar.current.date(byAdding: .day, value: sender.tag, to: Date())
        
        updateDateHeaderInTodayView(newDate:tempDate!)
     }
    
    

    @IBAction func updateWeekDaysButtonPressedDown(sender: UIButton){
        screenSaverCounter = 0 //Reset the screen saver counter
        switch (sender.tag) {
        case 0:
            day0OverviewPageView.backgroundColor = buttonPressedColor
            
        case 1:
            day1OverviewPageView.backgroundColor = buttonPressedColor
            
        case 2:
            day2OverviewPageView.backgroundColor = buttonPressedColor
           
        case 3:
            day3OverviewPageView.backgroundColor = buttonPressedColor
           
        case 4:
            day4OverviewPageView.backgroundColor = buttonPressedColor
         
        case 5:
            day5OverviewPageView.backgroundColor = buttonPressedColor
            
        case 6:
            day6OverviewPageView.backgroundColor = buttonPressedColor
        default:
            print ("switch fell Through")
        }
    }
    
    @IBAction func updateWeekDaysButtonCanceled(sender: UIButton){
        screenSaverCounter = 0 //Reset the screen saver counter
        switch (sender.tag) {
        case 0:
            day0OverviewPageView.backgroundColor = .clear
            
        case 1:
            day1OverviewPageView.backgroundColor = .clear
            
        case 2:
            day2OverviewPageView.backgroundColor = .clear
           
        case 3:
            day3OverviewPageView.backgroundColor = .clear
           
        case 4:
            day4OverviewPageView.backgroundColor = .clear
         
        case 5:
            day5OverviewPageView.backgroundColor = .clear
            
        case 6:
            day6OverviewPageView.backgroundColor = .clear
        default:
            print ("switch fell Through")
        }
    }
    
    
    func updateWeekDaysPageView(pageNumber:Int){
        day0OverviewPageView.layer.borderColor = attentionTextColor.cgColor
        day1OverviewPageView.layer.borderColor = attentionTextColor.cgColor
        day2OverviewPageView.layer.borderColor = attentionTextColor.cgColor
        day3OverviewPageView.layer.borderColor = attentionTextColor.cgColor
        day4OverviewPageView.layer.borderColor = attentionTextColor.cgColor
        day5OverviewPageView.layer.borderColor = attentionTextColor.cgColor
        day6OverviewPageView.layer.borderColor = attentionTextColor.cgColor
            
        day0OverviewPageView.layer.cornerRadius = 6
        day1OverviewPageView.layer.cornerRadius = 6
        day2OverviewPageView.layer.cornerRadius = 6
        day3OverviewPageView.layer.cornerRadius = 6
        day4OverviewPageView.layer.cornerRadius = 6
        day5OverviewPageView.layer.cornerRadius = 6
        day6OverviewPageView.layer.cornerRadius = 6
           
        day0OverviewPageLbl.textColor = mainTextColor
        day1OverviewPageLbl.textColor = mainTextColor
        day2OverviewPageLbl.textColor = mainTextColor
        day3OverviewPageLbl.textColor = mainTextColor
        day4OverviewPageLbl.textColor = mainTextColor
        day5OverviewPageLbl.textColor = mainTextColor
        day6OverviewPageLbl.textColor = mainTextColor
        
        //let myView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        let today = Date()
        //let dateFormatter1 = DateFormatter()
        let fmt = DateFormatter()
        let weekSymbols = fmt.shortWeekdaySymbols
        
        
        //dateFormatter1.dateFormat = DateFormatter.dateFormat(fromTemplate: "E", options: 0, locale: Locale.current)
        
        var tempDate = Calendar.current.date(byAdding: .day, value: 0, to: today)
        day0OverviewPageLbl.text = weekSymbols![weekday(day:tempDate!)!]
        //day0OverviewPageBtn.setTitle(NSLocalizedString("Today", comment: ""), for: .normal) In dutch the word 'vandaag' gets truncated
        if pageNumber == 0 {
            day0OverviewPageView.layer.borderWidth = 3
            day0OverviewPageView.backgroundColor = .clear
        }
        else{day0OverviewPageView.layer.borderWidth = 0}
        
        tempDate = Calendar.current.date(byAdding: .day, value: 1, to: today)
        day1OverviewPageLbl.text = weekSymbols![weekday(day:tempDate!)!]
        if pageNumber == 1 {
            day1OverviewPageView.layer.borderWidth = 3
            day1OverviewPageView.backgroundColor = .clear
        }
        else{day1OverviewPageView.layer.borderWidth = 0}
        
        tempDate = Calendar.current.date(byAdding: .day, value: 2, to: today)
        day2OverviewPageLbl.text = weekSymbols![weekday(day:tempDate!)!]
        if pageNumber == 2 {
            day2OverviewPageView.layer.borderWidth = 3
            day2OverviewPageView.backgroundColor = .clear
        }
        else{day2OverviewPageView.layer.borderWidth = 0}
        
        tempDate = Calendar.current.date(byAdding: .day, value: 3, to: today)
        day3OverviewPageLbl.text = weekSymbols![weekday(day:tempDate!)!]
        if pageNumber == 3 {
            day3OverviewPageView.layer.borderWidth = 3
            day3OverviewPageView.backgroundColor = .clear
        }
        else{day3OverviewPageView.layer.borderWidth = 0}
        
        tempDate = Calendar.current.date(byAdding: .day, value: 4, to: today)
        day4OverviewPageLbl.text = weekSymbols![weekday(day:tempDate!)!]
        if pageNumber == 4 {
            day4OverviewPageView.layer.borderWidth = 3
            day4OverviewPageView.backgroundColor = .clear
        }
        else{day4OverviewPageView.layer.borderWidth = 0}
        
        tempDate = Calendar.current.date(byAdding: .day, value: 5, to: today)
        day5OverviewPageLbl.text = weekSymbols![weekday(day:tempDate!)!]
        if pageNumber == 5 {
            day5OverviewPageView.layer.borderWidth = 3
            day5OverviewPageView.backgroundColor = .clear
        }
        else{day5OverviewPageView.layer.borderWidth = 0}
        
        tempDate = Calendar.current.date(byAdding: .day, value: 6, to: today)
        day6OverviewPageLbl.text = weekSymbols![weekday(day:tempDate!)!]
        if pageNumber == 6 {
            day6OverviewPageView.layer.borderWidth = 3
            day6OverviewPageView.backgroundColor = .clear
        }
        else{day6OverviewPageView.layer.borderWidth = 0}
    }
    
        
     
    
    //BEGIN - Check if user stopped scrolling day view so you can update the date ontop of the view, which shows which day of the week is shwon
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        let pageWidth = todayCalendarScrollView.frame.size.width
        let currentPage = Int(floor((todayCalendarScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        print("page = \(currentPage)")
        print ("current page is : \(currentPage)")
        
        let today = Date()
        let tempDate = Calendar.current.date(byAdding: .day, value: currentPage, to: today)
        updateDateHeaderInTodayView(newDate:tempDate!)
        let pageIndex = round(todayCalendarScrollView.contentOffset.x/todayCalendarScrollView.frame.width)
        //pageControlDayWindow.currentPage = Int(pageIndex)
        //pageControlDayWindow.currentPageIndicatorTintColor = attentionTextColor
        
        updateWeekPage(page: Int(pageIndex))
    }
    
    func updateDateHeaderInTodayView(newDate: Date){
        let daysBeforeEvent = daysBetweenDates (endDate:newDate as Date)
        let dateFormatter1 = DateFormatter()
        let dateFormatter2 = DateFormatter()
        dateFormatter1.dateFormat = DateFormatter.dateFormat(fromTemplate: "eeedMMM", options: 0, locale: Locale.current)
        dateFormatter2.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMMM", options: 0, locale: Locale.current)
        todayScrollViewSelectedDate = newDate
        switch (daysBeforeEvent){
        case 0:
            
            self.todayWindowLbl?.text = NSLocalizedString("Today", comment: "") + ", " + dateFormatter2.string(from: newDate as Date)
        case -1:
            
            self.todayWindowLbl?.text = NSLocalizedString("Yesterday", comment: "") + ", " + dateFormatter2.string(from: newDate as Date)
        case 1:
        
            self.todayWindowLbl?.text = NSLocalizedString("Tomorrow", comment: "") + ", " + dateFormatter2.string(from: newDate as Date)
        default:
            self.todayWindowLbl?.text = dateFormatter1.string(from: newDate as Date)
        }
    }
    
    
    func updateWeekPage(page: Int){
        updateWeekDaysPageView(pageNumber:page)
    }
    
    @objc func viewIsTapped() {
        print("Calendar or birthday calender is tapped")
        calendarEdit()
        eventStartDate = todayScrollViewSelectedDate
        performSegue(withIdentifier: "CalendarEditSegueID", sender: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //BEGIN - fetchthe calendar when the program startes alese you need to wait till timer triggers.
        displayedYear = Calendar.current.component(.year, from: currentDate)
        displayedMonth = Calendar.current.component(.month, from: currentDate)
        //END
        monthCalendarBtn?.isHidden = false //do not offer to enter the full calendar while downloading the data first
        fetchYearCalendarInBackground()
        SKPaymentQueue.default().add(self)
        
        
        
        //Add touch gesture to calender and birtday scroll view, so user can edit calendar just by tapping it (today, upcoming max, upcoming min)
        let viewIsTapped0 = UITapGestureRecognizer(target: self, action: #selector(viewIsTapped))
        //let viewIsTapped1 = UITapGestureRecognizer(target: self, action: #selector(viewIsTapped))
        //let viewIsTapped2 = UITapGestureRecognizer(target: self, action: #selector(viewIsTapped))
        todayCalendarScrollView.addGestureRecognizer(viewIsTapped0)
        //birthdayCalendarView!.addGestureRecognizer(viewIsTapped1)
        //maxBirthdayCalendarView!.addGestureRecognizer(viewIsTapped2)
        //END
        
        //BEGIN - if user had a notes stored before retrieve it and load in global variables
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        print ("View did load")
        //BEGIN - check for authorizations Calendar Events
        eventAccessApproved = EventStoreAuthorizationsApproved()
        photoAccessApproved = PhotoAuthorizationsApproved()
        
        popupRequestIfEventOrPhotoStoreIsDisabled()
       
        loadUserDefaults()
        //BEGIN load the month array
        //getEventsFromCalendarStore(reqMonth: displayedMonth, reqYear: displayedYear, calendarFilterID: userCalendarListID)
        //END
        
        resetTimer()
        //END
        let nib1 = UINib.init(nibName: "BirthdayTableViewCell", bundle: nil)
        self.birthdayCalendarTableView!.register(nib1, forCellReuseIdentifier: "BirthdayTableViewCell")
        
        let nib2 = UINib.init(nibName: "MaxBirthdayTableViewCell", bundle: nil)
        self.maxBirthdayCalendarTableView!.register(nib2, forCellReuseIdentifier: "MaxBirthdayTableViewCell")
        
        
        //BEGIN - place the old To do text in the field, so after crash it is still loaded
        toDoTextField!.text = toDoTextString
        shoppingListTextField!.text = shoppingListTextString
        
        //END
        
        //BEGIN - Update the screen theme, so when program start again the correct Color theme is loaded
        switch (screenTheme) {
        case 0:
            setStyle(daytime: true)
            print ("Light Theme")
        case 1:
            setStyle(daytime: false)
            print ("Dark Theme")
        case 2:
            print ("Auto Theme")
        default:
            print ("ERROR - I received an unkown tag number for theme")
            break
        }
        //END
        
        updateHomeScreen()
        
        //BEGIN - This timer checks for the time and adjust brightness and mode if required
        if screenBrightnessTimer == nil {
        screenBrightnessTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.updateScreenBrightness), userInfo: nil, repeats: true)
        }
        //END
    
        //BEGIN - Start the 1 sec Timer, for updating time for alarm purposes
        if alarmTimer == nil {
            alarmTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.alarmUpdate), userInfo: nil, repeats: true)
        }
        //END
        
        
        //END
        
        //let monthArray = getEventsFromCalendarStore(reqMonth: 5, reqYear: 2022, calendarFilterID: userCalendarListID)
        //print (monthArray.allDay)
    }
    
    
    
    
    
    
    
    //BEGIN - present the calendar Focus view controller
    @IBAction func calendarEdit()
    {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in calendar edit
    }
    //END
    //BEGIN - present the calendar Focus view controller
    @IBAction func searchRequested()
    {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in calendar edit
    }
    //END
    
    
    
    //BEGIN - present the calendar Focus view controller
    @IBAction func favouritesButtonPressed()
    {
        print ("No Screensaver")
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in calendar edit
    }
    //END
    
    @objc func willEnterForeground()
    {
        //BEGIN - Check for Authorization in case app comes from background to foreground
        print ("I did ENTER Forefround")
        eventAccessApproved = EventStoreAuthorizationsApproved()
        photoAccessApproved = PhotoAuthorizationsApproved()
        
        popupRequestIfEventOrPhotoStoreIsDisabled()
        updateHomeScreen()
     }
    
    
    @objc func keyboardWillAppear() {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false // prevent the screen saver to start else it could start when keyboard is up
        print ("Screen Saver not allowed")
        print ("Keyboard is up")
    }
    
    //BEGIN - this is getting called when removing the keyboard
    @objc func keyboardWillDisappear() {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = true // enable the screen saver
     print ("Keyboard is removed")
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    
    override func viewWillAppear(_ animated: Bool){
        print ("MAIN View will appear, Main Loop - Screen saver allowed")
        
        
        screenSaverAllowed = true
        screenSaverCounter = 0 //reset the slide show counter, else it might start straight away after you return from a viewcontroller
        //updateScreenBrightness()
        timeUpdate()
        DispatchQueue.main.async {self.updateDayView()}
        
        updateUpcomingEventsArray()
        self.birthdayCalendarTableView.reloadData()
        self.maxBirthdayCalendarTableView.reloadData()
        
        updateHomeScreen()
        //if fetchedYearCalendar == true { monthCalendarBtn!.isHidden = false}
        
        //BEGIN - Start the 1 sec Timer, for updating time
        if clockUpdateTimer == nil {
            //print ("****** TIMER INIT ******")
            clockUpdateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeUpdate), userInfo: nil, repeats: true)
        }
        //END
        
    
 
        //BEGIN - Start the 15 Minute Timer, for updating the day calendar, else it won't update if user has no screensaver selected.
        if calendarTimer == nil {
            calendarTimer = Timer.scheduledTimer(timeInterval: calendarUpdateFrequency, target: self, selector: #selector(self.updateTodayCalendar), userInfo: nil, repeats: true)
        }
        //END
        
        
        //END
        screenSaverCounter = 0 //reset the slide show counter, else it might start straight away after you return from a viewcontroller
        
        
        //BEGIN - setup keyboard and Notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.clearShoppingListNotification(notification:)), name: Notification.Name("ClearShoppingListNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.clearToDoListNotification(notification:)), name: Notification.Name("ClearToDoListNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateShoppingListNotification(notification:)), name: Notification.Name("updateShoppingListNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.screensaverRequested), name: Notification.Name("ScreensaverNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
     }
    
    /*@objc func fetchedFullCalendar(){
        monthCalendarBtn?.isHidden = false
    }*/
    
    @objc func screenModeHasChanged(){
        updateHomeScreen()
        self.updateDayView()
        self.birthdayCalendarTableView.reloadData()
        self.maxBirthdayCalendarTableView.reloadData()
        
    }
    @objc func updateTodayCalendar() {
        print ("-------------------------------------------------- Refresh Today Calendar")
        DispatchQueue.main.async {
            self.updateDayView()
            updateUpcomingEventsArray()
            self.birthdayCalendarTableView.reloadData()
            self.maxBirthdayCalendarTableView.reloadData()
        }
        NotificationCenter.default.post(name: Notification.Name("updatedEventCacheNotification"), object: nil, userInfo: ["key":"value"])
        fetchYearCalendarInBackground()
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
        //END
    
    
    //BEGIN - loads the calendar Array - BUG remove the hardcode text
    
    
    
    
    //END
    @objc func updateShoppingListNotification(notification: Notification){
        print ("update Shopping List")
        shoppingListTextField!.text = shoppingListTextString
    }
    
    
    @objc func clearToDoListNotification(notification: Notification){
        print ("clear To Do List")
        toDoTextField!.text = ""
        toDoTextString = ""
        saveUserDefaults()
    }
    
    
    @objc func clearShoppingListNotification(notification: Notification){
        print ("clear Shopping List")
        shoppingListTextField!.text = ""
        shoppingListTextString = ""
        saveUserDefaults()
    
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print ("TimerExpiredSegue")
        performSegue(withIdentifier: "TimerExpiredSegue", sender: nil)
        //Take Action on Notification
    }
    //END
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("View will disappear, Main Loop")
        //clockUpdateTimer?.invalidate()
        //calendarTimer?.invalidate()
        //calendarTimer = nil
        
        
        
        transientPopup.isHidden = true  //park the transient popup
        print ("Stop Alarm notification")
        NotificationCenter.default.removeObserver(self) //Remove All notifications
    }
    
    //BEGIN - User pressed the remove keyboard key so store both strings, as you don't know if user swapped between text views
    func textViewDidEndEditing(_ textView: UITextView) {
        print ("Text view did end edit")
        screenSaverCounter = 0 //Reset the screen saver counter
        toDoTextString = toDoTextField!.text
        shoppingListTextString = shoppingListTextField!.text
        //BEGIN - testing only if user enter passkey
        if shoppingListTextString == "Beek Limburg Rocks!" {
            inAppPurchased = true
            updateHomeScreen()
        }
        //END
        saveUserDefaults()
    }
    //END
    
    //BEGIN - Timer Functions
    @objc func timeUpdate() {
        //print ("Tick Tock")
        
        if (screenSaverAllowed == true) && (screenSaverUserEnabled == true) && (screenSaverActive == false){
            screenSaverCounter = screenSaverCounter + 1
            //print ("--screen saver timer running: \(screenSaverCounter)")
            if (screenSaverCounter == screenSaverDelayBeforeStart) {
                screenSaverAllowed = false
                screenSaverCounter = 0 //Reset the screen saver counter
                activateTimedScreenSaver()
            }
         }
        
        if (screenSaverAllowed == false) {
            //print("-- Screen saver not Allowed")
            screenSaverCounter = 0 //reset the slide show counter, else it might start straight away after you return from a viewcontroller
        }
        
        //BEGIN - update the Clock and Date
        let dateFormatter1 = DateFormatter()
        let dateFormatter2 = DateFormatter()
        dateFormatter1.dateFormat = "h:mm"
        
        //dateFormatter2.dateFormat = "d  MMM"
        dateFormatter2.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMMM", options: 0, locale: Locale.current)
        clockLabel!.text = dateFormatter1.string(from: Date() as Date)
        //dateLabel!.text  = dateFormatter2.string(from: Date() as Date)
        //dateLabel!.text  = ""
        
        //BEGIN - Check if the day ticked over to the next day
        currentDay = Calendar.current.component(.day, from: Date())
        if currentDay != oldDay
        {
            //It is midnight and the day just ticked over to the next day
            //BEGIN - Send a notification the Screen brightness and mode have changed, so all screen and dates update
            print ("--------- It changed to midnight")
            print (Date())
            NotificationCenter.default.post(name: Notification.Name("ScreenModeNotification"), object: nil, userInfo: ["key":"value"])
            //END
        }
        oldDay = currentDay
        //END
        updateTimerButton(ButtonState: timerState)
        
        //updateTimer()
        //END
     }
    
    //BEGIN - Alarm Timer Functions
    @objc func alarmUpdate() {
        //BEGIN - Decrease the timer with 1 second if the timer is running
        //print (".")
        if (timerRunning == true) {
            print ("Alarm timer running: \(timerSeconds)")
            //screenSaverAllowed = false //No Screen saver allowed
            timerSeconds = timerSeconds - 1
            
        }
        //END
        if timerSeconds < 0 { timerSeconds = 0}
        //BEGIN - Timer Expired
        if (timerSeconds == 0) && (timerRunning == true) {
            print ("Kitchen Timer Expired, sound Alarm")
            timerExpired = true
            timerRunning = false // stop the kitchen timer
            timerState = .Reset
            print ("Sending notiifvations")
            //BEGIN - Send a notification the Alarmn went OFF
            NotificationCenter.default.post(name: Notification.Name("AlarmNotification"), object: nil, userInfo: ["key":"value"])
            //END
        }
        //END
        
    }

    @objc func updateScreenBrightness() {
        //BEGIN - Set the screen brightness and Mode change
        print ("checking")
        let partOfTheDay = checkPartOfTheDay()
        
        if oldPartOfTheDay != partOfTheDay { //Only run this if the value has changed, to prevent constant updating
            switch (partOfTheDay){
            case 0:
                oldPartOfTheDay = partOfTheDay
                print ("Day Brigthness")
                UIScreen.main.brightness = CGFloat(screenDayTimeBrightness)
                
                if (screenTheme == 2) {
                    setStyle(daytime: true)//set to day mode
                }
            case 1:
                print ("Night Brigthness")
                oldPartOfTheDay = partOfTheDay
                UIScreen.main.brightness = CGFloat(screenNightTimeBrightness)
                
                if (screenTheme == 2) {
                    setStyle(daytime: false)//set to night mode
                }
            case 2:
                print ("Sleep Brigthness")
                oldPartOfTheDay = partOfTheDay
                UIScreen.main.brightness = CGFloat(screenSleepTimeBrightness)
                //if (partOfTheDay != 0) && (dayMode){
                //print ("Set Sleep Mode -------")
                if (screenTheme == 2) {
                    setStyle(daytime: false)//set to night mode
                }
            default:
                print("I fell through the screen brighness switch")
            }
            
            //BEGIN - Send a notification the Screen brightness and mode have changed
            NotificationCenter.default.post(name: Notification.Name("ScreenModeNotification"), object: nil, userInfo: ["key":"value"])
            //END
            
        }
    }
    //BEGIN this function checks if the current time is within the daytime range set by user, used to change the Color day/night Theme
    func currentTimeIsWithinDaytime(beginHour: Int, beginMinute: Int, endHour: Int, endMinute:Int) -> (Bool) {
        let calendar = Calendar.current
        let now = Date()
        
        let partOfDay1 = calendar.date(
            bySettingHour: beginHour,
            minute: beginMinute,
            second: 0,
            of: now)!
        
        let partOfDay2 = calendar.date(
            bySettingHour: endHour,
            minute: endMinute,
            second: 0,
            of: now)!
        
        
        if ((now >= partOfDay1) && (now <= partOfDay2))
        {
            //print ("Day Time")
            return true
        }
        else {
            //print ("Night Time")
            return false
        }
        //END
    }
    
    

    //BEGIN - Show the Timer Expired Screen
    @IBAction func activateTimerExpiredScreen(){
        performSegue(withIdentifier: "TimerExpiredSegue", sender: nil)
    }
    //END
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print ("I am scrolling so do not start screen saver,  I am doing stuff")
        
        screenSaverCounter = 0 //Reset the screen saver counter
    }
    
    
    
    //BEGIN - Show screen Saver
    @IBAction func activateTimedScreenSaver(){
        //BEGIN - Send a screen saver activation request Notification
        NotificationCenter.default.post(name: Notification.Name("ScreensaverNotification"), object: nil, userInfo: ["key":"value"])
        //END
        /*
        if (userSelectedPhotoAlbum=="") {
            performSegue(withIdentifier: "NoPhotoAlbumSegue", sender: nil)
        }
        else {
            performSegue(withIdentifier: "ScreenSaverSegue", sender: nil)
        }*/
    }
    //END
    
    @IBAction func add10Seconds(){
        
        screenSaverCounter = 0 //Reset the screen saver counter
        timerSeconds += 10
        
        updateTimerButton(ButtonState: .Pause)
    }
    
    @IBAction func resetTimer(){
        screenSaverCounter = 0 //Reset the screen saver counter
        updateTimerButton(ButtonState: .Reset)
        
    }

    @IBAction func addMinutes(){
        screenSaverCounter = 0 //Reset the screen saver counter
        timerSeconds += 60
        
        updateTimerButton(ButtonState: .Pause)
    }
    
    @IBAction func add10Minutes(){
        screenSaverCounter = 0 //Reset the screen saver counter
        timerSeconds += 600
        
        updateTimerButton(ButtonState: .Pause)
    }
    
    

    @IBAction func startMyTimer(){
        screenSaverCounter = 0 //Reset the screen saver counter
        if (timerSeconds != 0) {
            switch (timerState){
            case .Pause:
                updateTimerButton(ButtonState: .Start)
            case .Start:
                updateTimerButton(ButtonState: .Pause)
            case .Reset:
                print ("Do nothing Reset")
            }
        }
    }
    
    
    func updateTimerButton(ButtonState: TimerButtonStates){
        //oldTimerState = timerState
        switch (ButtonState){
        
        case .Start:
            //print ("Timer State: Start")
            timerState = .Start
            screenSaverAllowed = true
            timerRunning = true
            timerExpired = false
            
            //screenSaverBtn?.isEnabled = false //do not allow user to activate photo slide show.
            var image = UIImage(named: "StopBtnDay") as UIImage?
            var imagePressed = UIImage(named: "StopPressedBtnDay") as UIImage?
            if (dayMode) {
                startTimerBtn?.setImage(image, for: .normal)
                startTimerBtn?.setImage(imagePressed, for: .highlighted)
            }
            else {
                image = UIImage(named: "StopBtnNight") as UIImage?
                imagePressed = UIImage(named: "StopPressedBtnNight") as UIImage?
                startTimerBtn?.setImage(image, for: .normal)
                startTimerBtn?.setImage(imagePressed, for: .highlighted)
            }
            minutesBtn?.isHidden = true
            minutes10Btn?.isHidden = true
            seconds10Btn?.isHidden = true
            smallKitchenTimerLbl?.isHidden = true
            kitchenTimerLbl?.isHidden = false
            kitchenTimerLbl!.text = timeString(time: timerSeconds)
        
        case .Pause:
            print ("Timer State: Pause")
            timerState = .Pause
            //screenSaverBtn?.isEnabled = true //do allow user to activate photo slide show.
            timerExpired = false
            timerRunning = false
            
            smallKitchenTimerLbl?.isHidden = false
            smallKitchenTimerLbl!.alpha = 1.0
            smallKitchenTimerLbl?.text = timeString(time: timerSeconds)
            minutesBtn?.isHidden = false
            minutes10Btn?.isHidden = false
            seconds10Btn?.isHidden = false
            kitchenTimerLbl?.isHidden = true
            startTimerBtn?.setImage(startBtnImage, for: .normal)
            startTimerBtn?.setImage(startPressedBtnImage, for: .highlighted)
        case .Reset:
            print ("Timer State: Reset")
            
            startTimerBtn?.setImage(startBtnImage, for: .normal)
            startTimerBtn?.setImage(startPressedBtnImage, for: .highlighted)
            timerState = .Reset
            timerExpired = false
            timerRunning = false
            
            timerSeconds = 0
            smallKitchenTimerLbl!.alpha = 1.0
            smallKitchenTimerLbl?.text = timeString(time: timerSeconds)
            //BEGIN - enable timer buttons
            minutesBtn?.isHidden = false
            minutes10Btn?.isHidden = false
            seconds10Btn?.isHidden = false
            smallKitchenTimerLbl?.isHidden = false
            kitchenTimerLbl?.isHidden = true
            //END
        }
    }
    
    
    
    @IBAction func shareButtonActionShoppingList(_ sender: AnyObject) {
        screenSaverCounter = 0 //Reset the screen saver counter
        let activityVC = UIActivityViewController(activityItems: [shoppingListTextField!.text!], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = shoppingListView
        activityVC.popoverPresentationController?.sourceRect = shoppingListView!.bounds
        
        present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            
            if completed  {
                //self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    @IBAction func shareButtonActionToDoList(_ sender: AnyObject) {
        screenSaverCounter = 0 //Reset the screen saver counter
        let activityVC = UIActivityViewController(activityItems: [toDoTextField!.text!], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = toDoView
        activityVC.popoverPresentationController?.sourceRect = toDoView!.bounds
        present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            
            if completed  {
                //self.dismiss(animated: true, completion: nil)
            }
        }
    }

   
    
    
    func popupRequest(text: String) {
        transientPopup.isHidden = false
        transientPopup.alpha = 0
        transientTextLbl?.text = NSLocalizedString(text, comment: "")
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseOut],
                       animations: { [self] in
                       transientPopup.alpha = 1
        },
                       completion: { finished in
                       UIView.animate(withDuration: 0.5,
                                       delay: 4.0,
                                       options: [.curveEaseIn],
                                       animations: { [self] in
                                        transientPopup.alpha = 0
                                       },
                                       completion: { finished in
                                       self.transientPopup.isHidden = true
                                       })
                        
        })
    }
    
    
    
    //BEGIN - Ask for permission to access calender
    func EventStoreAuthorizationsApproved() -> (Bool) {
        
        var accessAproved: Bool = false
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case .notDetermined:
            print ("Not Determinded")
            eventStore.requestAccess(to: .event, completion: { (granted: Bool, NSError) -> Void in
                if granted {
                    accessAproved = true
                    //authorizationEventAccessUpdate = true //update the the main loop so the feature gets enabled
                    print("Access OK")
                    
                }else{
                    print("Access denied")
                }
            })
        case .authorized:
            accessAproved = true
            print ("Acces Granted for Calendar acces")
        case .denied:
            print("Access denied")
        default:
            print("Case Default")
        }
        return accessAproved
    }
    
    //BEGIN - check if a event or photo access popup needs to be displayed
    func popupRequestIfEventOrPhotoStoreIsDisabled() {
        transientPopup.isHidden = true
        let eventAcces = eventStoreDenied()
        let photoAcces = photoStoreDenied()
        
        if (eventAcces == true) && (photoAcces == true) {
            popupRequest(text: "Calendar & Photo Access Disabled, please enable in iPad Settings")
        }
        
        if (eventAcces == true) && (photoAcces == false) {
            popupRequest(text: "Calendar Access Disabled, please enable in iPad Settings")
        }
        
        if (eventAcces == false) && (photoAcces == true) {
            popupRequest(text: "Photo Access Disabled, please enable in iPad Settings")
        }
    }
    
    
    
    //BEGIN - Check if user denied access to event store
    func eventStoreDenied() -> (Bool) {
        var accessDenied: Bool = false
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case .notDetermined:
            accessDenied = false
        case .authorized:
            accessDenied = false
        case .denied:
            accessDenied = true
        default:
            print("Case Default")
        }
        return accessDenied
    }
    
    //BEGIN - Check if user denied access to photo store
    func photoStoreDenied() -> (Bool) {
        var accessDenied: Bool = false
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch (status) {
        case .notDetermined:
            accessDenied = false
        case .authorized:
            accessDenied = false
        case .denied:
            accessDenied = true
        default:
            print("Case Default")
        }
        return accessDenied
    }
    //END
    
    
    //BEGIN - Ask for permission to access photos
    func  PhotoAuthorizationsApproved() -> (Bool) {
        
        var accessAproved: Bool = false
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            accessAproved = true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization() { status in
                if status == .authorized {
                    DispatchQueue.main.async {
                        accessAproved = true
                        //authorizationPhotoAccessUpdate = true //update the the main loop so the feature gets enabled
                    }
                }
            }
        case .restricted:
            // do nothing
            break
        case .denied:
            //denied
            break
        default:
            accessAproved = false
        }
        return accessAproved
    }
    //END

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = buttonPressedColor
        eventStartDate = upcomingEventCache.startDateOfEvent[indexPath.row]
        screenSaverCounter = 0 //reset the timer.
        performSegue(withIdentifier: "CalendarEditSegueID", sender: nil)
    }
   
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rowsInSection: Int = 0
        
        switch tableView {
        case self.birthdayCalendarTableView:
            rowsInSection = upcomingEventCache.name.count
        case self.maxBirthdayCalendarTableView:
            rowsInSection = upcomingEventCache.name.count
        default:
            rowsInSection = 0
        }
        return rowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell: UITableViewCell?
        switch tableView {
        case self.birthdayCalendarTableView:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "BirthdayTableViewCell", for: indexPath) as! BirthdayTableViewCell
            
            cell1.birthdayNameLbl.text = upcomingEventCache.name[indexPath.row]
            cell1.birthdayDateLbl.text = upcomingEventCache.eventDate[indexPath.row]
            cell1.birthdayDaysLbl.text = upcomingEventCache.daysTillEvent[indexPath.row]
            cell1.eventColourIV.image = UIImage(named: "CellIDLargeImg")?.withRenderingMode(.alwaysTemplate)
            cell1.eventColourIV.tintColor = UIColor.init(cgColor: upcomingEventCache.calendarColour[indexPath.row])
            cell1.eventColourIV.contentMode = .center
            cell1.selectionStyle = .none //do not show a selection color
            if upcomingEventCache.eventIsToday[indexPath.row] {
                cell1.birthdayDateLbl.textColor = subTextColor
                cell1.birthdayNameLbl.textColor = attentionTextColor
                cell1.birthdayDaysLbl.textColor = attentionTextColor
            }
            else {
                cell1.birthdayDateLbl.textColor = subTextColor
                cell1.birthdayNameLbl.textColor = mainTextColor
                cell1.birthdayDaysLbl.textColor = subTextColor
            }
            
            cell1.backgroundColor = .clear
            cell1.contentView.backgroundColor = .clear
            
            return cell1
            
        case self.maxBirthdayCalendarTableView:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "MaxBirthdayTableViewCell", for: indexPath) as! MaxBirthdayTableViewCell
            cell1.birthdayNameLbl.text = upcomingEventCache.name[indexPath.row]
            cell1.birthdayDateLbl.text = upcomingEventCache.eventDate[indexPath.row]
            cell1.birthdayDaysLbl.text = upcomingEventCache.daysTillEvent[indexPath.row]
            
            cell1.eventColourIV.image = UIImage(named: "CellIDLargeImg")?.withRenderingMode(.alwaysTemplate)
            cell1.eventColourIV.tintColor = UIColor.init(cgColor: upcomingEventCache.calendarColour[indexPath.row])
            cell1.eventColourIV.contentMode = .center
            cell1.selectionStyle = .none //do not show a selection color
            
            if upcomingEventCache.eventIsToday[indexPath.row] {
                cell1.birthdayDateLbl.textColor = subTextColor
                cell1.birthdayNameLbl.textColor = attentionTextColor
                cell1.birthdayDaysLbl.textColor = attentionTextColor
            }
            else {
                cell1.birthdayDateLbl.textColor = subTextColor
                cell1.birthdayNameLbl.textColor = mainTextColor
                cell1.birthdayDaysLbl.textColor = subTextColor
            }
            
            cell1.backgroundColor = .clear
            cell1.contentView.backgroundColor = .clear
            
            return cell1
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MaxBirthdayTableViewCell", for: indexPath) as! MaxBirthdayTableViewCell
            return cell
        }
    }

    @objc func updateHomeScreen(){
        if (inAppPurchased) {inAppBtn.isHidden = true}
        else{inAppBtn.isHidden = false}
        //NEW
        //DispatchQueue.main.async {self.updateDayView()}
        scrollViewDidEndDecelerating(todayCalendarScrollView)
        updateTimerButton(ButtonState: timerState)
        
        inAppBtn!.layer.shadowColor = UIColor.black.cgColor
        inAppBtn!.layer.shadowOpacity = shadowOpacityButtons
        inAppBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        inAppBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        inAppBtn?.setImage(lockImage, for: .normal)
        inAppBtn?.setImage(lockPressedImage, for: .highlighted)
        
        noteBtn!.layer.shadowColor = UIColor.black.cgColor
        noteBtn!.layer.shadowOpacity = shadowOpacityButtons
        noteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        noteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        noteBtn?.setImage(noteBtnImage, for: .normal)
        noteBtn?.setImage(noteBtnPressedImage, for: .highlighted)
        
        
        reminderBtn!.layer.shadowColor = UIColor.black.cgColor
        reminderBtn!.layer.shadowOpacity = shadowOpacityButtons
        reminderBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        reminderBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        reminderBtn?.setImage(reminderImage, for: .normal)
        reminderBtn?.setImage(reminderPressedImage, for: .highlighted)
        
        //BEGIN - Update transient Message look
        transientPopup!.layer.shadowColor = UIColor.black.cgColor
        transientPopup!.layer.shadowOpacity = shadowOpacityView
        transientPopup!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        transientPopup!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        transientPopup?.backgroundColor    = .orange
        transientPopup?.layer.cornerRadius = cornerRadiusWindow
        transientPopup?.layer.borderWidth  = 1
        transientPopup?.layer.borderColor  = UIColor.white.cgColor
        transientTextLbl?.textColor = .white
        //END
        
        //BEGIN - Init the buttons on the screen
        resetTimerBtn?.setImage(resetBtnImage, for: .normal)
        resetTimerBtn?.setImage(resetPressedBtnImage, for: .highlighted)
        resetTimerBtn!.layer.shadowColor = UIColor.black.cgColor
        resetTimerBtn!.layer.shadowOpacity = shadowOpacityButtons
        resetTimerBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        resetTimerBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        timerBtn?.setImage(timerImage, for: .normal)
        timerBtn?.setImage(timerPressedImage, for: .highlighted)
        //timerBtn!.layer.shadowColor = UIColor.black.cgColor
        //timerBtn!.layer.shadowOpacity = shadowOpacityButtons
        //timerBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        //timerBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        startTimerBtn!.layer.shadowColor = UIColor.black.cgColor
        startTimerBtn!.layer.shadowOpacity = shadowOpacityButtons
        startTimerBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        startTimerBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        favouritesBtn?.setImage(favouritesImage, for: .normal)
        favouritesBtn?.setImage(favouritesPressedImage, for: .highlighted)
        favouritesBtn!.layer.shadowColor = UIColor.black.cgColor
        favouritesBtn!.layer.shadowOpacity = shadowOpacityButtons
        favouritesBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        favouritesBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        screenSaverBtn?.setImage(photoSlideShowImage, for: .normal)
        screenSaverBtn?.setImage(photoSlideShowPressedImage, for: .highlighted)
        screenSaverBtn!.layer.shadowColor = UIColor.black.cgColor
        screenSaverBtn!.layer.shadowOpacity = shadowOpacityButtons
        screenSaverBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        screenSaverBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        screenSaverBtn!.isHidden = false //Always show the screen saver button
        
        settingBtn?.setImage(settingsImage, for: .normal)
        settingBtn?.setImage(settingsPressedImage, for: .highlighted)
        settingBtn!.layer.shadowColor = UIColor.black.cgColor
        settingBtn!.layer.shadowOpacity = shadowOpacityButtons
        settingBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        settingBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        searchBtn?.setImage(searchCalendarImage, for: .normal)
        searchBtn?.setImage(searchCalendarPressedImage, for: .highlighted)
        searchBtn!.layer.shadowColor = UIColor.black.cgColor
        searchBtn!.layer.shadowOpacity = shadowOpacityButtons
        searchBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        searchBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        calendarFocusBtn?.setImage(weekViewBtnImage, for: .normal)
        calendarFocusBtn?.setImage(weekViewPressedBtnImage, for: .highlighted)
        calendarFocusBtn!.layer.shadowColor = UIColor.black.cgColor
        calendarFocusBtn!.layer.shadowOpacity = shadowOpacityButtons
        calendarFocusBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        calendarFocusBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        upcommingEventBtn?.setImage(upcommingEventImg, for: .normal)
        upcommingEventBtn?.setImage(upcommingEventPressedImg, for: .highlighted)
        upcommingEventBtn!.layer.shadowColor = UIColor.black.cgColor
        upcommingEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        upcommingEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upcommingEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        weekOutlookBtn?.setImage(weekOutlookImage, for: .normal)
        weekOutlookBtn?.setImage(weekOutlookPressedImage, for: .highlighted)
        weekOutlookBtn!.layer.shadowColor = UIColor.black.cgColor
        weekOutlookBtn!.layer.shadowOpacity = shadowOpacityButtons
        weekOutlookBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        weekOutlookBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        monthCalendarBtn?.setImage(monthViewBtnImage, for: .normal)
        monthCalendarBtn?.setImage(monthViewPressedBtnImage, for: .highlighted)
        monthCalendarBtn!.layer.shadowColor = UIColor.black.cgColor
        monthCalendarBtn!.layer.shadowOpacity = shadowOpacityButtons
        monthCalendarBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        monthCalendarBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        calendarEditBtn?.setImage(EditCalendarBtnImage, for: .normal)
        calendarEditBtn?.setImage(EditCalendarPressedBtnImage, for: .highlighted)
        calendarEditBtn!.layer.shadowColor = UIColor.black.cgColor
        calendarEditBtn!.layer.shadowOpacity = shadowOpacityButtons
        calendarEditBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        calendarEditBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        toDoListDeleteBtn?.setImage(deleteImage, for: .normal)
        toDoListDeleteBtn?.setImage(deletePressedImage, for: .highlighted)
        toDoListDeleteBtn!.layer.shadowColor = UIColor.black.cgColor
        toDoListDeleteBtn!.layer.shadowOpacity = shadowOpacityButtons
        toDoListDeleteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        toDoListDeleteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        shoppingListDeleteBtn?.setImage(deleteImage, for: .normal)
        shoppingListDeleteBtn?.setImage(deletePressedImage, for: .highlighted)
        shoppingListDeleteBtn!.layer.shadowColor = UIColor.black.cgColor
        shoppingListDeleteBtn!.layer.shadowOpacity = shadowOpacityButtons
        shoppingListDeleteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        shoppingListDeleteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        minutes10Btn?.setImage(minutes10BtnImage, for: .normal)
        minutes10Btn?.setImage(minutes10PressedBtnImage, for: .highlighted)
        minutes10Btn!.layer.shadowColor = UIColor.black.cgColor
        minutes10Btn!.layer.shadowOpacity = shadowOpacityButtons
        minutes10Btn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        minutes10Btn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        minutesBtn?.setImage(minute1BtnImage, for: .normal)
        minutesBtn?.setImage(minute1PressedBtnImage, for: .highlighted)
        minutesBtn!.layer.shadowColor = UIColor.black.cgColor
        minutesBtn!.layer.shadowOpacity = shadowOpacityButtons
        minutesBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        minutesBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        seconds10Btn?.setImage(seconds10BtnImage, for: .normal)
        seconds10Btn?.setImage(seconds10PressedBtnImage, for: .highlighted)
        seconds10Btn!.layer.shadowColor = UIColor.black.cgColor
        seconds10Btn!.layer.shadowOpacity = shadowOpacityButtons
        seconds10Btn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        seconds10Btn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        shareToDoBtn?.setImage(shareBtnImage, for: .normal)
        shareToDoBtn?.setImage(shareBtnPressedImage, for: .highlighted)

        shareToDoBtn!.layer.shadowColor = UIColor.black.cgColor
        shareToDoBtn!.layer.shadowOpacity = shadowOpacityButtons
        shareToDoBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        shareToDoBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        shareShoppingListBtn?.setImage(shareBtnImage, for: .normal)
        shareShoppingListBtn?.setImage(shareBtnPressedImage, for: .highlighted)
        shareShoppingListBtn!.layer.shadowColor = UIColor.black.cgColor
        shareShoppingListBtn!.layer.shadowOpacity = shadowOpacityButtons
        shareShoppingListBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        shareShoppingListBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        //END
        
        //BEGIN - Update all the header title boxes
        topHeaderShoppingListView?.image = headerTitleImage
        
        topHeaderToDoView?.image = headerTitleImage
        topHeaderTodayEventView?.image = headerTitleImage
        topHeaderTimerView?.image = headerTitleImage
        topHeaderBirthdayView?.image = headerTitleImage
        maxTopHeaderBirthdayView?.image = headerTitleImage
        
        //NEW Shadow on all uiviews
        shoppingListView!.layer.shadowColor = UIColor.black.cgColor
        shoppingListView!.layer.shadowOpacity = shadowOpacityView
        shoppingListView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        shoppingListView!.layer.shadowRadius = CGFloat(shadowRadiusView)
       
        maxBirthdayCalendarView!.layer.shadowColor = UIColor.black.cgColor
        maxBirthdayCalendarView!.layer.shadowOpacity = shadowOpacityView
        maxBirthdayCalendarView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        maxBirthdayCalendarView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        maxBirthdayCalendarTableView.separatorColor = tableSeperatorColor
        
        birthdayCalendarView!.layer.shadowColor = UIColor.black.cgColor
        birthdayCalendarView!.layer.shadowOpacity = shadowOpacityView
        birthdayCalendarView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        birthdayCalendarView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        birthdayCalendarTableView.separatorColor = tableSeperatorColor
        
        timerView!.layer.shadowColor = UIColor.black.cgColor
        timerView!.layer.shadowOpacity = shadowOpacityView
        timerView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        timerView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        toDoView!.layer.shadowColor = UIColor.black.cgColor
        toDoView!.layer.shadowOpacity = shadowOpacityView
        toDoView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        toDoView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        todayCalendarView!.layer.shadowColor = UIColor.black.cgColor
        todayCalendarView!.layer.shadowOpacity = shadowOpacityView
        todayCalendarView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        todayCalendarView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        //END
        
        backgroundView?.image = backgroundImage
        topHeaderView?.image = topHeaderImage
        
        maxBirthdayCalendarView?.backgroundColor    = windowColor
        maxBirthdayCalendarView?.layer.cornerRadius = cornerRadiusWindow
        maxBirthdayCalendarView?.layer.borderWidth  = borderWidthWindow
        maxBirthdayCalendarView?.layer.borderColor  = borderColor.cgColor
        
        birthdayCalendarView?.backgroundColor    = windowColor
        birthdayCalendarView?.layer.cornerRadius = cornerRadiusWindow
        birthdayCalendarView?.layer.borderWidth  = borderWidthWindow
        birthdayCalendarView?.layer.borderColor  = borderColor.cgColor
        
        todayCalendarView?.backgroundColor    = windowColor
        todayCalendarView?.layer.cornerRadius = cornerRadiusWindow
        todayCalendarView?.layer.borderWidth  = borderWidthWindow
        todayCalendarView?.layer.borderColor  = borderColor.cgColor
        //yesterdayBtn.setImage(backImage, for: .normal)
        //nextDayBtn.setImage(forwardImage, for: .normal)
        
        timerView?.backgroundColor    = windowColor
        timerView?.layer.cornerRadius = cornerRadiusWindow
        timerView?.layer.borderWidth  = borderWidthWindow
        timerView?.layer.borderColor  = borderColor.cgColor
        kitchenTimerLbl?.textColor    = mainTextColor
        kitchenTimerLbl?.font = UIFont.monospacedDigitSystemFont(ofSize: 85.0, weight: UIFont.Weight.regular)
        smallKitchenTimerLbl?.textColor       = mainTextColor
        smallKitchenTimerLbl?.font = UIFont.monospacedDigitSystemFont(ofSize: 60.0, weight: UIFont.Weight.regular)
        toDoView?.backgroundColor    = windowColor
        toDoView?.layer.cornerRadius = cornerRadiusWindow
        toDoView?.layer.borderWidth  = borderWidthWindow
        toDoView?.layer.borderColor  = borderColor.cgColor
        toDoTextField?.backgroundColor = .clear
        toDoTextField?.textColor       = mainTextColor
        
        if (dayMode == true){
            shoppingListTextField!.keyboardAppearance = UIKeyboardAppearance.light
            toDoTextField!.keyboardAppearance = UIKeyboardAppearance.light
        }
        else {
            shoppingListTextField!.keyboardAppearance = UIKeyboardAppearance.dark
            toDoTextField!.keyboardAppearance = UIKeyboardAppearance.dark
        }
        shoppingListView?.backgroundColor    = windowColor
        shoppingListView?.layer.cornerRadius = cornerRadiusWindow
        shoppingListView?.layer.borderWidth  = borderWidthWindow
        shoppingListView?.layer.borderColor  = borderColor.cgColor
        shoppingListTextField?.backgroundColor = .clear
        shoppingListTextField?.textColor       = mainTextColor
        shoppingListWindowLbl?.textColor = textTitleColor
        shoppingListWindowLbl?.text = NSLocalizedString("Shopping List", comment: "")
        shoppingListDeleteBtn?.setImage(deleteImage, for: .normal)
        shoppingListDeleteBtn?.setImage(deletePressedImage, for: .highlighted)
        
        clockLabel?.textColor = mainTextColor
        //dateLabel?.textColor = mainTextColor
        todoWindowLbl?.textColor = textTitleColor
        todoWindowLbl?.text = NSLocalizedString("To Do List", comment: "")
        maxBirthdayWindowLbl?.textColor = textTitleColor
        maxBirthdayWindowLbl.text = NSLocalizedString("Upcoming Events", comment: "")
        
        birthdayWindowLbl?.textColor = textTitleColor
        birthdayWindowLbl.text = NSLocalizedString("Upcoming Events", comment: "")
        todayWindowLbl?.textColor = textTitleColor
    
        
        timerWindowLbl?.textColor = textTitleColor
        timerWindowLbl?.text = NSLocalizedString("Timer", comment: "")
        //todayCalendarTableView.backgroundColor = .clear
        
        
        //BEGIN - Reset the requested date in today calender screen
        eventStartDate = Date() //reset the today calendar to today, maybe user has changed it
        selectedDate = eventStartDate
        //END
        
       
        
        addTodayCalendarBtn?.setImage(addBtnImage, for: .normal)
        addTodayCalendarBtn?.setImage(addPressedBtnImage, for: .highlighted)
        addUpcomingCalendarBtn?.setImage(addBtnImage, for: .normal)
        addUpcomingCalendarBtn?.setImage(addPressedBtnImage, for: .highlighted)
        maxAddUpcomingCalendarBtn?.setImage(addBtnImage, for: .normal)
        maxAddUpcomingCalendarBtn?.setImage(addPressedBtnImage, for: .highlighted)
        
        addTodayCalendarBtn?.setTitleColor(attentionTextColor, for: .normal)
        addTodayCalendarBtn?.setTitle((NSLocalizedString("Add Calendar", comment: "")), for: .normal)
            
        addUpcomingCalendarBtn?.setTitleColor( attentionTextColor, for: .normal)
        addUpcomingCalendarBtn?.setTitle((NSLocalizedString("Add Calendar", comment: "")), for: .normal)
        
        maxAddUpcomingCalendarBtn?.setTitleColor( attentionTextColor, for: .normal)
        maxAddUpcomingCalendarBtn?.setTitle((NSLocalizedString("Add Calendar", comment: "")), for: .normal)
        //BEGIN
        let calendarData = readUserCalendarData()
        let numberOfCalendars = calendarData.name.count
        print ("ML number of calendar is: \(numberOfCalendars)")
        //BEGIN - display add buttons for the 'Today' calender and 'Upcoming Event' Calendar in case no calendars are picked inthe beginning
        addTodayCalendarBtn?.isHidden = true
        addUpcomingCalendarBtn?.isHidden = true
        maxAddUpcomingCalendarBtn?.isHidden = true
        
        //Hide the Add Today Calendars if no calendars are selected by user
        
        var noCalendarsSelected:Bool = true
        for x in 0..<numberOfCalendars {
            
            if isTodayCalendarSelectedByUserDefaults (calendarID: calendarData.id[x]) {
                //print ("ML Today Calendars Selelected")
                noCalendarsSelected = false
            }
        }
        if noCalendarsSelected {
            //print ("ML No Today Calendars Selelected")
            addTodayCalendarBtn?.isHidden = false
            birthdayCalendarTableView.separatorColor = .clear //Do not show seperstor lines else the ADD button sits on top of it
            maxBirthdayCalendarTableView.separatorColor = .clear
        }
        
        
        //Hide the Add Birthday Calendars if calendars are selected by user
        noCalendarsSelected = true
        for x in 0..<numberOfCalendars {
            if isCalendarSelectedByUserDefaults (calendarID: calendarData.id[x]) {
                //print ("ML1 Birthday calendat is slelected")
                noCalendarsSelected = false
            }
        }
        if noCalendarsSelected {
            //print ("ML1 No Birthday calendar selected")
            addUpcomingCalendarBtn?.isHidden = false
            maxAddUpcomingCalendarBtn?.isHidden = false
        }
       
        
        
        //Set the current week number and year, so user can select the week view and the correct week is being displayed
        let calendar = Calendar(identifier: .iso8601)
        numOfWeek = calendar.component(.weekOfYear, from: Date())
        selectedYear = Calendar.current.component(.year, from: Date())
        //END
        
        //BEGIN - update the day buttons in the upcoming events window
        day0OverviewPageBtn.setTitle("", for: .normal)
        day1OverviewPageBtn.setTitle("", for: .normal)
        day2OverviewPageBtn.setTitle("", for: .normal)
        day3OverviewPageBtn.setTitle("", for: .normal)
        day4OverviewPageBtn.setTitle("", for: .normal)
        day5OverviewPageBtn.setTitle("", for: .normal)
        day6OverviewPageBtn.setTitle("", for: .normal)
    
        updateTimerBtnState()
    
    }
   
    @IBAction func monthCalendarBtnPressed() {
        //BEGIN - Set todays date when showing the Months View
        eventStartDate = Date()
    }
    
    @IBAction func reminderBtnPressed() {
        print ("Reminder Button Pressed")
        
    }

    
}


