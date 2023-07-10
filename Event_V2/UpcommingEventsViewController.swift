//
//  UpcommingEventsViewController.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 7/6/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class UpcommingEventsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var topHeaderView: UIImageView!
    @IBOutlet var headerLbl: UILabel!
    @IBOutlet var calendarView: UIView!
    
    @IBOutlet var backgroundView: UIImageView?
    @IBOutlet var upcommingEventsTableView: UITableView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "upcommingEventTableViewCell", bundle: nil)
        self.upcommingEventsTableView!.register(nib, forCellReuseIdentifier: "upcommingEventTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    func updateScreen(){
     
        //topHeaderView?.image = topHeaderImage
        backgroundView?.image = backgroundImage
        headerLbl.textColor = mainTextColor
        headerLbl.text =  NSLocalizedString("Upcoming Events", comment: "")
        topHeaderView?.image = topHeaderImage
        
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    
        calendarView!.layer.shadowColor = UIColor.black.cgColor
        //calendarView!.layer.shadowColor = UIColor.clear.cgColor
        calendarView!.layer.shadowOpacity = shadowOpacityView
        calendarView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        calendarView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        calendarView?.backgroundColor    = windowColor
        //calendarView?.backgroundColor    = .clear
        calendarView?.layer.cornerRadius = cornerRadiusWindow
        calendarView?.layer.borderWidth  = borderWidthWindow
        calendarView?.layer.borderColor  = borderColor.cgColor
        upcommingEventsTableView?.separatorColor = tableSeperatorColor
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = buttonPressedColor
        eventStartDate = upcomingEventCache.startDateOfEvent[indexPath.row]
        screenSaverCounter = 0 //reset the timer.
        performSegue(withIdentifier: "CalendarEditSegue", sender: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        var rowsInSection: Int = 0
      
        rowsInSection = upcomingEventCache.name.count
        return rowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "upcommingEventTableViewCell", for: indexPath) as! upcommingEventTableViewCell
        cell1.eventNameLbl.text = upcomingEventCache.name[indexPath.row]
        cell1.eventDateLbl.text = upcomingEventCache.eventDate[indexPath.row]
        cell1.eventDaysLbl.text = upcomingEventCache.daysTillEvent[indexPath.row]
        
        
        cell1.eventColourIV.image = UIImage(named: "CellIDLargeImg")?.withRenderingMode(.alwaysTemplate)
        cell1.eventColourIV.tintColor = UIColor.init(cgColor: upcomingEventCache.calendarColour[indexPath.row])
        cell1.eventColourIV.contentMode = .center
        cell1.selectionStyle = .none //do not show a selection color
        cell1.backgroundColor = .clear
        cell1.contentView.backgroundColor = .clear
        
        if upcomingEventCache.eventIsToday[indexPath.row] {
            cell1.eventNameLbl.textColor = attentionTextColor
            cell1.eventDateLbl.textColor = subTextColor
            cell1.eventDaysLbl.textColor = attentionTextColor
            
            
            
            //cell1.cellBackground.layer.borderColor = attentionTextColor.cgColor
            //cell1.cellBackground.layer.borderWidth = 2
        }
        else {
            cell1.eventNameLbl.textColor = mainTextColor
            cell1.eventDateLbl.textColor = subTextColor
            cell1.eventDaysLbl.textColor = subTextColor
            //cell1.cellBackground.layer.borderColor = attentionTextColor.cgColor
            //cell1.cellBackground.layer.borderWidth = 0
        }
        
        
        
        return cell1
    }
    
    
    @objc func screenModeHasChanged()
        {
            print ("I updated the screen MODE")
            updateScreen()
            upcommingEventsTableView.reloadData()
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Reset screensaver else it migth start the moment you are scrolling
        screenSaverCounter = 0 //Reset the screen saver counter
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool) {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = true //start slideshow when in this viewcontroller
        upcommingEventsTableView.reloadData()
        
        //BEGIN - monitor if Calendar has been loaded in
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.screensaverRequested), name: Notification.Name("ScreensaverNotification"), object: nil)
        
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updatedEventCacheRequested), name: Notification.Name("updatedEventCacheNotification"), object: nil)
        updateScreen()

        DispatchQueue.main.async
        {
            updateUpcomingEventsArray ()
            self.upcommingEventsTableView.reloadData()
        }
        //END
        
        
        //END
    }
     
    @objc func updatedEventCacheRequested()
    {
        print ("@@ I received notifiction to upate the tableview")
        upcommingEventsTableView.reloadData()
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
