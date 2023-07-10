//
//  SearchViewController.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 20/6/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

var numberOfsearchResults: Int = 0
var searchResults = UpcomingEvent()
let maxNumberOfSearchResults = 10
let maxNumberOfDaysToSearch:Double = 365*24*3600

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var topHeaderView: UIImageView!
    @IBOutlet var headerLbl: UILabel!
    @IBOutlet var searchView: UIView!
    
    @IBOutlet var backgroundView: UIImageView?
    @IBOutlet var eventName: UITextField?
    @IBOutlet var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        let nib = UINib.init(nibName: "searchTableViewCell", bundle: nil)
        self.searchTableView!.register(nib, forCellReuseIdentifier: "searchTableViewCell")
        updateScreen()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = buttonPressedColor
        eventStartDate = searchResults.startDateOfEvent[indexPath.row]
        screenSaverCounter = 0 //reset the timer.
        performSegue(withIdentifier: "CalendarEditSegue", sender: nil)
    }
    @objc func screenModeHasChanged()
        {
            print ("I updated the screen MODE")
            updateScreen()
            searchTableView.reloadData()
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
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop notification")
        NotificationCenter.default.removeObserver(self)
    }
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print ("TimerExpiredSegue")
        performSegue(withIdentifier: "TimerExpiredSegue", sender: nil)
    }
    //END
    override func viewWillAppear(_ animated: Bool) {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //start slideshow when in this viewcontroller
        //BEGIN - get access so yuo speed up, by not asking for it all the time
        numberOfsearchResults = 0
        eventAccessApproved = EventStoreAuthorizations()
        
        eventName!.layer.borderWidth = textfieldBorderWidthHighlight
        eventName!.layer.cornerRadius = textfieldRadius
        eventName!.layer.borderColor = attentionTextColor.cgColor
        
        //END
        
        //BEGIN - monitor if Calendar has been loaded in
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.screensaverRequested), name: Notification.Name("ScreensaverNotification"), object: nil)
        
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
         //END
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numberOfsearchResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! searchTableViewCell
        cell1.eventNameLbl.text = searchResults.name[indexPath.row]
        cell1.eventDateLbl.text = searchResults.eventDate[indexPath.row]
        cell1.eventDaysLbl.text = searchResults.daysTillEvent[indexPath.row]
        
        cell1.eventColourIV.image = UIImage(named: "CellIDLargeImg")?.withRenderingMode(.alwaysTemplate)
        cell1.eventColourIV.tintColor = UIColor.init(cgColor: searchResults.calendarColour[indexPath.row])
        cell1.eventColourIV.contentMode = .center
        
        cell1.eventNameLbl.textColor = mainTextColor
        cell1.eventDateLbl.textColor = subTextColor
        cell1.eventDaysLbl.textColor = subTextColor
        cell1.selectionStyle = .none //do not show a selection color
        cell1.backgroundColor = .clear
        cell1.contentView.backgroundColor = .clear
        
        return cell1
    }
    
    
    @IBAction func closeBtn(_ sender: Any) {
        print ("Close the View")
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateScreen(){
     
        //topHeaderView?.image = topHeaderImage
        backgroundView?.image = backgroundImage
        headerLbl.textColor = mainTextColor
        headerLbl.text =  NSLocalizedString("Search", comment: "")
        topHeaderView?.image = topHeaderImage
        
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    
        searchView!.layer.shadowColor = UIColor.black.cgColor
        //calendarView!.layer.shadowColor = UIColor.clear.cgColor
        searchView!.layer.shadowOpacity = shadowOpacityView
        searchView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        searchView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        searchView?.backgroundColor    = windowColor
        //calendarView?.backgroundColor    = .clear
        searchView?.layer.cornerRadius = cornerRadiusWindow
        searchView?.layer.borderWidth  = borderWidthWindow
        searchView?.layer.borderColor  = borderColor.cgColor
        
        calendarEventNameString = "" //on return the text box is empty again, else previous value is displayed
        eventName!.layer.borderWidth  = 1
        eventName!.layer.borderColor = subTextColor.cgColor
        eventName!.backgroundColor = windowColor
        eventName?.attributedPlaceholder = NSAttributedString(string: (NSLocalizedString("Type atleast 3 characters to search for the event!", comment: "")), attributes: [NSAttributedString.Key.foregroundColor : subTextColor])
        eventName!.textColor = mainTextColor
        
        searchTableView?.separatorColor = tableSeperatorColor
        
        if (dayMode == true){
            eventName!.keyboardAppearance = UIKeyboardAppearance.light
        }
        else {
            eventName!.keyboardAppearance = UIKeyboardAppearance.dark
        }
    }

    @IBAction func updateEventName(_ sender: Any) {
        //print ("Update Event Namew")
        print ("text input ")
        
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
        if eventName!.text!.count > 2 //Only do a search if there are more than 2 characters input, to prevent a slow delay
        {
            DispatchQueue.main.async
            {
                self.updateSearchResults (searchString: self.eventName!.text!)
                self.searchTableView.reloadData()
            }
        }
        else
        {
            numberOfsearchResults = 0
            self.searchTableView.reloadData() // this is needed incase user deletes the search string,it would else stil display old results
        }
    }
    
    
  
    
    
    
    
    @IBAction func closeKeyboard(_ sender: Any) {
        print ("Close the shortcut View")
        //DEBUG
        
    }

    func firstCharacterUpperCase(input: String) -> String {
            if input.count == 0 { return input }
        return input.prefix(1).uppercased() + input.dropFirst().lowercased()
        }
    
    func updateSearchResults (searchString: String) {
        //BEGIN - Create Array with upcoming event, this saves time do this here, than process when table is updated
        searchResults.name.removeAll()
        searchResults.eventDate.removeAll()
        searchResults.daysTillEvent.removeAll()
        searchResults.eventIsToday.removeAll()
        searchResults.calendarColour.removeAll()
        searchResults.startDateOfEvent.removeAll()
        
        if eventAccessApproved {
        let now = NSDate()
        let futureDate = NSDate(timeIntervalSinceNow: maxNumberOfDaysToSearch) //only fetch 365 days of events
        
        let predicate = eventStore.predicateForEvents(withStart: now as Date, end: futureDate as Date, calendars: nil)
        let tempString = firstCharacterUpperCase(input:searchString)
        let tempString1 = searchString.lowercased()
        //add capitalise and lowercased strings together so, they can be displayed
        let events = eventStore.events(matching: predicate).filter({ $0.title.contains(tempString) || $0.title.contains(tempString1)})
        //let events = eventStore.events(matching: predicate).filter({ $0.title.contains(tempString) })
              
        numberOfsearchResults = events.count
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "EEddMMM", options: 0, locale: Locale.current)
           
        //BEGIN - Only display a limit number of calendar events
        if (numberOfsearchResults > maxNumberOfSearchResults) {
            numberOfsearchResults = maxNumberOfSearchResults}
        var daysBeforeEvent: Int = 0
        for event in events
        {
           daysBeforeEvent = daysBetweenDates (endDate: event.startDate as Date)
            searchResults.name.append(event.title)
            searchResults.calendarColour.append(event.calendar.cgColor)
            
            searchResults.eventDate.append("\(dateFormatter.string(from: event.startDate as Date))")
            searchResults.startDateOfEvent.append(event.startDate as Date)
            
            if daysBeforeEvent == 0 {
                searchResults.daysTillEvent.append(NSLocalizedString("Today", comment: ""))
                searchResults.eventIsToday.append(true)
            }
            
            if daysBeforeEvent == 1 {
                searchResults.daysTillEvent.append("\(daysBeforeEvent) \(NSLocalizedString("day", comment: ""))")
                searchResults.eventIsToday.append(false)
            }
            
            if daysBeforeEvent > 1 {
                searchResults.daysTillEvent.append("\(daysBeforeEvent) \(NSLocalizedString("days", comment: ""))")
                searchResults.eventIsToday.append(false)
            }
            
            if daysBeforeEvent < 0 {
                searchResults.daysTillEvent.append("\(NSLocalizedString("started", comment: ""))")
                searchResults.eventIsToday.append(true)
            }
        }//END
    }
    }
}
