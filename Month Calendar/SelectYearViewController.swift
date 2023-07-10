//
//  SelectYearViewController.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 22/10/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

var tableValues = [String]()
var thisYear: Int = 2022
var nextYear: Int = 2023

class SelectYearViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var selectYearView: UIView!
    @IBOutlet var headerLbl: UILabel!
    @IBOutlet var yearTableView: UITableView?
    @IBOutlet var cancelEventBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "selectYearTableViewCell", bundle: nil)
        self.yearTableView!.register(nib, forCellReuseIdentifier: "selectYearTableViewCell")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        //updateCalendarTimer?.invalidate()
        //updateCalendarTimer = nil
        
        print ("Stop notification")
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        
        
        
        
        thisYear = Calendar.current.component(.year, from: Date())
        nextYear = thisYear + 1
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
        
        updateScreen()
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print ("TimerExpiredSegue")
        //closeScreen()
        performSegue(withIdentifier: "TimerExpiredSegue", sender: nil)
    }
    //END
    
    func dateTableValue (reqMonth:Int, reqYear: Int) -> String
    {
        var dateComponent = DateComponents()
        dateComponent.day = 1
        dateComponent.month = reqMonth
        dateComponent.year = reqYear
        let tempDate = Calendar.current.date(from: dateComponent)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM YYYY", options: 0, locale: Locale.current)
        return dateFormatter.string(from: tempDate!)
    }
    
    func updateScreen(){
        
        
        tableValues.removeAll()
        tableValues.append(NSLocalizedString("Previous Year", comment: ""))
        tableValues.append(NSLocalizedString("This Year", comment: ""))
        tableValues.append("\(nextYear)")
        tableValues.append("\(nextYear+1)")
        tableValues.append("\(nextYear+2)")
        tableValues.append("\(nextYear+3)")
        tableValues.append("\(nextYear+4)")
        
        headerLbl.textColor = mainTextColor
        headerLbl.text = NSLocalizedString("Select the Year", comment: "")
        
        yearTableView!.separatorColor = tableSeperatorColor
        yearTableView!.backgroundColor = windowColor
    
        selectYearView!.layer.shadowColor = UIColor.black.cgColor
        selectYearView!.layer.shadowOpacity = shadowOpacityView
        selectYearView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        selectYearView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        selectYearView?.backgroundColor    = windowColor
        selectYearView?.layer.cornerRadius = cornerRadiusWindow
        selectYearView?.layer.borderWidth  = borderWidthWindow
        selectYearView?.layer.borderColor  = borderColor.cgColor
        
        cancelEventBtn?.setImage(cancelPopupBtnImage, for: .normal)
        cancelEventBtn?.setImage(cancelPopupBtnPressedImage, for: .highlighted)
        
        cancelEventBtn!.layer.shadowColor = UIColor.black.cgColor
        cancelEventBtn!.layer.shadowOpacity = shadowOpacityButtons
        cancelEventBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        cancelEventBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = yearTableView!.dequeueReusableCell(withIdentifier: "selectYearTableViewCell", for: indexPath) as! selectYearTableViewCell
        cell.yearLbl.text = tableValues[indexPath.row]
        
        cell.yearLbl.textColor = mainTextColor
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none //do not show a selection color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ////userSelectedAlarm = indexPath.row
        
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = buttonPressedColor
        
        displayedDay = 1
        displayedMonth = Calendar.current.component(.month, from: Date())
        
        if indexPath.row == 0 {
            displayedYear = thisYear-1
        }
        
        if indexPath.row == 1 {
            displayedDay = Calendar.current.component(.day, from: Date())
            displayedYear = thisYear
        }
        
        if indexPath.row == 2 {
            displayedDay = 1
            displayedYear = nextYear
        }
        
        if indexPath.row == 3 {
            displayedDay = 1
            displayedYear = nextYear+1
        }
        
        if indexPath.row == 4 {
            displayedDay = 1
            displayedYear = nextYear+2
        }
        
        if indexPath.row == 5 {
            displayedDay = 1
            displayedYear = nextYear+3
        }
        
        if indexPath.row == 6 {
            displayedDay = 1
            displayedYear = nextYear+4
        }
        NotificationCenter.default.post(name: Notification.Name("updateMonthNotification"), object: nil, userInfo: ["key":"value"])
        closeScreen()
    }
    
    
    @IBAction func closeScreen(){
        self.dismiss(animated: true, completion: nil)
    }
}
