//
//  FamilyViewController.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 12/3/2023.
//  Copyright © 2023 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit

class FamilyViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var topHeaderView: UIImageView!
    @IBOutlet var headerLbl: UILabel!
    //@IBOutlet var calendarView: UIView!
    
    @IBOutlet var backgroundView: UIImageView?
    @IBOutlet var familyScrollView: UIScrollView?
    @IBOutlet var addCalendarBtn: UIButton?
    
    
    var requestedTitles : [String] = []
    var requestedCalendarColor: [CGColor] = []
    var requestedTime: [String] = []
    var updateCalendarTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonPressed(sender: UIButton)
    {
        screenSaverCounter = 0 //reset the timer.
        selectedDate = Calendar.current.date(byAdding: .day, value: sender.tag, to: Date())!
        
        eventStartDate = selectedDate
        performSegue(withIdentifier: "CalendarEditSegue", sender: nil)
    }
    
    
    func updateScreen(){
     
        //topHeaderView?.image = topHeaderImage
        
        backgroundView?.image = backgroundImage
        headerLbl.textColor = mainTextColor
        headerLbl.text =  NSLocalizedString("Calendar Overview", comment: "")
        topHeaderView?.image = topHeaderImage
        
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    
        
        
        //let familyCalenders = readUserCalendarData()
        
        //var familyCalendarArray: [EKCalendar] = []
        
        
        
        //let requestedEventData = readEventsFromDate(requestedDate:Date(), requestedCalendars: familyCalendar)
        //let calendarRows = requestedEventData.titles.count
        
        //var requestedTitles1 : [String] = []
        //var requestedCalendarColor1: [CGColor] = []
        
        
        //requestedTitles = requestedEventData.titles
        //requestedCalendarColor = requestedEventData.calendarColor
        
        
        let today = Date()
        let numberOfFutereDays = 7
        let cellWidth:Int = 250
        let cellBufferSpace:Int = 5
        let cellHeight: Int = 105
        
        let scrollViewX: Int = 5
        let scrollViewY: Int = 5
        let calenderViewY: Int = 65
        let calenderNameWidth: Int = 200
        //let calendarNameBufferWidth: Int = 10
        let dateLabelHeight: Int = 30
        let dateLabelBufferHeight: Int = 5
        var calendarCount = maxNumberOfFamilyCalenders
        
        //BEGIN - Remove all subviews, as this function is called more than once
        for v in familyScrollView!.subviews{
            v.removeFromSuperview()
        }
        
        for v in backgroundView!.subviews{
            v.removeFromSuperview()
        }
        //END
        
        
        //BEGIN - Set up headerview
        let tempView2 = createDateHeaderView (x: scrollViewX, y: scrollViewY, labelWidth: cellWidth+cellBufferSpace, height: dateLabelHeight, numberOfDays: numberOfFutereDays)
        familyScrollView!.addSubview(tempView2)
        //END
        
        
        
        //BEGIN - Set up vertical Calendar List
        
        if familyCalendarsSelected.count < maxNumberOfFamilyCalenders { calendarCount = familyCalendarsSelected.count}
            for x in 0..<calendarCount
        {
            let tempView2 = createCalendarNameView (x: scrollViewX, y: calenderViewY+dateLabelHeight+dateLabelBufferHeight+(x*(cellHeight+cellBufferSpace)), width: calenderNameWidth, height: cellHeight, calendarName: familyCalendarName[x], calendarColour: familyCalendarColor[x])
            backgroundView!.addSubview(tempView2)
        }
        //END
        
        //BEGIN - set up the week view for all selected Calendars
        for x in 0..<calendarCount
        {
            var singleCalendar: [EKCalendar] = []
            let tempCalendar = eventStore.calendar(withIdentifier: familyCalendarsSelected[x])
            singleCalendar.append(tempCalendar!)
            
            for dayCount in 0..<numberOfFutereDays
            {
                let modifiedDate = Calendar.current.date(byAdding: .day, value: dayCount, to: today)!
                
                let tempView = createFamilyDayView (x: scrollViewX+(dayCount*(cellWidth+cellBufferSpace)), y: scrollViewY+dateLabelHeight+dateLabelBufferHeight+(x*(cellHeight+cellBufferSpace)), width: cellWidth, height: cellHeight, selectedDate: modifiedDate, selectedCalendarID: familyCalendarsSelected[x])
                
                familyScrollView!.addSubview(tempView)
            }
        }
        familyScrollView!.contentSize.width = CGFloat(numberOfFutereDays * (cellWidth+cellBufferSpace))
        //familyScrollView!.contentSize.height = screenHeight-50-10-10
        //familyScrollView!.contentSize.height = 2000
        familyScrollView!.contentSize.height = screenHeight-50-10-10
        
        
        //END
    }
    
    
    
    
    
    
    @objc func screenModeHasChanged()
        {
            print ("I updated the screen MODE")
            updateScreen()
        }
    
    
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool) {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = true //start slideshow when in this viewcontroller
        
        
        //BEGIN - monitor if Calendar has been loaded in
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.screensaverRequested), name: Notification.Name("ScreensaverNotification"), object: nil)
        
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        if familyCalendarsSelected.count == 0 {
            addCalendarBtn?.isHidden = false
            addCalendarBtn?.setImage(addBtnImage, for: .normal)
            addCalendarBtn?.setImage(addPressedBtnImage, for: .highlighted)
            addCalendarBtn?.setTitle((NSLocalizedString("Add Calendar", comment: "")), for: .normal)
            addCalendarBtn?.setTitleColor(mainTextColor, for: .normal)
     
        }
        else
        {
            addCalendarBtn?.isHidden = true
        }
        if updateCalendarTimer == nil {
            updateCalendarTimer = Timer.scheduledTimer(timeInterval: calendarUpdateFrequency, target: self, selector: #selector(self.refreshCalendar), userInfo: nil, repeats: true)
        }
        
        updateScreen()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        updateCalendarTimer?.invalidate()
        updateCalendarTimer = nil
        NotificationCenter.default.removeObserver(self)
    }
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print ("TimerExpiredSegue")
        performSegue(withIdentifier: "TimerExpiredSegue", sender: nil)
    }
    //END
    
    @IBAction func closeBtn(_ sender: Any) {
        print ("Close the View")
        self.dismiss(animated: true, completion: nil)
    }
    
    func createDateHeaderView (x: Int, y: Int, labelWidth: Int, height: Int, numberOfDays: Int) -> UIView
    {
        
        let myView = UIView(frame: CGRect(x: x, y: y, width: (labelWidth*numberOfDays), height: height))
        
        //myView.layer.shadowColor = UIColor.black.cgColor
        //myView.layer.shadowOpacity = shadowOpacityView
        //myView.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        //myView.layer.shadowRadius = CGFloat(shadowRadiusView)
        myView.backgroundColor    = .clear
        //myView.layer.cornerRadius = subWindowborderRadius
        myView.layer.cornerRadius = 0
        
        //myView.layer.borderWidth  = borderWidthWindow
        //myView.layer.borderColor  = borderColor.cgColor
        
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "eeee", options: 0, locale: Locale.current)
        
        
        for n in 0..<numberOfDays{
            let dayLbl = UILabel(frame: CGRect(x: (n*labelWidth), y: 0, width: labelWidth, height: height))
            dayLbl.font = UIFont.systemFont(ofSize: 25.0)
            dayLbl.backgroundColor = .clear
            dayLbl.lineBreakMode = .byTruncatingTail
            dayLbl.textAlignment = .center
            //dayLbl.backgroundColor = .red
            dayLbl.textColor = mainTextColor
            let tempDate = Calendar.current.date(byAdding: .day, value: n, to: today)
            dayLbl.text = dateFormatter.string(from: tempDate!)
            if n == 0 { dayLbl.text = NSLocalizedString("Today", comment: "")}
            if n == 1 { dayLbl.text = NSLocalizedString("Tomorrow", comment: "")}
            myView.addSubview(dayLbl)
        }
        return myView
    }
    
    func createCalendarNameView (x: Int, y: Int, width: Int, height: Int, calendarName: String, calendarColour: CGColor) -> UIView
    {
        
        
        let calenderBarWidth = 10
        let myView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        //myView.layer.shadowColor = UIColor.black.cgColor
        //myView.layer.shadowOpacity = shadowOpacityView
        //myView.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        //myView.layer.shadowRadius = CGFloat(shadowRadiusView)
        myView.backgroundColor    = windowColor
        //myView.layer.cornerRadius = subWindowborderRadius
        myView.layer.cornerRadius = 0
        
        myView.layer.borderWidth  = borderWidthWindow
        myView.layer.borderColor  = borderColor.cgColor
        
        let calendarColourMarker = UIView(frame: CGRect(x: 0, y: 0, width: calenderBarWidth, height: height))
        calendarColourMarker.backgroundColor = UIColor(cgColor: calendarColour)
        //calendarColourMarker.layer.cornerRadius = subWindowborderRadius
        calendarColourMarker.layer.cornerRadius = 0
        calendarColourMarker.layer.borderWidth  = borderWidthWindow
        
        calendarColourMarker.layer.borderColor  = borderColor.cgColor
        myView.addSubview(calendarColourMarker)
        
        
        let label = UILabel(frame: CGRect(x: calenderBarWidth+5, y: 0, width: width-calenderBarWidth-5-5, height: height))
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.backgroundColor = .clear
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.textColor = mainTextColor
        label.text = calendarName
        myView.addSubview(label)
        return myView
    }
    
    func createFamilyDayView (x: Int, y: Int, width: Int, height: Int, selectedDate: Date, selectedCalendarID: String) -> UIView
    {
        var singleCalendar: [EKCalendar] = []
        let tempCalendar = eventStore.calendar(withIdentifier: selectedCalendarID)
        singleCalendar.append(tempCalendar!)
        
        let requestedEventData = readEventsFromDate(requestedDate:selectedDate, requestedCalendars: singleCalendar)
            
        let requestedEvents = requestedEventData.titles
        let requestedCalendarColour = requestedEventData.calendarColor
        let requestedEventAllDay = requestedEventData.AllDayEvent
        let requestedEventStart  = requestedEventData.startTime
        let requestedEventStop   = requestedEventData.endTime
        
        
        
        var calendarRows = requestedEvents.count
        
        var moreEventsThanCanBeShownInCell = false
        let maxRow = 5
        if calendarRows > (maxRow) {
            moreEventsThanCanBeShownInCell = true
            calendarRows = maxRow
        }
        
        if calendarRows > 6 {calendarRows = 6} // Max 6 calendar events
        let textspacing = 20 //25
        let textStartPostitionY = 0
        //let timeLabelWidth = 70
        let myView = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        //myView.layer.shadowColor = UIColor.black.cgColor
        //myView.layer.shadowOpacity = shadowOpacityView
        //myView.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        //myView.layer.shadowRadius = CGFloat(shadowRadiusView)
        myView.backgroundColor    = windowColor
        var textColour = mainTextColor
        if colouredFamilyCalendar
        {
            if requestedCalendarColour.count != 0 {
                let backgroundColour = UIColor.init(cgColor: requestedCalendarColour[0])
                myView.backgroundColor = backgroundColour
                if backgroundColour.isDarkColor {
                    textColour = backgroundColour.lighter()
                }
                else {
                    textColour = backgroundColour.darker()
                }
            }
        }
        
        
        //myView.layer.cornerRadius = subWindowborderRadius
        myView.layer.cornerRadius = 0
        
        myView.layer.borderWidth  = borderWidthWindow
        myView.layer.borderColor  = borderColor.cgColor
        
        
        let myButton = UIButton()
        
        myButton.setTitle("", for: .normal)
        myButton.setTitleColor(.blue, for: .normal)
        
        let numberOfdays = daysBetweenDates(endDate: selectedDate)
        myButton.tag = numberOfdays
        
        myButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        myButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        myView.addSubview(myButton)
        
        myView.layer.borderWidth  = borderWidthWindow
        myView.layer.borderColor  = borderColor.cgColor
        
        //myView.addSubview(label)
        let timeLabelWidth = 45
        
        if calendarRows != 0
        {
            for row in 0...calendarRows-1
            {
                //BEGIN - Show coloured boxes
                if (colouredFamilyCalendar)
                {
                    if requestedEventAllDay[row]
                    {
                        if row == maxRow-1 && moreEventsThanCanBeShownInCell
                        {
                            let label = UILabel(frame: CGRect(x: 5, y: (textStartPostitionY+(row * textspacing)), width: width-5, height: 25))
                            label.font = UIFont.systemFont(ofSize: 15.0)
                            label.backgroundColor = .clear
                            label.lineBreakMode = .byTruncatingTail
                            label.textAlignment = .left
                            label.textColor = textColour
                            label.text = NSLocalizedString("More Events", comment: "")
                            myView.addSubview(label)
                        }
                        else
                        {
                            let label = UILabel(frame: CGRect(x: 5, y: (textStartPostitionY+(row * textspacing)), width: width-5, height: 25))
                            label.font = UIFont.systemFont(ofSize: 15.0)
                            label.backgroundColor = .clear
                            
                            label.lineBreakMode = .byTruncatingTail
                            label.textAlignment = .left
                            label.textColor = textColour
                            label.text = requestedEvents[row]
                            myView.addSubview(label)
                        }
                    }
                    else
                    {
                        if row == maxRow-1 && moreEventsThanCanBeShownInCell
                        {
                            let label = UILabel(frame: CGRect(x: 5, y: (textStartPostitionY+(row * textspacing)), width: width-5, height: 25))
                            label.font = UIFont.systemFont(ofSize: 15.0)
                            label.backgroundColor = .clear
                            label.lineBreakMode = .byTruncatingTail
                            label.textAlignment = .left
                            label.textColor = textColour
                            label.text = NSLocalizedString("More Events", comment: "")
                            myView.addSubview(label)
                        }
                        else
                        {
                            if (Calendar.current.isDate(requestedEventStart[row] as Date, inSameDayAs:requestedEventStop[row] as Date))
                            {
                                if requestedEventAllDay[row]
                                {
                                    let label = UILabel(frame: CGRect(x: 5, y: (textStartPostitionY+(row * textspacing)), width: width-5, height: 25))
                                    label.font = UIFont.systemFont(ofSize: 15.0)
                                    label.backgroundColor = .clear
                                    
                                    label.lineBreakMode = .byTruncatingTail
                                    label.textAlignment = .left
                                    label.textColor = textColour
                                    label.text = requestedEvents[row]
                                    myView.addSubview(label)
                                }
                                else
                                {
                                    let label = UILabel(frame: CGRect(x: 5, y: (textStartPostitionY+(row * textspacing)), width: width-timeLabelWidth-5-5-5, height: 25))
                                    label.font = UIFont.systemFont(ofSize: 15.0)
                                    label.backgroundColor = .clear
                                    
                                    label.lineBreakMode = .byTruncatingTail
                                    label.textAlignment = .left
                                    label.textColor = textColour
                                    label.text = requestedEvents[row]
                                    myView.addSubview(label)
                                    
                                    let timeLbl = UILabel(frame: CGRect(x: width-timeLabelWidth-5, y: (textStartPostitionY+(row * textspacing)), width: timeLabelWidth, height: 25))
                                    
                                    timeLbl.font = UIFont.systemFont(ofSize: 15.0)
                                    timeLbl.backgroundColor = .clear
                                    timeLbl.lineBreakMode = .byClipping
                                    timeLbl.textAlignment = .right
                                    timeLbl.textColor = textColour
                                    
                                    //Today with Start time
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "h:mm"
                                    timeLbl.text = ("\(dateFormatter.string(from: requestedEventStart[row] as Date))")//timeLbl.text = ("23:23")
                                    myView.addSubview(timeLbl)
                                }
                            }
                            else
                            {
                                let label = UILabel(frame: CGRect(x: 5, y: (textStartPostitionY+(row * textspacing)), width: width-5, height: 25))
                                label.font = UIFont.systemFont(ofSize: 15.0)
                                label.backgroundColor = .clear
                                
                                label.lineBreakMode = .byTruncatingTail
                                label.textAlignment = .left
                                label.textColor = textColour
                                label.text = requestedEvents[row]
                                myView.addSubview(label)
                            }
                            
                        }
                        
                    }
                }
                else // CLASSIC THEME
                {
                    if requestedEventAllDay[row]
                    {
                        if row == maxRow-1 && moreEventsThanCanBeShownInCell
                        {
                            let label = UILabel(frame: CGRect(x: 14, y: (textStartPostitionY+(row * textspacing)), width: width-14, height: 25))
                            label.font = UIFont.systemFont(ofSize: 15.0)
                            label.backgroundColor = .clear
                            label.lineBreakMode = .byTruncatingTail
                            label.textAlignment = .left
                            label.textColor = textColour
                            label.text = NSLocalizedString("More Events", comment: "")
                            myView.addSubview(label)
                        }
                        else
                        {
                            let imageView = UIImageView(frame: CGRect(x: 5, y: (textStartPostitionY+(row * textspacing)), width: 4, height: 25))
                            imageView.image = UIImage(named: "CellIDImg_S")?.withRenderingMode(.alwaysTemplate)
                            
                            imageView.tintColor = UIColor.init(cgColor: requestedCalendarColour[row])
                            
                            imageView.contentMode = .center
                            myView.addSubview(imageView)
                            
                            let label = UILabel(frame: CGRect(x: 14, y: (textStartPostitionY+(row * textspacing)), width: width-14-5, height: 25))
                            
                            label.font = UIFont.systemFont(ofSize: 15.0)
                            label.backgroundColor = .clear
                            
                            label.lineBreakMode = .byTruncatingTail
                            label.textAlignment = .left
                            label.textColor = textColour
                            
                            label.text = requestedEvents[row]
                            myView.addSubview(label)
                        }
                    }
                    else
                    {
                        if row == maxRow-1 && moreEventsThanCanBeShownInCell
                        {
                            let label = UILabel(frame: CGRect(x: 14, y: (textStartPostitionY+(row * textspacing)), width: width-14, height: 25))
                            label.font = UIFont.systemFont(ofSize: 15.0)
                            label.backgroundColor = .clear
                            label.lineBreakMode = .byTruncatingTail
                            label.textAlignment = .left
                            label.textColor = textColour
                            label.text = NSLocalizedString("More Events", comment: "")
                            myView.addSubview(label)
                        }
                        else
                        {
                            let imageView = UIImageView(frame: CGRect(x: 5, y: (textStartPostitionY+(row * textspacing)), width: 4, height: 25))
                            imageView.image = UIImage(named: "CellIDImg_S")?.withRenderingMode(.alwaysTemplate)
                            
                            imageView.tintColor = UIColor.init(cgColor: requestedCalendarColour[row])
                            
                            imageView.contentMode = .center
                            myView.addSubview(imageView)
                            
                            
                            if (Calendar.current.isDate(requestedEventStart[row] as Date, inSameDayAs:requestedEventStop[row] as Date))
                            {
                                if requestedEventAllDay[row]
                                {
                                    let label = UILabel(frame: CGRect(x: 14, y: (textStartPostitionY+(row * textspacing)), width: width-14-5, height: 25))
                                    
                                    label.font = UIFont.systemFont(ofSize: 15.0)
                                    label.backgroundColor = .clear
                                    //label.backgroundColor = .green
                                    
                                    label.lineBreakMode = .byTruncatingTail
                                    label.textAlignment = .left
                                    label.textColor = textColour
                                    
                                    label.text = requestedEvents[row]
                                    myView.addSubview(label)
                                }
                                else
                                {
                                    //Today with Start time
                                    let label = UILabel(frame: CGRect(x: 14, y: (textStartPostitionY+(row * textspacing)), width: width-14-timeLabelWidth-5-5, height: 25))
                                    
                                    label.font = UIFont.systemFont(ofSize: 15.0)
                                    label.backgroundColor = .clear
                                    //label.backgroundColor = .green
                                    
                                    label.lineBreakMode = .byTruncatingTail
                                    label.textAlignment = .left
                                    label.textColor = textColour
                                    
                                    label.text = requestedEvents[row]
                                    myView.addSubview(label)
                                    
                                    let timeLbl = UILabel(frame: CGRect(x: width-timeLabelWidth-5, y: (textStartPostitionY+(row * textspacing)), width: timeLabelWidth, height: 25))
                                    
                                    timeLbl.font = UIFont.systemFont(ofSize: 15.0)
                                    timeLbl.backgroundColor = .clear
                                    //timeLbl.backgroundColor = .blue
                                    
                                    timeLbl.lineBreakMode = .byClipping
                                    timeLbl.textAlignment = .right
                                    
                                    timeLbl.textColor = textColour
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "h:mm"
                                    timeLbl.text = ("\(dateFormatter.string(from: requestedEventStart[row] as Date))")//timeLbl.text = ("23:23")
                                    myView.addSubview(timeLbl)
                                }
                            }
                            else
                            {
                                //Multiple days
                                let label = UILabel(frame: CGRect(x: 14, y: (textStartPostitionY+(row * textspacing)), width: width-14-5, height: 25))
                                
                                label.font = UIFont.systemFont(ofSize: 15.0)
                                label.backgroundColor = .clear
                                //label.backgroundColor = .green
                                
                                label.lineBreakMode = .byTruncatingTail
                                label.textAlignment = .left
                                label.textColor = textColour
                                
                                label.text = requestedEvents[row]
                                myView.addSubview(label)
                            }
                           
                        }
                    }
                }
            }
        }
            return myView
        }
    @objc func refreshCalendar()
    {
        print ("I updated the Calendar, so you should see the new entry")
        updateScreen()
    }



}
