//
//  EventFunctions.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 1/8/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import Foundation
import EventKit
import UIKit
import Photos

var eventAccessApproved:Bool = false

//var authorizationEventAccessUpdate:Bool = false
var eventAddedSucces: Bool = false

extension UIColor
{
    var isDarkColor: Bool {
        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return  lum < 0.50
    }
}

func weekday(day: Date) -> Int?
{
    return (Calendar.current.component(.weekday, from: day))-1 // this returns an Int, 0 = Sunday
}

extension UIColor {
    private func makeColor(componentDelta: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Extract r,g,b,a components from the
        // current UIColor
        getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
        
        // Create a new UIColor modifying each component
        // by componentDelta, making the new UIColor either
        // lighter or darker.
        return UIColor(
            red: add(componentDelta, toComponent: red),
            green: add(componentDelta, toComponent: green),
            blue: add(componentDelta, toComponent: blue),
            alpha: alpha
        )
    }
}

extension UIColor {
    // Add value to component ensuring the result is
    // between 0 and 1
    private func add(_ value: CGFloat, toComponent: CGFloat) -> CGFloat {
        return max(0, min(1, toComponent + value))
    }
}

extension UIColor {
    func lighter(componentDelta: CGFloat = 0.5) -> UIColor {
        return makeColor(componentDelta: componentDelta)
    }
    
    func darker(componentDelta: CGFloat = 0.5) -> UIColor {
        return makeColor(componentDelta: -1*componentDelta)
    }
}

//BEGIN - check what part of the day it is
func checkPartOfTheDay() -> Int {
    // Return 0 = Day
    // Return 1 = Night
    // Return 2 = Sleep
    
    let calendar = Calendar.current
    let now = Date()
    
    let dayMinute = Int(dayTime.truncatingRemainder(dividingBy:60))
    
    let dayStartTime = calendar.date(
        bySettingHour: Int(dayTime/60),
        minute: dayMinute,
        second: 0,
        of: now)!
    
    let nightMinute = Int(nightTime.truncatingRemainder(dividingBy:60))
    let nightStartTime = calendar.date(
        bySettingHour: Int(nightTime/60),
        minute: nightMinute,
        second: 0,
        of: now)!
    
    let sleepMinute = Int(sleepTime.truncatingRemainder(dividingBy:60))
    let sleepStartTime = calendar.date(
        bySettingHour: Int(sleepTime/60),
        minute: sleepMinute,
        second: 0,
        of: now)!
    
    
    var screenReturnValue:Int = 1 //Night
    if (now < dayStartTime) { screenReturnValue = 2} //Sleep
    if (now >= dayStartTime) && (now <= nightStartTime) { screenReturnValue = 0}  //Day
    if (now > nightStartTime) && (now <= sleepStartTime) {screenReturnValue = 1} //Night
    if (now > sleepStartTime) { screenReturnValue = 2} //Sleep
    //print ("the screen has changed to \(screenReturnValue)")
    return screenReturnValue
}




func fetchYearCalendarInBackground (){
    print ("Downloading a fresh year calendar")
    eventAccessApproved = EventStoreAuthorizations() //Check if you are allowed to access, else it won't load the events as it is loaded before view willappear is executed.
    DispatchQueue.global (qos: .userInitiated) .async {
        (month1EventsTitle,month1CalendarColours) = getEventsFromCalendarStore(reqMonth: 1, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 1")
        (month2EventsTitle,month2CalendarColours) = getEventsFromCalendarStore(reqMonth: 2, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 2")
        (month3EventsTitle,month3CalendarColours) = getEventsFromCalendarStore(reqMonth: 3, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 3")
        (month4EventsTitle,month4CalendarColours) = getEventsFromCalendarStore(reqMonth: 4, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 4")
        (month5EventsTitle,month5CalendarColours) = getEventsFromCalendarStore(reqMonth: 5, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 5")
        (month6EventsTitle,month6CalendarColours) = getEventsFromCalendarStore(reqMonth: 6, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 6")
        (month7EventsTitle,month7CalendarColours) = getEventsFromCalendarStore(reqMonth: 7, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 7")
        (month8EventsTitle,month8CalendarColours) = getEventsFromCalendarStore(reqMonth: 8, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 8")
        (month9EventsTitle,month9CalendarColours) = getEventsFromCalendarStore(reqMonth: 9, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 9")
        (month10EventsTitle,month10CalendarColours) = getEventsFromCalendarStore(reqMonth: 10, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 10")
        (month11EventsTitle,month11CalendarColours) = getEventsFromCalendarStore(reqMonth: 11, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 11")
        (month12EventsTitle,month12CalendarColours) = getEventsFromCalendarStore(reqMonth: 12, reqYear: displayedYear, reqCalendars: userDayCalendars)
        print ("Loaded Month 12")
        
        //Next Year
        (month13EventsTitle,month13CalendarColours) = getEventsFromCalendarStore(reqMonth: 1, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 13")
        (month14EventsTitle,month14CalendarColours) = getEventsFromCalendarStore(reqMonth: 2, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 14")
        (month15EventsTitle,month15CalendarColours) = getEventsFromCalendarStore(reqMonth: 3, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 15")
        (month16EventsTitle,month16CalendarColours) = getEventsFromCalendarStore(reqMonth: 4, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 16")
        (month17EventsTitle,month17CalendarColours) = getEventsFromCalendarStore(reqMonth: 5, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 17")
        (month18EventsTitle,month18CalendarColours) = getEventsFromCalendarStore(reqMonth: 6, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 18")
        (month19EventsTitle,month19CalendarColours) = getEventsFromCalendarStore(reqMonth: 7, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 19")
        (month20EventsTitle,month20CalendarColours) = getEventsFromCalendarStore(reqMonth: 8, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 20")
        (month21EventsTitle,month21CalendarColours) = getEventsFromCalendarStore(reqMonth: 9, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 21")
        (month22EventsTitle,month22CalendarColours) = getEventsFromCalendarStore(reqMonth: 10, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 22")
        (month23EventsTitle,month23CalendarColours) = getEventsFromCalendarStore(reqMonth: 11, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 23")
        (month24EventsTitle,month24CalendarColours) = getEventsFromCalendarStore(reqMonth: 12, reqYear: displayedYear+1, reqCalendars: userDayCalendars)
        print ("Loaded Month 24")
        //BEGIN - Tell system use can now push calendar button as it will be unhidden
        //NotificationCenter.default.post(name: Notification.Name("FetchedFullCalendarNotification"), object: nil, userInfo: ["key":"value"])
        //fetchedYearCalendar = true
    }

}

func EventStoreAuthorizations() -> (Bool) {
    var accessAproved: Bool = false
    let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
    
    switch (status) {
    case .notDetermined:
        print ("Not Determinded")
    case .authorized:
        accessAproved = true
        //print ("Acces Granted for Calendar acces")
    case .denied:
        print("Access denied")
    default:
        print("Case Default")
    }
    return accessAproved
}

func updateDurationString (min: Int, hour: Int, day: Int, month: Int, year: Int) -> String {
    var tempString:String = ""
    
    if year == 1  {tempString.append("\(year) \(NSLocalizedString("year", comment: "")) ")}
    if year >  1  {tempString.append("\(year) \(NSLocalizedString("years", comment: "")) ")}
    if month == 1  {tempString.append("\(month) \(NSLocalizedString("month", comment: "")) ")}
    if month >  1  {tempString.append("\(month) \(NSLocalizedString("months", comment: "")) ")}
    if day == 1  {tempString.append("\(day) \(NSLocalizedString("day", comment: "")) ")}
    if day >  1  {tempString.append("\(day) \(NSLocalizedString("days", comment: "")) ")}
    if hour == 1  {tempString.append("\(hour) \(NSLocalizedString("hour", comment: "")) ")}
    if hour >  1  {tempString.append("\(hour) \(NSLocalizedString("hours", comment: "")) ")}
    if min == 1  {tempString.append("\(min) \(NSLocalizedString("minute", comment: "")) ")}
    if min >  1  {tempString.append("\(min) \(NSLocalizedString("minutes", comment: "")) ")}
    
    return tempString
}

func updatePhotoDurationString (day: Int, month: Int, year: Int) -> String {
    var tempString:String = ""
    
    if year == 1  {tempString.append("\(year) \(NSLocalizedString("year", comment: "")) ")}
    if year >  1  {tempString.append("\(year) \(NSLocalizedString("years", comment: "")) ")}
    
    if year != 0 && month != 0 {
        //tempString.append(" ")
        tempString.append("\(NSLocalizedString("and", comment: "")) ")
    }

    if month == 1  {tempString.append("\(month) \(NSLocalizedString("month", comment: "")) ")}
    if month >  1  {tempString.append("\(month) \(NSLocalizedString("months", comment: "")) ")}
    
    if (year != 0 || month != 0) && day != 0{
        //tempString.append(" ")
        tempString.append("\(NSLocalizedString("and", comment: "")) ")
    }
    if day == 1  {tempString.append("\(day) \(NSLocalizedString("day", comment: "")) ")}
    if day >  1  {tempString.append("\(day) \(NSLocalizedString("days", comment: "")) ")}
   
    
    return tempString
}

func updateUpcomingEventsArray () {
    //BEGIN - Create Array with upcoming event, this saves time do this here, than process when table is updated
    upcomingEventCache.name.removeAll()
    upcomingEventCache.eventDate.removeAll()
    upcomingEventCache.daysTillEvent.removeAll()
    upcomingEventCache.eventIsToday.removeAll()
    upcomingEventCache.calendarColour.removeAll()
    upcomingEventCache.startDateOfEvent.removeAll()
    
    let dateFormatter = DateFormatter()
    //dateFormatter.dateFormat = "dd-MMM"
    dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEddMMM", options: 0, locale: Locale.current)
    let calendarEventData = readBirthdayCalendarEvents(requestedCalendars: birthdayCalendars)
    var numberOfUpcomingEvents = calendarEventData.titles.count
    var daysBeforeEvent: Int = 0
    
    
    //BEGIN - Only display a limit number of calendar events
    if (numberOfUpcomingEvents > numberOfBirthdaysShown) {
        numberOfUpcomingEvents = numberOfBirthdaysShown}
    //END
    
    for x in 0..<numberOfUpcomingEvents {
        daysBeforeEvent = daysBetweenDates (endDate: calendarEventData.startDate[x] as Date)
        upcomingEventCache.name.append(calendarEventData.titles[x])
        upcomingEventCache.eventDate.append("\(dateFormatter.string(from: calendarEventData.startDate[x] as Date))")
        upcomingEventCache.calendarColour.append(calendarEventData.calendarColor[x])
        upcomingEventCache.startDateOfEvent.append(calendarEventData.startDate[x] as Date)
        
        if daysBeforeEvent == 0 {
            upcomingEventCache.daysTillEvent.append(NSLocalizedString("Today", comment: ""))
            upcomingEventCache.eventIsToday.append(true)
        }
        
        if daysBeforeEvent == 1 {
            upcomingEventCache.daysTillEvent.append("\(daysBeforeEvent) \(NSLocalizedString("day", comment: ""))")
            upcomingEventCache.eventIsToday.append(false)
        }
        
        if daysBeforeEvent > 1 {
            upcomingEventCache.daysTillEvent.append("\(daysBeforeEvent) \(NSLocalizedString("days", comment: ""))")
            upcomingEventCache.eventIsToday.append(false)
        }
        
        if daysBeforeEvent < 0 {
            upcomingEventCache.daysTillEvent.append("\(NSLocalizedString("started", comment: ""))")
            upcomingEventCache.eventIsToday.append(true)
        }
    }//END
}



func numberOfDaysInMonth (Month: Int,Year: Int) ->(Int)
{
    let numOfDaysInMonth = [31,28,31,30,31,30,31,31,30,31,30,31]
    var numberOfDays = numOfDaysInMonth[Month-1]
    if Month == 2 && Year % 4 == 0 {
        numberOfDays = 29
    }
    return numberOfDays
}



//END



//BEGIN - this functions tells you if the calendar you want for the birthday is selected by the user to be ised or not
func isFamilySelectedByUserDefaults (calendarID: String)-> Bool {
    var temp = false
    for x in familyCalendarsSelected{
        if x == calendarID {
            temp = true
        }
    }
    return temp
}
//END

//BEGIN - this functions tells you if the calendar you want for the birthday is selected by the user to be ised or not
func isCalendarSelectedByUserDefaults (calendarID: String)-> Bool {
    var temp = false
    for x in birthdayCalendarsSelected{
        if x == calendarID {
            temp = true
        }
    }
    return temp
}
//END 

func isTodayCalendarSelectedByUserDefaults (calendarID: String)-> Bool {
    var temp = false
    for x in dayCalendarsSelected{
        if x == calendarID {
            temp = true
        }
    }
    return temp

}
//END 


func timeString(time:Int) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    
    let hoursString = String(hours)
    var minutesString = String(minutes)
    var secondsString = String(seconds)
    
    //if (minutes < 10) && (minutes > 0) { minutesString.insert("0", at: minutesString.startIndex)}
    if (seconds < 10)  { secondsString.insert("0", at: secondsString.startIndex) }
    if (minutes < 10) && (hours != 0) { minutesString.insert("0", at:  minutesString.startIndex)}
    
    
    //return String(format:”%02:%02:%02”, hours, minutes, seconds)
    if hours == 0 {return String("\(minutesString):\(secondsString)")}
    else { return String("\(hoursString):\(minutesString):\(secondsString)")}
}

//BEGIN - Read all user calendars and return calender titles with the type
func readUserCalendarData() ->(name: Array<String>, type: Array<Int>, id: Array<String>,calendarColor: Array<CGColor>)  {
    var calendarTitles :[String] = []
    var calendarType : [Int] = []
    var calendarID : [String] = []
    var calendarColor: [CGColor] = []
    
    
    if eventAccessApproved
    {
        
        let calendars = eventStore.calendars(for: .event)
  //      let selected = eventStore.calendar(withIdentifier: <#T##String#>)
        // Display all returned calendars
        for calendar in calendars
        {
            calendarTitles.append(calendar.title)
            calendarType.append(calendar.type.rawValue)
            calendarID.append(calendar.calendarIdentifier)
            calendarColor.append(calendar.cgColor)
        }
    }
    return (calendarTitles, calendarType,calendarID,calendarColor)
}
//END


func getDefaultCalender() -> (name: String, calendarColor: CGColor, id: String){
    var calendarName: String = ""
    var calendarColor: CGColor? = UIColor.black.cgColor
    var calendarID: String = ""
           
    if eventAccessApproved
    {
        let calendar = eventStore.defaultCalendarForNewEvents
        if calendar != nil {
            calendarName = calendar!.title
            calendarColor = calendar!.cgColor
            calendarID = calendar!.calendarIdentifier
        }
        else
        {
            let calendarData = readUserCalendarData()
            let calendarNames = calendarData.name
            let calendarColors = calendarData.calendarColor
            let calendarIDs =  calendarData.id
            
            print ("There is no default calendar set,so I will pick the first one")
            
            calendarName = calendarNames[0]
            calendarColor = calendarColors[0]
            calendarID = calendarIDs[0]
        }
    }
    return (calendarName,calendarColor!,calendarID)
}



//BEGIN - Read all user calendars and return calender titles with the type
func readCalendarName(calendarID: String) ->(String)  {
    var calendarName: String = "No Name"
    
    if eventAccessApproved
    {
        let calendars = eventStore.calendars(for: .event)
        for calendar in calendars
        {
            if calendar.calendarIdentifier == calendarID {
                calendarName = calendar.title
            }
        }
    }
    return calendarName
}
    //END


//BEGIN - Read all user calendars and return calender titles with the type
func readUserEditableCalendars() ->(name: Array<String>, type: Array<Int>, id: Array<String>,calendarColor: Array<CGColor>)  {
    var calendarTitles :[String] = []
    var calendarType : [Int] = []
    var calendarID : [String] = []
    var calendarColor: [CGColor] = []
    
    if eventAccessApproved
    {
        let calendars = eventStore.calendars(for: .event)
        //      let selected = eventStore.calendar(withIdentifier: <#T##String#>)
        // Display all returned calendars
        for calendar in calendars
        {
            if calendar.allowsContentModifications == true {
                calendarTitles.append(calendar.title)
                calendarType.append(calendar.type.rawValue)
                calendarID.append(calendar.calendarIdentifier)
                calendarColor.append(calendar.cgColor)
            }
        }
    }
    return (calendarTitles, calendarType, calendarID,calendarColor)
}
//END


func convertSecondsInAlarmStr (seconds: Int) -> String{
    var alarmStr: String = ""
    var alarmBeforeEvent = true
    if seconds > 0 {alarmBeforeEvent = false}
    let sec = abs(seconds)
    
    let seconds = Int(sec % 60)
    
    let minutes = (sec / 60) % 60
    let hours = (sec / 3600) % 24
    let days = sec / (3600*24) % 7
    let weeks = sec / (3600*24*7)
    
    let secondsStr = ("\(seconds) \(NSLocalizedString("seconds", comment: "")) ")
    let minutesStr = ("\(minutes) \(NSLocalizedString("min.", comment: "")) ")
    let hoursStr = ("\(hours) \(NSLocalizedString("hours", comment: "")) ")
    let daysStr = ("\(days) \(NSLocalizedString("days", comment: "")) ")
    let weeksStr = ("\(weeks) \(NSLocalizedString("weeks", comment: "")) ")
    
    let minuteStr = ("\(minutes) \(NSLocalizedString("min.", comment: "")) ")
    let hourStr = ("\(hours) \(NSLocalizedString("hour", comment: "")) ")
    let dayStr = ("\(days) \(NSLocalizedString("day", comment: "")) ")
    let weekStr = ("\(weeks) \(NSLocalizedString("week", comment: "")) ")
    
    
    if seconds != 0 { alarmStr.append(secondsStr)}
    if minutes != 0
    {
        if minutes == 1 {alarmStr.append(minuteStr)}
        else {alarmStr.append(minutesStr)}
    }
      
    if hours != 0
    {
        if hours == 1 {alarmStr.append(hourStr)}
        else {alarmStr.append(hoursStr)}
    }
    
    if days != 0
    {
        if days == 1 {alarmStr.append(dayStr)}
        else {alarmStr.append(daysStr)}
    }
    
    if weeks != 0
    {
        if weeks == 1 {alarmStr.append(weekStr)}
        else {alarmStr.append(weeksStr)}
    }
    
    if alarmBeforeEvent { alarmStr.append(NSLocalizedString("before", comment: ""))}
    else {alarmStr.append(NSLocalizedString("after", comment: "")) }
    if sec == 0 {alarmStr = (NSLocalizedString("None", comment: ""))}
    
    return alarmStr
}





//BEGIN - Read all the events from given calendername and type
func readBirthdayCalendarEvents(requestedCalendars: [EKCalendar]) -> (titles : Array<String>, startDate : Array<NSDate>, endDate : Array<NSDate>, calendarColor: Array<CGColor>) {
    var titles    : [String] = []
    var startDate : [NSDate] = []
    var endDate   : [NSDate] = []
    var colour    : [CGColor] = []
    var mergedEvents: [EKEvent] = []
    
    //If you do not check for Empty, it will load all calendars by default, hence need to check if array is empty.
    
    if eventAccessApproved && requestedCalendars.count != 0
    {
        //let calendars = eventStore.calendars(for: .event)
        
        let now = NSDate()
        let futureDate = NSDate(timeIntervalSinceNow: 180*24*3600) //only fetch 180 days of events
        let predicate = eventStore.predicateForEvents(withStart: now as Date, end: futureDate as Date, calendars: requestedCalendars)
        let events = eventStore.events(matching: predicate)
        
        for event in events {
           mergedEvents.append(event)
        }
        //BEGIN - you need below order else the events will not show up exactly ordered, this was a bug in Version 1.8
        mergedEvents.sort { $0.startDate < $1.startDate  }
        //END
        
        for event in mergedEvents {
            titles.append(event.title)
            startDate.append(event.startDate! as NSDate)
            endDate.append(event.endDate! as NSDate)
            colour.append(event.calendar.cgColor)
        }
    }
    return (titles, startDate, endDate, colour)
}
//END

//BEGIN - Read events with an unqiue ID
func readCalendarEventWithID(reqEventID: String) -> (eventName : String, eventDescription: String, startDate: NSDate, stopDate: NSDate, allDayEvent: Bool, calendarID: String, calendarName: String, hasRecurrence: Bool, calendarColor: CGColor, duration: String, eventHasAlarm: Bool, alarmSeconds: Int) {
    var eventName: String = ""
    let eventDescription: String = ""
    var startDate: NSDate = Date() as NSDate
    var stopDate: NSDate = Date() as NSDate
    var allDayEvent: Bool = true
    var calendarID: String = ""
    var hasRecurrence: Bool!
    var calendarColor: CGColor!
    var calendarName: String! = ""
    var duration: String = ""
    var eventHasAlarm: Bool = false
    var alarmSeconds: Int = 0
    
    if eventAccessApproved
    {
        let event = eventStore.event(withIdentifier: reqEventID)
        eventName = event!.title
        startDate = event!.startDate! as NSDate
        stopDate = event!.endDate! as NSDate
        allDayEvent = event!.isAllDay
        
        //alarm = event!.alarms!
        //recurrence = event!.recurrenceRules!
        hasRecurrence = event!.hasRecurrenceRules
        calendarID = event!.calendar.calendarIdentifier
        calendarColor = event!.calendar.cgColor
        calendarName = event!.calendar.title
        eventHasAlarm = event!.hasAlarms
        alarmSeconds = 0
        if eventHasAlarm == true {
            if event!.alarms != nil {
                alarmSeconds = Int((event!.alarms?.first!.relativeOffset)!)
            }
        }
        if allDayEvent == true {duration = NSLocalizedString("All Day", comment: "")}
        
        
        
    }
    return (eventName, eventDescription, startDate, stopDate, allDayEvent, calendarID, calendarName, hasRecurrence, calendarColor, duration, eventHasAlarm,alarmSeconds)
}

//BEGIN - Read recurrence rules from event
func readCalendarRecurrenceEventWithID(reqEventID: String) -> (Recurrence) {
    var eventSetRecurrence = Recurrence()
    
    if eventAccessApproved
    {
        let event = eventStore.event(withIdentifier: reqEventID)
        let thisRecurrence = event?.recurrenceRules
        
        //BEGIN - only read a recurrence if there is one, else the app
        eventSetRecurrence.hasreccurence = event!.hasRecurrenceRules
        eventSetRecurrence.type = thisRecurrence![0].frequency
        eventSetRecurrence.interval = thisRecurrence![0].interval
        eventSetRecurrence.daysOfTheWeek = thisRecurrence![0].daysOfTheWeek
        eventSetRecurrence.daysOfTheMonth = thisRecurrence![0].daysOfTheMonth
        eventSetRecurrence.monthsOfTheYear = thisRecurrence![0].monthsOfTheYear
        eventSetRecurrence.weeksOfTheYear = thisRecurrence![0].weeksOfTheYear
        eventSetRecurrence.daysOfTheYear = thisRecurrence![0].daysOfTheYear
        eventSetRecurrence.setPositions = thisRecurrence![0].setPositions
        eventSetRecurrence.end = thisRecurrence![0].recurrenceEnd
    }
    return (eventSetRecurrence)
}
//END




func addEventToCalendar(title: String?, description: String?, startDate: Date, endDate: Date, allDayEvent: Bool, calenderID: String, recurrence: Recurrence, alarmSeconds: Double, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
    DispatchQueue.global(qos: .background).async { () -> Void in
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                //let alarm = EKAlarm(relativeOffset: -3600.0)
                let event = EKEvent(eventStore: eventStore)
                if title == nil {event.title = ""} //prevent crash when user does not enter a value
                else {event.title = title}
                
                event.startDate = startDate
                event.endDate = endDate
                
      
                if description == nil {event.notes = ""} //prevent crash when user does not enter a value
                else {event.notes = description}
    
                event.alarms = nil
                event.isAllDay = allDayEvent
                
                if alarmSeconds == 0
                {
                    print ("No Alarm set")
                    event.alarms = nil
                }
                else {
                    //print ("Alarm will be set to seconds: \(eventAlarmLabels[userSelectedAlarm])")
                    //let seconds: Double = Double(userSelectedAlarmSeconds)
                    let aInterval: TimeInterval = alarmSeconds
                    let alarmTime = EKAlarm(relativeOffset: aInterval)
                    
                    event.alarms = [alarmTime]
                    
                }
                
                if userSetRecurrence.hasreccurence == false {
                    event.recurrenceRules = .none
                    print ("** I wrote event, with no recurrence")
                }
                else {
                    
                    let recurrenceRule1 = EKRecurrenceRule.init(
                        recurrenceWith: userSetRecurrence.type,
                        interval: userSetRecurrence.interval,
                        daysOfTheWeek: userSetRecurrence.daysOfTheWeek,
                        daysOfTheMonth: userSetRecurrence.daysOfTheMonth,
                        monthsOfTheYear: userSetRecurrence.monthsOfTheYear,
                        weeksOfTheYear: userSetRecurrence.weeksOfTheYear,
                        daysOfTheYear: userSetRecurrence.daysOfTheYear,
                        setPositions: userSetRecurrence.setPositions,
                        end: userSetRecurrence.end
                    )
                    event.recurrenceRules = [recurrenceRule1]
                    
                    
                   /* event.recurrenceRules = [EKRecurrenceRule(recurrenceWith: userSetRecurrence.type, interval: userSetRecurrence.interval, daysOfTheWeek: userSetRecurrence.daysOfTheWeek, daysOfTheMonth: userSetRecurrence.daysOfTheMonth, monthsOfTheYear: userSetRecurrence.monthsOfTheYear, weeksOfTheYear: userSetRecurrence.weeksOfTheYear, daysOfTheYear: userSetRecurrence.daysOfTheYear, setPositions: userSetRecurrence.setPositions, end: userSetRecurrence.end)]*/
                    print ("** I wrote event \(recurrenceRule1)")
                    print ("*** I also wrote \(userSetRecurrence)")
                }
                
                event.calendar = eventStore.calendar(withIdentifier: userSelectedCalendarID)
                do {
                    print ("SAVED")
                   
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    print ("Error Saving Event")
                    completion?(false, e)
                    print ("\(#file) - \(#function) error: \(e.localizedDescription)")
                    return
                }
                print ("I added the event")
                eventAddedSucces = true
                // Clear the event name
                calendarEventNameString = ""
                completion?(true, nil)
                
            
            }
            else {
                completion?(false, error as NSError?)
                //print ("\(#file) - \(#function) error: \(error)")
            }
        })
    }
}
//BEGIN - read all event from a date from 00:00:01 to 23:59:59 and only return event that ,match the calenders requested
func readEventsFromDate(requestedDate:Date, requestedCalendars: [EKCalendar]) -> (titles: Array<String>, startTime: Array<NSDate>, endTime: Array<NSDate>, calendarColor: Array<CGColor>, requestedEventID : Array<String>, AllDayEvent: Array<Bool>)
{
    
    
    var requestedTitles : [String] = []
    var requestedStartTime : [NSDate] = []
    var requestedEndTime : [NSDate] = []
    var requestedCalendarColor: [CGColor] = []
    var requestedEventID: [String] = []
    var AllDayEvent: [Bool] = []
    var fetchedEvents: [EKEvent] = []
    var allDayEvents: [EKEvent] = []
    var timedEvents: [EKEvent] = []
    var mergedEvents: [EKEvent] = []
    
    if eventAccessApproved && requestedCalendars.count != 0
    {
        //let requestedCalendars = eventStore.calendars(for: .event)
        let calendar = Calendar.current
        let startOfDay = calendar.date(
            bySettingHour: 0,
            minute: 0,
            second: 1,
            of: requestedDate)!
        
        let endOfDay = calendar.date(
            bySettingHour: 23,
            minute: 59,
            second: 59,
            of: requestedDate)!
        
        //BEGIN - Grab all events that meet the predicate and add them in a evetn array
        
        //for calendar in requestedCalendars {
            //if isTodayCalendarSelectedByUserDefaults(calendarID: calendar.calendarIdentifier) == true {
                let predicate = eventStore.predicateForEvents(withStart: startOfDay as Date, end: endOfDay as Date, calendars: requestedCalendars)
                let events = eventStore.events(matching: predicate)
                for event in events {
                    fetchedEvents.append(event)
            //    }
            //}
            //END
        }
        //BEGIN - split the events in two array one for all day and one for timed
        for event in fetchedEvents {
            if event.isAllDay == true {
                allDayEvents.append(event)
            } else {
                timedEvents.append(event)
            }
        }
        //end
        
        timedEvents.sort { $0.startDate < $1.startDate  }
        mergedEvents = allDayEvents + timedEvents
        
        for event in mergedEvents {
            requestedTitles.append(event.title)
            requestedStartTime.append(event.startDate! as NSDate)
            requestedEndTime.append(event.endDate! as NSDate)
            let calendar = event.calendar
            requestedCalendarColor.append(calendar!.cgColor)
            requestedEventID.append(event.eventIdentifier)
            AllDayEvent.append(event.isAllDay)
        }
    }
    return (requestedTitles,requestedStartTime,requestedEndTime,requestedCalendarColor,requestedEventID,AllDayEvent)
}

func readEventsFromDateOld(requestedDate:Date, calendarFilterID: [String]) -> (titles: Array<String>, startTime: Array<NSDate>, endTime: Array<NSDate>, calendarColor: Array<CGColor>, requestedEventID : Array<String>, AllDayEvent: Array<Bool>) {
    
    
    var requestedTitles : [String] = []
    var requestedStartTime : [NSDate] = []
    var requestedEndTime : [NSDate] = []
    var requestedCalendarColor: [CGColor] = []
    var requestedEventID: [String] = []
    var AllDayEvent: [Bool] = []
    var fetchedEvents: [EKEvent] = []
    var allDayEvents: [EKEvent] = []
    var timedEvents: [EKEvent] = []
    var mergedEvents: [EKEvent] = []
    
    if eventAccessApproved
    {
        let requestedCalendars = eventStore.calendars(for: .event)
        let calendar = Calendar.current
        let startOfDay = calendar.date(
            bySettingHour: 0,
            minute: 0,
            second: 1,
            of: requestedDate)!
        
        let endOfDay = calendar.date(
            bySettingHour: 23,
            minute: 59,
            second: 59,
            of: requestedDate)!
        
        //BEGIN - Grab all events that meet the predicate and add them in a evetn array
        
        for calendar in requestedCalendars {
            if isTodayCalendarSelectedByUserDefaults(calendarID: calendar.calendarIdentifier) == true {
                let predicate = eventStore.predicateForEvents(withStart: startOfDay as Date, end: endOfDay as Date, calendars: [calendar])
                let events = eventStore.events(matching: predicate)
                for event in events {
                    fetchedEvents.append(event)
                }
            }
            //END
        }
        //BEGIN - split the events in two array one for all day and one for timed
        for event in fetchedEvents {
            if event.isAllDay == true {
                allDayEvents.append(event)
            } else {
                timedEvents.append(event)
            }
        }
        //end
        
        timedEvents.sort { $0.startDate < $1.startDate  }
        mergedEvents = allDayEvents + timedEvents
        
        for event in mergedEvents {
            requestedTitles.append(event.title)
            requestedStartTime.append(event.startDate! as NSDate)
            requestedEndTime.append(event.endDate! as NSDate)
            let calendar = event.calendar
            requestedCalendarColor.append(calendar!.cgColor)
            requestedEventID.append(event.eventIdentifier)
            AllDayEvent.append(event.isAllDay)
        }
    }
    return (requestedTitles,requestedStartTime,requestedEndTime,requestedCalendarColor,requestedEventID,AllDayEvent)
}

func readCalendarEventsFromDate(requestedDate:Date) -> (titles: Array<String>, startTime: Array<NSDate>, endTime: Array<NSDate>, calendarColor: Array<CGColor>, requestedEventID : Array<String>, AllDayEvent: Array<Bool>) {
    
    var requestedTitles : [String] = []
    var requestedStartTime : [NSDate] = []
    var requestedEndTime : [NSDate] = []
    var requestedCalendarColor: [CGColor] = []
    var requestedEventID: [String] = []
    var AllDayEvent: [Bool] = []
    var fetchedEvents: [EKEvent] = []
    var allDayEvents: [EKEvent] = []
    var timedEvents: [EKEvent] = []
    var mergedEvents: [EKEvent] = []
    
    if eventAccessApproved
    {
        let requestedCalendars = eventStore.calendars(for: .event)
        let calendar = Calendar.current
        let startOfDay = calendar.date(
            bySettingHour: 0,
            minute: 0,
            second: 1,
            of: requestedDate)!
        
        let endOfDay = calendar.date(
            bySettingHour: 23,
            minute: 59,
            second: 59,
            of: requestedDate)!
        
        //BEGIN -Grab all events that meet the predicate and add them in a evetn array
        for calendar in requestedCalendars {
            let predicate = eventStore.predicateForEvents(withStart: startOfDay as Date, end: endOfDay as Date, calendars: [calendar])
            let events = eventStore.events(matching: predicate)
            for event in events {
                fetchedEvents.append(event)
            }
        }
        //END
        
        //BEGIN - split the events in two array one for all day and one for timed
        for event in fetchedEvents {
            if event.isAllDay == true {
                allDayEvents.append(event)
            } else {
                timedEvents.append(event)
            }
        }
        //end
        
        timedEvents.sort { $0.startDate < $1.startDate  }
        mergedEvents = allDayEvents + timedEvents
        
        for event in mergedEvents {
            requestedTitles.append(event.title)
            requestedStartTime.append(event.startDate! as NSDate)
            requestedEndTime.append(event.endDate! as NSDate)
            let calendar = event.calendar
            requestedCalendarColor.append(calendar!.cgColor)
            requestedEventID.append(event.eventIdentifier)
            AllDayEvent.append(event.isAllDay)
        }
    }
    return (requestedTitles,requestedStartTime,requestedEndTime,requestedCalendarColor,requestedEventID,AllDayEvent)
}

func daysBetweenDates(endDate: Date) -> Int {
    let calendar: Calendar = Calendar.current
    let date1 = calendar.startOfDay(for: Date())
    let date2 = calendar.startOfDay(for: endDate)
    return calendar.dateComponents([.day], from: date1, to: date2).day!
}









//BEGIN - Find the user calendar and try to match to the number in the array so when
//        you go to settings the user selected calendar is already set.
func getUserSelectedCalenderRow ()-> Int {
    var row = 0
    
    if eventAccessApproved
    {
        let calendarData = readUserCalendarData()
        let calendarNames = calendarData.name
        let calendarTypes = calendarData.type
        
        
        for i in 0..<calendarNames.count {
            if (calendarNames[i] == selectedCalendarName) && (calendarTypes[i] == selectedCalendarType) {
                row = i
            }
        }
    }
    return row
}

func isDeviceIn24HoursFormat() -> Bool {
    let dateFormat: String? =
        DateFormatter.dateFormat(fromTemplate:
                                    "j", options: 0, locale: NSLocale.current)
    
    if ((dateFormat as NSString?)?.range(of: "a"))?.location
        == NSNotFound
    {
        print ("I am in 24 hour mode")
        return true
    }
    else {
        print ("I am in 12 hour mode")
        return false
    }
}

func isDeviceDateInDayMonthFormat() -> (Bool) {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let date = dateFormatter.date(from: "2015-04-24")
    
    dateFormatter.dateStyle = .short
    
    let localeDateString  = dateFormatter.string(from:
                                                    date! as Date)
    
    dateFormatter.dateFormat = "d/MM/yyyy"
   
    //I set the date to 24-4 if the first character returned is 2 it meant the day is first.
    if localeDateString.first == "2" {
        //print ("Europe Date")
        return true
    }
    else{
        //print ("US Date")
        return false
    }
}



//BEGIN - Used in the main viewcontroller
func createDayCalendarView (x: Int, y: Int, width: Int, selectedDate: Date) -> UIView
{
    //Read all the calendar data
    let requestedEventData = readEventsFromDate(requestedDate:selectedDate, requestedCalendars: userDayCalendars)
    let calendarRows = requestedEventData.titles.count
    
    let textspacing = 40
    let textStartPostitionY = 5
    let timeLabelWidth = 70
    let myView = UIView(frame: CGRect(x: x, y: y, width: width, height: textStartPostitionY+(calendarRows * textspacing)))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm"
    
    
    if calendarRows != 0
    {
        for row in 0...calendarRows-1
        {
            if (colouredTodayCalendar) // NEW VIEW
            {
                //print ("New coloured View")
                let startTime = requestedEventData.startTime[row]
                let stopTime = requestedEventData.endTime[row]
                
                //BEGIN - New Background
                let myNewView=UIView(frame: CGRect(x: 0, y: (row * textspacing)+5, width: width-0, height: 30))
                
                let backgroundColour = UIColor.init(cgColor: requestedEventData.calendarColor[row])
                var subColour = backgroundColour.darker()
                if backgroundColour.isDarkColor {
                    subColour = backgroundColour.lighter()
                }
                
                // Add rounded corners to UIView
                myNewView.layer.cornerRadius = textfieldRadius
                // Add border to UIView
                //myNewView.layer.borderWidth = 1
                // Change UIView Border Color to Red
                //let BorderColor = requestedEventData.calendarColor[row]
                myNewView.backgroundColor = backgroundColour
                //myNewView.layer.borderColor =  subColour.cgColor
                // Add UIView as a Subview
                myView.addSubview(myNewView)
                //END
                
                
                if (Calendar.current.isDate(startTime as Date, inSameDayAs:stopTime as Date))
                {
                    
                    if requestedEventData.AllDayEvent[row] == true
                    {
                        let label = UILabel(frame: CGRect(x: 5, y: textStartPostitionY+(row * textspacing), width: width-5, height: 30))
                        label.font = UIFont.systemFont(ofSize: 25.0)
                        label.backgroundColor = .clear
                        label.lineBreakMode = .byTruncatingTail
                        label.textAlignment = .left
                        label.textColor = subColour
                        label.text = requestedEventData.titles[row]
                        myView.addSubview(label)
                    }
                    else
                    {
                        let label = UILabel(frame: CGRect(x: 5, y: textStartPostitionY+(row * textspacing), width: width-15-timeLabelWidth, height: 30))
                        label.font = UIFont.systemFont(ofSize: 25.0)
                        label.backgroundColor = .clear
                        label.lineBreakMode = .byTruncatingTail
                        label.textAlignment = .left
                        label.textColor = subColour
                        label.text = requestedEventData.titles[row]
                        myView.addSubview(label)
                        
                        let timeLbl = UILabel(frame: CGRect(x: width-timeLabelWidth-5 , y: textStartPostitionY+(row * textspacing), width: timeLabelWidth, height: 30))
                        timeLbl.font = UIFont.systemFont(ofSize: 25.0)
                        //timeLbl.font = UIFont.monospacedDigitSystemFont(ofSize: 25.0, weight: UIFont.Weight.regular)
                        timeLbl.backgroundColor = .clear
                        timeLbl.lineBreakMode = .byClipping
                        timeLbl.textAlignment = .right
                        timeLbl.textColor = subColour
                        timeLbl.text = dateFormatter.string(from: startTime as Date)
                        //timeLbl.text = "23:36"
                        myView.addSubview(timeLbl)
                    }
                }
                else
                {
                    //Multiple days
                    let label = UILabel(frame: CGRect(x: 5, y: textStartPostitionY+(row * textspacing), width: width-5, height: 30))
                    label.font = UIFont.systemFont(ofSize: 25.0)
                    label.backgroundColor = .clear
                    label.lineBreakMode = .byTruncatingTail
                    label.textAlignment = .left
                    label.textColor = subColour
                    label.text = requestedEventData.titles[row]
                    myView.addSubview(label)
                }
            }
            else // CLASSIC VIEW
            {
                //print ("Classic View")
                
                let startTime = requestedEventData.startTime[row]
                let stopTime = requestedEventData.endTime[row]
                
                //BEGIN - New Background
                let myNewView=UIView(frame: CGRect(x: 0, y: (row * textspacing)+5, width: width-0, height: 30))
                myNewView.backgroundColor = .clear
                myView.addSubview(myNewView)
                //END
                
                
                let imageView = UIImageView(frame: CGRect(x: 5, y: textStartPostitionY+(row * textspacing)+5, width: 4, height: 20))
                imageView.image = UIImage(named: "CellIDImg_M")?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = UIColor.init(cgColor: requestedEventData.calendarColor[row])
                imageView.contentMode = .center
                myView.addSubview(imageView)
                
                
                if (Calendar.current.isDate(startTime as Date, inSameDayAs:stopTime as Date))
                {
                    
                    if requestedEventData.AllDayEvent[row] == true
                    {
                        let label = UILabel(frame: CGRect(x: 14, y: textStartPostitionY+(row * textspacing), width: width-14, height: 30))
                        label.font = UIFont.systemFont(ofSize: 25.0)
                        label.backgroundColor = .clear
                        //label.backgroundColor = .green
                        label.lineBreakMode = .byTruncatingTail
                        label.textAlignment = .left
                        label.textColor = mainTextColor
                        label.text = requestedEventData.titles[row]
                        myView.addSubview(label)
                    }
                    else
                    {
                        let label = UILabel(frame: CGRect(x: 14, y: textStartPostitionY+(row * textspacing), width: width-15-timeLabelWidth-14, height: 30))
                        label.font = UIFont.systemFont(ofSize: 25.0)
                        label.backgroundColor = .clear
                        //label.backgroundColor = .green
                        label.lineBreakMode = .byTruncatingTail
                        label.textAlignment = .left
                        label.textColor = mainTextColor
                        
                        label.text = requestedEventData.titles[row]
                        myView.addSubview(label)
                        
                        let timeLbl = UILabel(frame: CGRect(x: width-timeLabelWidth-5 , y: textStartPostitionY+(row * textspacing), width: timeLabelWidth, height: 30))
                        timeLbl.font = UIFont.systemFont(ofSize: 25.0)
                        timeLbl.backgroundColor = .clear
                        //timeLbl.backgroundColor = .yellow
                        timeLbl.lineBreakMode = .byClipping
                        timeLbl.textAlignment = .right
                        timeLbl.textColor = subTextColor
                        
                        timeLbl.text = dateFormatter.string(from: startTime as Date)
                        myView.addSubview(timeLbl)
                    }
                }
                else
                {
                    //Multiple days
                    let label = UILabel(frame: CGRect(x: 14, y: textStartPostitionY+(row * textspacing), width: width-5, height: 30))
                    label.font = UIFont.systemFont(ofSize: 25.0)
                    label.backgroundColor = .clear
                    //label.backgroundColor = .green
                    label.lineBreakMode = .byTruncatingTail
                    label.textAlignment = .left
                    label.textColor = mainTextColor
                    label.text = requestedEventData.titles[row]
                    myView.addSubview(label)
                }
            }
        }
    }
    return myView
}
    
    func recurrenceText (recurrence: Recurrence) -> String {
        var recurrenceString: String = "Custom"
        if recurrence.hasreccurence == false {
            recurrenceString = NSLocalizedString("None", comment: "")
    }
    else {
        
        switch (recurrence.type) {
        case .daily:
            if (recurrence.interval == 0) {
                recurrenceString = "Error 0"}
            if (recurrence.interval == 1) {
                recurrenceString = NSLocalizedString("every day", comment: "")}
            else {
                recurrenceString = ("\(NSLocalizedString("every", comment: "")) \(recurrence.interval) \(NSLocalizedString("days", comment: ""))")
            }
        case .weekly:
            if (recurrence.interval == 0) {
                recurrenceString = "Error 0"}
            if (recurrence.interval == 1) {
                recurrenceString = NSLocalizedString("every week", comment: "")}
            else {
                recurrenceString = ("\(NSLocalizedString("every", comment: "")) \(recurrence.interval) \(NSLocalizedString("weeks", comment: ""))")
            }
            
            //BEGIN - Which day of the week is selected
            if recurrence.daysOfTheWeek != nil && recurrence.daysOfTheWeek?.isEmpty == false{
                let lastDay = recurrence.daysOfTheWeek!.last
                var moreThanOneDay: Bool = false
                if recurrence.daysOfTheWeek!.count > 1 {moreThanOneDay = true}
                
                recurrenceString = recurrenceString + " \(NSLocalizedString("each", comment: ""))"
                //recurrenceString = recurrenceString + " " //Add space
                
                if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) {
                    if lastDay?.dayOfTheWeek == .sunday {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("sunday", comment: ""))" + "."
                    }
                    else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("sunday", comment: ""))" + ","
                    }
                    print ("Sunday")
                    
                }
                if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) {
                    if moreThanOneDay && lastDay?.dayOfTheWeek == .monday {
                        recurrenceString.removeLast()
                       recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("monday", comment: "") + "."
                    }
                    else{
                        if lastDay?.dayOfTheWeek == .monday {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("monday", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("monday", comment: "")),"
                        }
                    }
                    print ("Monday")
               }
                if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) {
                    if moreThanOneDay && lastDay?.dayOfTheWeek == .tuesday {
                        recurrenceString.removeLast()
                       recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("tuesday", comment: "") + "."
                    }
                    else{
                        if lastDay?.dayOfTheWeek == .tuesday {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("tuesday", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("tuesday", comment: "")),"
                        }
                    }
                    print ("Tuesday")
               }
                if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) {
                    if moreThanOneDay && lastDay?.dayOfTheWeek == .wednesday {
                        recurrenceString.removeLast()
                       recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("wednesday", comment: "") + "."
                    }
                    else{
                        if lastDay?.dayOfTheWeek == .wednesday {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("wednesday", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("wednesday", comment: "")),"
                        }
                    }
                    print ("wednesday")
               }
                if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) {
                    if moreThanOneDay && lastDay?.dayOfTheWeek == .thursday {
                        recurrenceString.removeLast()
                       recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("thursday", comment: "") + "."
                    }
                    else{
                        if lastDay?.dayOfTheWeek == .thursday {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("thursday", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("thursday", comment: "")),"
                        }
                    }
                    print ("thursday")
               }
                if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) {
                    if moreThanOneDay && lastDay?.dayOfTheWeek == .friday {
                        recurrenceString.removeLast()
                       recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("friday", comment: "") + "."
                    }
                    else{
                        if lastDay?.dayOfTheWeek == .friday {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("friday", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("friday", comment: "")),"
                        }
                    }
                    print ("friday")
               }
                if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) {
                    if moreThanOneDay && lastDay?.dayOfTheWeek == .saturday {
                        recurrenceString.removeLast()
                       recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("saturday", comment: "") + "."
                    }
                    else{
                        if lastDay?.dayOfTheWeek == .saturday {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("saturday", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("saturday", comment: "")),"
                        }
                    }
                    print ("saturday")
               }
                //BEGIN - So the last weekday does not have a comma added
                recurrenceString.removeLast()
                //END
            }
            recurrenceString = recurrenceString + "."
            //END
            
            
        case .monthly:
            if (recurrence.interval == 0) {
                recurrenceString = "Error 0"}
            if (recurrence.interval == 1) {
                recurrenceString = NSLocalizedString("every month", comment: "")}
            else {
                recurrenceString = ("\(NSLocalizedString("every", comment: "")) \(recurrence.interval) \(NSLocalizedString("months", comment: ""))")
            }
            
            //BEGIN - Populate the selected day of the month Array
            if recurrence.daysOfTheMonth != nil && recurrence.daysOfTheMonth?.isEmpty == false{
                let formatter = NumberFormatter()
                formatter.numberStyle = .ordinal
                let lastDayOfMonth = recurrence.daysOfTheMonth!.last
                var moreThanOneDayInMonth: Bool = false
                if recurrence.daysOfTheMonth!.count > 1 {moreThanOneDayInMonth = true}
                
                recurrenceString = recurrenceString + " \(NSLocalizedString("on the", comment: ""))"
                
                
                //recurrenceString = recurrenceString + " " //Add space
                if recurrence.daysOfTheMonth!.contains(1) {
                    if lastDayOfMonth == 1 {recurrenceString = recurrenceString + " " + (formatter.string(from: 1) ?? "1st") + " "}
                    else{recurrenceString = recurrenceString + " " + (formatter.string(from: 1) ?? "1st") + ","}
                }
                
                if recurrence.daysOfTheMonth!.contains(2) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 2 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 2) ?? "2nd") + "."
                    }
                    else{
                        if lastDayOfMonth == 2  {recurrenceString = recurrenceString + " " + (formatter.string(from: 2) ?? "2nd") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 2) ?? "2nd") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(3) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 3 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 3) ?? "3rd") + "."
                    }
                    else{
                        if lastDayOfMonth == 3  {recurrenceString = recurrenceString + " " + (formatter.string(from: 3) ?? "3rd") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 3) ?? "3rd") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(4) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 4 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 4) ?? "4th") + "."
                    }
                    else{
                        if lastDayOfMonth == 4  {recurrenceString = recurrenceString + " " + (formatter.string(from: 4) ?? "4th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 4) ?? "4th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(5) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 5 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 5) ?? "5th") + "."
                    }
                    else{
                        if lastDayOfMonth == 5  {recurrenceString = recurrenceString + " " + (formatter.string(from: 5) ?? "5th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 5) ?? "5th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(6) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 6 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 6) ?? "6th") + "."
                    }
                    else{
                        if lastDayOfMonth == 6  {recurrenceString = recurrenceString + " " + (formatter.string(from: 6) ?? "6th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 6) ?? "6th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(7) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 7 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 7) ?? "7th") + "."
                    }
                    else{
                        if lastDayOfMonth == 7  {recurrenceString = recurrenceString + " " + (formatter.string(from: 7) ?? "7th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 7) ?? "7th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(8) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 8 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 8) ?? "8th") + "."
                    }
                    else{
                        if lastDayOfMonth == 8  {recurrenceString = recurrenceString + " " + (formatter.string(from: 8) ?? "8th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 8) ?? "8th") + ","}
                    }
                }
               
                if recurrence.daysOfTheMonth!.contains(9) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 9 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 9) ?? "9th") + "."
                    }
                    else{
                        if lastDayOfMonth == 9  {recurrenceString = recurrenceString + " " + (formatter.string(from: 9) ?? "9th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 9) ?? "9th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(10) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 10 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 10) ?? "10th") + "."
                    }
                    else{
                        if lastDayOfMonth == 10  {recurrenceString = recurrenceString + " " + (formatter.string(from: 10) ?? "10th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 10) ?? "10th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(11) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 11 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 11) ?? "11th") + "."
                    }
                    else{
                        if lastDayOfMonth == 11  {recurrenceString = recurrenceString + " " + (formatter.string(from: 11) ?? "11th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 11) ?? "11th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(12) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 12 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 12) ?? "12th") + "."
                    }
                    else{
                        if lastDayOfMonth == 12  {recurrenceString = recurrenceString + " " + (formatter.string(from: 12) ?? "12th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 12) ?? "12th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(13) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 13 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 13) ?? "13th") + "."
                    }
                    else{
                        if lastDayOfMonth == 13  {recurrenceString = recurrenceString + " " + (formatter.string(from: 13) ?? "13th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 13) ?? "13th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(14) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 14 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 14) ?? "14th") + "."
                    }
                    else{
                        if lastDayOfMonth == 14  {recurrenceString = recurrenceString + " " + (formatter.string(from: 14) ?? "13th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 14) ?? "14th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(15) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 15 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 15) ?? "15th") + "."
                    }
                    else{
                        if lastDayOfMonth == 15  {recurrenceString = recurrenceString + " " + (formatter.string(from: 15) ?? "15th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 15) ?? "15th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(16) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 16 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 16) ?? "16th") + "."
                    }
                    else{
                        if lastDayOfMonth == 16  {recurrenceString = recurrenceString + " " + (formatter.string(from: 16) ?? "16th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 16) ?? "16th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(17) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 17 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 17) ?? "17th") + "."
                    }
                    else{
                        if lastDayOfMonth == 17  {recurrenceString = recurrenceString + " " + (formatter.string(from: 17) ?? "17th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 17) ?? "17th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(18) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 18 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 18) ?? "18th") + "."
                    }
                    else{
                        if lastDayOfMonth == 18  {recurrenceString = recurrenceString + " " + (formatter.string(from: 18) ?? "18th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 18) ?? "18th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(19) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 19 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 19) ?? "19th") + "."
                    }
                    else{
                        if lastDayOfMonth == 19  {recurrenceString = recurrenceString + " " + (formatter.string(from: 19) ?? "19th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 19) ?? "19th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(20) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 20 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 20) ?? "20th") + "."
                    }
                    else{
                        if lastDayOfMonth == 20  {recurrenceString = recurrenceString + " " + (formatter.string(from: 20) ?? "20th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 20) ?? "20th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(21) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 21 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 21) ?? "21st") + "."
                    }
                    else{
                        if lastDayOfMonth == 21  {recurrenceString = recurrenceString + " " + (formatter.string(from: 21) ?? "21st") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 21) ?? "21st") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(22) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 22 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 22) ?? "22nd") + "."
                    }
                    else{
                        if lastDayOfMonth == 22  {recurrenceString = recurrenceString + " " + (formatter.string(from: 22) ?? "22nd") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 22) ?? "22nd") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(23) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 23 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 23) ?? "23rd") + "."
                    }
                    else{
                        if lastDayOfMonth == 23  {recurrenceString = recurrenceString + " " + (formatter.string(from: 23) ?? "23rd") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 23) ?? "23rd") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(24) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 24 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 24) ?? "24th") + "."
                    }
                    else{
                        if lastDayOfMonth == 24 {recurrenceString = recurrenceString + " " + (formatter.string(from: 24) ?? "24th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 24) ?? "24th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(25) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 25 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 25) ?? "25th") + "."
                    }
                    else{
                        if lastDayOfMonth == 25 {recurrenceString = recurrenceString + " " + (formatter.string(from: 25) ?? "25th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 25) ?? "25th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(26) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 26 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 26) ?? "26th") + "."
                    }
                    else{
                        if lastDayOfMonth == 26 {recurrenceString = recurrenceString + " " + (formatter.string(from: 26) ?? "26th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 26) ?? "26th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(27) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 27 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 27) ?? "27th") + "."
                    }
                    else{
                        if lastDayOfMonth == 27 {recurrenceString = recurrenceString + " " + (formatter.string(from: 27) ?? "27th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 27) ?? "27th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(28) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 28 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 28) ?? "28th") + "."
                    }
                    else{
                        if lastDayOfMonth == 28 {recurrenceString = recurrenceString + " " + (formatter.string(from: 28) ?? "28th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 28) ?? "28th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(29) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 29 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 29) ?? "29th") + "."
                    }
                    else{
                        if lastDayOfMonth == 29 {recurrenceString = recurrenceString + " " + (formatter.string(from: 29) ?? "29th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 29) ?? "29th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(30) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 30 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 30) ?? "30th") + "."
                    }
                    else{
                        if lastDayOfMonth == 30 {recurrenceString = recurrenceString + " " + (formatter.string(from: 30) ?? "30th") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 30) ?? "30th") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(31) {
                    if moreThanOneDayInMonth && lastDayOfMonth == 31 {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + (formatter.string(from: 31) ?? "31st") + "."
                    }
                    else{
                        if lastDayOfMonth == 31 {recurrenceString = recurrenceString + " " + (formatter.string(from: 31) ?? "31st") + " "}
                        else{recurrenceString = recurrenceString + " " + (formatter.string(from: 31) ?? "31st") + ","}
                    }
                }
                
                if recurrence.daysOfTheMonth!.contains(-1) {
                    if moreThanOneDayInMonth {
                        recurrenceString.removeLast() //remove the comma from last number.
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " \(NSLocalizedString("last", comment: "")),"}
                    else {recurrenceString = recurrenceString + " \(NSLocalizedString("last", comment: "")),"}
                }
                
                recurrenceString.removeLast() //remove the comma from last number.
                recurrenceString = recurrenceString + " \(NSLocalizedString("day", comment: ""))."
            }
            //END
            
            //BEGIN - Set variable array 1,2,3,4,5th week or last week
            if recurrence.setPositions != nil && recurrence.setPositions?.isEmpty == false {
                print ("set position is set to: \(recurrence.setPositions!)")
                recurrenceString = recurrenceString + " \(NSLocalizedString("on the", comment: ""))"
                recurrenceString = recurrenceString + " " //Add space
                if recurrence.setPositions!.contains(1) {recurrenceString = recurrenceString + "\(NSLocalizedString("first", comment: ""))" }
                if recurrence.setPositions!.contains(2) {recurrenceString = recurrenceString + "\(NSLocalizedString("second", comment: ""))" }
                if recurrence.setPositions!.contains(3) {recurrenceString = recurrenceString + "\(NSLocalizedString("third", comment: ""))" }
                if recurrence.setPositions!.contains(4) {recurrenceString = recurrenceString + "\(NSLocalizedString("fourth", comment: ""))" }
                if recurrence.setPositions!.contains(5) {recurrenceString = recurrenceString + "\(NSLocalizedString("fifth", comment: ""))" }
                if recurrence.setPositions!.contains(-1) {recurrenceString = recurrenceString + "\(NSLocalizedString("last", comment: ""))" }
            }
            
            //END
            
            //BEGIN - Which day of the week is selected
            if recurrence.daysOfTheWeek != nil && recurrence.daysOfTheWeek?.isEmpty ==  false {
                print ("week day set to: \(recurrence.daysOfTheWeek!)")
                let singleString = recurrence.daysOfTheWeek![0]
                let partOfTheWeek = singleString.weekNumber
                //BEGIN the part of the week has been set
                if partOfTheWeek != 0 {
                    print ("the week number I found is: \(partOfTheWeek)")
                    recurrenceString = recurrenceString + " \(NSLocalizedString("on the", comment: ""))"
                    recurrenceString = recurrenceString + " " //Add space
                    if partOfTheWeek == 1 {recurrenceString = recurrenceString + "\(NSLocalizedString("first", comment: ""))" }
                    if partOfTheWeek == 2 {recurrenceString = recurrenceString + "\(NSLocalizedString("second", comment: ""))" }
                    if partOfTheWeek == 3 {recurrenceString = recurrenceString + "\(NSLocalizedString("third", comment: ""))" }
                    if partOfTheWeek == 4 {recurrenceString = recurrenceString + "\(NSLocalizedString("fourth", comment: ""))" }
                    if partOfTheWeek == 5 {recurrenceString = recurrenceString + "\(NSLocalizedString("fifth", comment: ""))" }
                    if partOfTheWeek == -1 {recurrenceString = recurrenceString + "\(NSLocalizedString("last", comment: ""))" }
                }
                //END
                
                if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) == false &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) == false {
                    print ("Weekday is set")
                    
                    recurrenceString = recurrenceString + " \(NSLocalizedString("weekday", comment: ""))"
                    recurrenceString = recurrenceString + "." //Add period
                }
                else {
                    //Check if weekend filter has been set
                    if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) {
                        
                        recurrenceString = recurrenceString + " \(NSLocalizedString("weekend", comment: ""))"
                        recurrenceString = recurrenceString + "." //Add period
                    }
                    else {
                        let singleString = recurrence.daysOfTheWeek![0]
                        let weekDay = singleString.dayOfTheWeek
                        
                        if weekDay == .sunday {
                            print ("Sunday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("sunday", comment: "")),"
                        }
                        if weekDay == .monday {
                            print ("Monday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("monday", comment: "")),"
                        }
                        if weekDay == .tuesday {
                            print ("Tuesday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("tuesday", comment: "")),"
                        }
                        if weekDay == .wednesday{
                            print ("Wednesday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("wednesday", comment: "")),"
                        }
                        if weekDay == .thursday {
                            print ("Thursday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("thursday", comment: "")),"
                        }
                        if weekDay == .friday {
                            print ("Friday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("friday", comment: "")),"
                        }
                        if weekDay == .saturday {
                            print ("Saturday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("saturday", comment: "")),"
                        }
                        
                        //BEGIN - So the last weekday does not have a comma added
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + "."
                        //END
                    }
                }
            }
        case.yearly:
            
            if (recurrence.interval == 0) {
                recurrenceString = "Error 0"}
            if (recurrence.interval == 1) {
                recurrenceString = NSLocalizedString("every year", comment: "")}
            else {
                recurrenceString = ("\(NSLocalizedString("every", comment: "")) \(recurrence.interval) \(NSLocalizedString("years", comment: ""))")
            }
            
            
            //BEGIN - which month is selected
            if recurrence.monthsOfTheYear != nil {
                let lastmonth = recurrence.monthsOfTheYear!.last
                var moreThanOneMonth: Bool = false
                if recurrence.monthsOfTheYear!.count > 1 {moreThanOneMonth = true}
                    
                    
                recurrenceString = recurrenceString + " \(NSLocalizedString("in", comment: ""))"
                //recurrenceString = recurrenceString + " " //Add space
                if recurrence.monthsOfTheYear!.contains(1){
                    if lastmonth == 1 {
                        recurrenceString = recurrenceString + " " +  NSLocalizedString("jan", comment: "") + "."
                    }
                    else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("jan", comment: "")),"}
                }
                
                
                
                if recurrence.monthsOfTheYear!.contains(2) {
                    if moreThanOneMonth && lastmonth == 2 {
                        recurrenceString.removeLast()
                       recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("feb", comment: "") + "."
                    }
                    else{
                        if lastmonth == 2 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("feb", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("feb", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(3) {
                    if moreThanOneMonth && lastmonth == 3 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("mar", comment: "") + "."
                    }
                    else{
                        if lastmonth == 3 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("mar", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("mar", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(4) {
                    if moreThanOneMonth && lastmonth == 4 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("apr", comment: "") + "."
                    }
                    else{
                        if lastmonth == 4 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("apr", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("apr", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(5) {
                    if moreThanOneMonth && lastmonth == 5 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("may", comment: "") + "."
                    }
                    else{
                        if lastmonth == 5 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("may", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("may", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(6) {
                    if moreThanOneMonth && lastmonth == 6 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("jun", comment: "") + "."
                    }
                    else{
                        if lastmonth == 6 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("jun", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("jun", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(7) {
                    if moreThanOneMonth && lastmonth == 7 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("jul", comment: "") + "."
                    }
                    else{
                        if lastmonth == 7 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("jul", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("jul", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(8) {
                    if moreThanOneMonth && lastmonth == 8 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("aug", comment: "") + "."
                    }
                    else{
                        if lastmonth == 8 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("aug", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("aug", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(9) {
                    if moreThanOneMonth && lastmonth == 9 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("sep", comment: "") + "."
                    }
                    else{
                        if lastmonth == 9 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("sep", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("sep", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(10) {
                    if moreThanOneMonth && lastmonth == 10 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("oct", comment: "") + "."
                    }
                    else{
                        if lastmonth == 10 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("oct", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("oct", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(11) {
                    if moreThanOneMonth && lastmonth == 11 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("nov", comment: "") + "."
                    }
                    else{
                        if lastmonth == 11 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("nov", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("nov", comment: "")),"
                        }
                    }
                }
                if recurrence.monthsOfTheYear!.contains(12) {
                    if moreThanOneMonth && lastmonth == 12 {
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + " " + NSLocalizedString("and", comment: "") + " " + NSLocalizedString("dec", comment: "") + "."
                    }
                    else{
                        if lastmonth == 12 {
                        recurrenceString = recurrenceString + " \(NSLocalizedString("dec", comment: ""))."
                        }
                        else{
                        recurrenceString = recurrenceString + " \(NSLocalizedString("dec", comment: "")),"
                        }
                    }
                }
            }
            
            //BEGIN - Set variable array 1,2,3,4,5th week or last week
            if recurrence.setPositions != nil && recurrence.setPositions?.isEmpty == false {
                recurrenceString = recurrenceString + " \(NSLocalizedString("On the", comment: ""))"
                recurrenceString = recurrenceString + " " //Add space
                
                if recurrence.setPositions!.contains(1) {recurrenceString = recurrenceString + "\(NSLocalizedString("first", comment: ""))" }
                if recurrence.setPositions!.contains(2) {recurrenceString = recurrenceString + "\(NSLocalizedString("second", comment: ""))" }
                if recurrence.setPositions!.contains(3) {recurrenceString = recurrenceString + "\(NSLocalizedString("third", comment: ""))" }
                if recurrence.setPositions!.contains(4) {recurrenceString = recurrenceString + "\(NSLocalizedString("fourth", comment: ""))" }
                if recurrence.setPositions!.contains(5) {recurrenceString = recurrenceString + "\(NSLocalizedString("fifth", comment: ""))" }
                if recurrence.setPositions!.contains(-1) {recurrenceString = recurrenceString + "\(NSLocalizedString("last", comment: ""))" }
            }
            
            //END
            
            //BEGIN - Which day of the week is selected
            if recurrence.daysOfTheWeek != nil && recurrence.daysOfTheWeek?.isEmpty ==  false {
                print ("week day set to: \(recurrence.daysOfTheWeek!)")
                let singleString = recurrence.daysOfTheWeek![0]
                let partOfTheWeek = singleString.weekNumber
                //BEGIN the part of the week has been set
                if partOfTheWeek != 0 {
                    print ("the week number I found is: \(partOfTheWeek)")
                    recurrenceString = recurrenceString + " \(NSLocalizedString("On the", comment: ""))"
                    recurrenceString = recurrenceString + " " //Add space
                    if partOfTheWeek == 1 {recurrenceString = recurrenceString + "\(NSLocalizedString("first", comment: ""))" }
                    if partOfTheWeek == 2 {recurrenceString = recurrenceString + "\(NSLocalizedString("second", comment: ""))" }
                    if partOfTheWeek == 3 {recurrenceString = recurrenceString + "\(NSLocalizedString("third", comment: ""))" }
                    if partOfTheWeek == 4 {recurrenceString = recurrenceString + "\(NSLocalizedString("fourth", comment: ""))" }
                    if partOfTheWeek == 5 {recurrenceString = recurrenceString + "\(NSLocalizedString("fifth", comment: ""))" }
                    if partOfTheWeek == -1 {recurrenceString = recurrenceString + "\(NSLocalizedString("last", comment: ""))" }
                }
                //END
                
                if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) == false &&
                    recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) == false {
                    print ("Weekday is set")
                    
                    recurrenceString = recurrenceString + " \(NSLocalizedString("weekday", comment: ""))"
                    recurrenceString = recurrenceString + "." //Add period
                }
                else {
                    //Check if weekend filter has been set
                    if recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.monday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.tuesday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.wednesday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.thursday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.friday)) == false &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.saturday)) &&
                        recurrence.daysOfTheWeek!.contains(EKRecurrenceDayOfWeek(.sunday)) {
                        
                        recurrenceString = recurrenceString + " \(NSLocalizedString("weekend", comment: ""))"
                        recurrenceString = recurrenceString + "." //Add period
                    }
                    else {
                        let singleString = recurrence.daysOfTheWeek![0]
                        let weekDay = singleString.dayOfTheWeek
                        
                        if weekDay == .sunday {
                            print ("Sunday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("sunday", comment: "")),"
                        }
                        if weekDay == .monday {
                            print ("Monday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("monday", comment: "")),"
                        }
                        if weekDay == .tuesday {
                            print ("Tuesday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("tuesday", comment: "")),"
                        }
                        if weekDay == .wednesday{
                            print ("Wednesday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("wednesday", comment: "")),"
                        }
                        if weekDay == .thursday {
                            print ("Thursday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("thursday", comment: "")),"
                        }
                        if weekDay == .friday {
                            print ("Friday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("friday", comment: "")),"
                        }
                        if weekDay == .saturday {
                            print ("Saturday")
                            recurrenceString = recurrenceString + " \(NSLocalizedString("saturday", comment: "")),"
                        }
                        
                        //BEGIN - So the last weekday does not have a comma added
                        recurrenceString.removeLast()
                        recurrenceString = recurrenceString + "."
                        //END
                    }
                }
            }
        default:
            print ("Error - A new frequency has been added, which I do not know how to handle!")
        }
    }
    return recurrenceString
}

//BEGIN - read all event from a date from 00:00:01 to 23:59:59 and only return event that ,match the calenders requested
func readEventsFromDateSimple(requestedDate:Date, requestedCalendars: [EKCalendar]) -> (titles: Array<String>, calendarColor: Array<CGColor>, time: Array<String>) {
    
    var requestedTitles : [String] = []
    var requestedCalendarColor: [CGColor] = []
    var requestedTime: [String] = []
    //var allDayEvents: [EKEvent] = []
    //var timedEvents: [EKEvent] = []
    //var mergedEvents: [EKEvent] = []
    
    if eventAccessApproved
    {
        let calendar = Calendar.current
        let startOfDay = calendar.date(
            bySettingHour: 0,
            minute: 0,
            second: 0,
            of: requestedDate)!
        
        let endOfDay = calendar.date(
            bySettingHour: 23,
            minute: 59,
            second: 59,
            of: requestedDate)!
        
    
        let predicate = eventStore.predicateForEvents(withStart: startOfDay as Date, end: endOfDay as Date, calendars: requestedCalendars)
        let events = eventStore.events(matching: predicate)
        /* Not required
        for event in events {
            if event.isAllDay == true {
                allDayEvents.append(event)
            } else {
                timedEvents.append(event)
            }
        }
        //BEGIN - you need below order else the events will not show up exactly ordered, this was a bug in Version 1.8
        timedEvents.sort { $0.startDate < $1.startDate  }
        mergedEvents = allDayEvents + timedEvents
        //END */
        
        for event in events {
            requestedTitles.append(event.title)
            let calendar = event.calendar
            requestedCalendarColor.append(calendar!.cgColor)
            
            if (Calendar.current.isDate(event.startDate as Date, inSameDayAs:event.endDate as Date))
            {
                if event.isAllDay
                {
                    //Single All Day
                    requestedTime.append("")
                }
                else
                {
                    //Today with Start time
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "h:mm"
                    requestedTime.append("\(dateFormatter.string(from: event.startDate as Date))")
                }
            }
            else
            {
                //Multiple days
                requestedTime.append("")
            }
        }
    }
    return (requestedTitles,requestedCalendarColor,requestedTime)
}



func createDayFrameView (x: Int, y: Int, width: Int, height: Int, selectedDate: Date) -> UIView
{
    
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
    
    let calendar = Calendar.current
    if calendar.isDateInWeekend(selectedDate) {myView.backgroundColor = subWindowColor }
    
    let label = UILabel(frame: CGRect(x: 5, y: 0, width: width, height: 30))
    label.font = UIFont.systemFont(ofSize: 25.0)
    label.backgroundColor = .clear
    label.lineBreakMode = .byTruncatingTail
    label.textAlignment = .left
    label.textColor = mainTextColor
    label.text = "\(Calendar.current.component(.day, from: selectedDate))"
    
    let selectedDay = Calendar.current.component(.day, from: selectedDate)
    let selectedMonth = Calendar.current.component(.month, from: selectedDate)
    let selectedYear = Calendar.current.component(.year, from: selectedDate)
    
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
    
    myView.addSubview(label)
     
    return myView
}

func getEventsFromCalendarStore(reqMonth: Int, reqYear: Int, reqCalendars: [EKCalendar]) -> ([[String]], [[CGColor]]){
    let daysInRequestedMonth = numberOfDaysInMonth (Month: reqMonth,Year: reqYear)
    
    var dateComponent = DateComponents()
    dateComponent.month = reqMonth
    dateComponent.year = reqYear
    var groupedEventsTitle = Array(repeating: [String](), count: 31)
    var groupedCalendarColours = Array(repeating: [CGColor](), count: 31)
    
    for n in 1...daysInRequestedMonth
    {
        dateComponent.day = n
        let requestedStartDate = Calendar.current.date(from: dateComponent)
        //print (" tem date is \(requestedStartDate!)")
        //let requestedEventData = readEventsFromDate(requestedDate:requestedStartDate!, calendarFilterID: calendarFilterID)
        let requestedEventData = readEventsFromDateSimple(requestedDate:requestedStartDate!, requestedCalendars: reqCalendars)
        
        groupedEventsTitle[n-1] = requestedEventData.titles
        groupedCalendarColours[n-1] = requestedEventData.calendarColor
    }
    
    return (groupedEventsTitle , groupedCalendarColours)
}



func loadCalendarMonthData(reqMonth: Int, reqYear: Int, reqCalendars:[EKCalendar]) -> ([[String]], [[CGColor]])
{
    var monthEventsTitle = Array(repeating: [String](), count: 31)
    var monthCalendarColours = Array(repeating: [CGColor](), count: 31)
    
    (monthEventsTitle,monthCalendarColours) = getEventsFromCalendarStore(reqMonth: reqMonth, reqYear: reqYear, reqCalendars: userDayCalendars)
        
    return (monthEventsTitle, monthCalendarColours)
}

func getWeekEventsFromCalendarStore(reqWeek: Int, reqYear: Int, reqWeekOffset: Int, requestedCalendars: [EKCalendar]) -> ([[String]], [[CGColor]], [[String]]) {
    

    var dateComponent = DateComponents()
    dateComponent.weekOfYear = reqWeek
    dateComponent.year = reqYear
    dateComponent.weekday = 2 //this makes sure the date is reflecting Mondays month name
    
    var groupedEventsTitle = Array(repeating: [String](), count: 7)
    var groupedCalendarColours = Array(repeating: [CGColor](), count: 7)
    var groupedEventsTime = Array(repeating: [String](), count: 7)
    
    let userCalendar = Calendar(identifier: .iso8601)
    let calcDate = userCalendar.date(from: dateComponent)
    //print ("Monday is \(calcDate)")
    
    //let tempDate = Calendar.current.date(from: dateComponent)
    //let userCalendar = Calendar(identifier: .iso8601)
    //var tempDate = userCalendar.date(from: dateComponent)
    
   // print (" tem date is \(tempDate!)")
    
    let startDate = Calendar.current.date(byAdding: .day, value: (7*reqWeekOffset), to: calcDate!)!
    
    
    for n in 0...6
    {
        let tempDate = Calendar.current.date(byAdding: .day, value: n, to: startDate)!
        print (" temp date is n: \(n) - \(tempDate)")
        let requestedEventData = readEventsFromDateSimple(requestedDate:tempDate, requestedCalendars: requestedCalendars)
        
        groupedEventsTitle[n] = requestedEventData.titles
        groupedCalendarColours[n] = requestedEventData.calendarColor
        groupedEventsTime[n] = requestedEventData.time
    }
    
    return (groupedEventsTitle, groupedCalendarColours, groupedEventsTime)

    
}

func getCalendarName (calendarID: String) -> String {
    if eventAccessApproved
    {
        let calendarData = readUserCalendarData()
        let calendarNames = calendarData.name
        
        let calendarIDs = calendarData.id
        
        for x in 0..<calendarIDs.count
        {
            if calendarIDs[x] == calendarID {return  calendarNames[x]}
        }
    }
    return "ERROR - Could Not Retrieve Calendar Name!"
}


func getCalendarColour (calendarID: String) -> CGColor {
    let defaultColour = UIColor.black.cgColor
    if eventAccessApproved
    {
        let calendarData = readUserCalendarData()
        let calendarColor = calendarData.calendarColor
        
        for x in 0..<calendarIDs.count
        {
            let calendarColorTemp = calendarColor[x]
            if calendarIDs[x] == calendarID {return  (calendarColorTemp)}
        }
    }
    return defaultColour
}

func photoAlbumTypeName (type: PHAssetCollectionSubtype.RawValue) -> String {
    var temp: String = ""
    
    switch (type){
    case PHAssetCollectionSubtype.albumRegular.rawValue:
        temp = NSLocalizedString("An album created in the Photos app.", comment: "")
    
    case PHAssetCollectionSubtype.albumSyncedEvent.rawValue:
        temp = NSLocalizedString("An Event synced to the device from Photos app.", comment: "")
   
    case PHAssetCollectionSubtype.albumSyncedFaces.rawValue:
        temp = NSLocalizedString("A Faces group synced to the device from the Photos app", comment: "")
    
    case PHAssetCollectionSubtype.albumSyncedAlbum.rawValue:
        temp = NSLocalizedString("An album synced to the device from Photos app", comment: "")
    
    case PHAssetCollectionSubtype.albumImported.rawValue:
        temp = NSLocalizedString("An album imported from a camera or external storage", comment: "")
    
    case PHAssetCollectionSubtype.albumMyPhotoStream.rawValue:
        temp = NSLocalizedString("The user’s personal iCloud Photo Stream.", comment: "")
    
    case PHAssetCollectionSubtype.albumCloudShared.rawValue:
        temp = NSLocalizedString("An iCloud Shared Photo Stream", comment: "")
      
    default:
        temp = ""
    }
    return temp
}

func getAllPhotoAlbumTitles () -> (titles: Array<String>, albumID:Array<String>, albumType:Array<PHAssetCollectionSubtype>) {
    
    var photoAlbumTitles:[String] = []
    var photoAlbumID:[String] = []
    var photoAlbumTypes: [PHAssetCollectionSubtype] = []
    
    let albumListAll = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
    
    if photoAccessApproved{
        for i in 0..<albumListAll.count
        {
            let temp = albumListAll.object(at: i)
            photoAlbumTitles.append(temp.localizedTitle!)
            photoAlbumID.append(temp.localIdentifier)
            photoAlbumTypes.append(temp.assetCollectionSubtype)
        }
        
        photoAlbumTitles.append(NSLocalizedString("All Photos on the device", comment:"used in the photo Album list in Settings"))
        photoAlbumID.append(allPhotoAlbumCode)
        photoAlbumTypes.append(PHAssetCollectionSubtype(rawValue: PHAssetCollectionSubtype.smartAlbumAllHidden.rawValue)!)
       
    }
    return (titles: photoAlbumTitles, albumID: photoAlbumID, albumType:photoAlbumTypes)
}
