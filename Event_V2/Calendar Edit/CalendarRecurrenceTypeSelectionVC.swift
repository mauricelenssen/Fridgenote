//
//  CalendarRecurrenceTypeSelectionVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 25/5/21.
//  Copyright © 2021 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit
//var userSelelctedRecurrenceSelection:Int = 0
var numberOfCustomDaysToRepeat: Int = 1
var numberOfWeeksToRepeat: Int = 1
var numberOfMonthsToRepeat: Int = 1
var numberOfYearsToRepeat: Int = 1
var recurrenceSelected: Bool = false
var weekDaySelected:[Bool] = [false,false,false,false,false,false,false]
var monthDaySelected:[Bool] = [false,false,false,false,false,false,false,
                               false,false,false,false,false,false,false,
                               false,false,false,false,false,false,false,
                               false,false,false,false,false,false,false,
                               false,false,false,false]

//var monthEachDaySelection: Bool = false

var yearMonthSelected:[Bool] = [false,false,false,false,
                                false,false,false,false,
                                false,false,false,false,]
//Month selection
var onTheSelection: Bool = true
var eachSelection: Bool = false

//Year selection
var eachYearSelection: Bool = false

var weekDayLabels: [String] = [(NSLocalizedString("sunday", comment: "")),(NSLocalizedString("monday", comment: "")), (NSLocalizedString("tuesday", comment: "")), (NSLocalizedString("wednesday", comment: "")), (NSLocalizedString("thursday", comment: "")), (NSLocalizedString("friday", comment: "")), (NSLocalizedString("saturday", comment: "")),(NSLocalizedString("weekday", comment: "")),(NSLocalizedString("weekend", comment: ""))]
var weekDayLabelsSelected: [Bool]     = [true,false,false,false,false,false,false,false,false]
var weekDayYearLabelsSelected: [Bool] = [true,false,false,false,false,false,false,false,false]

var wichPartOfTheWeekDayLabels: [String] = [(NSLocalizedString("first", comment: "")),(NSLocalizedString("second", comment: "")), (NSLocalizedString("third", comment: "")), (NSLocalizedString("fourth", comment: "")), (NSLocalizedString("fifth", comment: "")), (NSLocalizedString("last", comment: ""))]
var wichPartOfTheWeekDayLabelsSelected: [Bool] = [true,false,false,false,false,false]

var wichPartOfTheWeekDayYearLabels: [String] = [(NSLocalizedString("first", comment: "")),(NSLocalizedString("second", comment: "")), (NSLocalizedString("third", comment: "")), (NSLocalizedString("fourth", comment: "")), (NSLocalizedString("fifth", comment: "")), (NSLocalizedString("last", comment: ""))]
var wichPartOfTheWeekDayYearLabelsSelected: [Bool] = [true,false,false,false,false,false]



class CalendarRecurrenceTypeSelectionVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
   
    
    @IBOutlet var popupView: UIView!
    
    //@IBOutlet var closeBtn: UIButton!
    @IBOutlet var headerLbl: UILabel!
   
    
    @IBOutlet var customRepeatLbl: UILabel!
    @IBOutlet var customReccurenceView: UIView!
    @IBOutlet weak var recurrenceSC: UISegmentedControl!
    
    //No Repeat View
    @IBOutlet weak var noRepeatView: UIView!
    @IBOutlet weak var noRepeatLbl: UILabel!
    
    //Daily Custom View
    @IBOutlet weak var dailyView: UIView!
    @IBOutlet weak var day1Lbl: UILabel!
    @IBOutlet weak var upDayBtn: UIButton!
    @IBOutlet weak var downDayBtn: UIButton!
    
    //Weekly Custom View
    @IBOutlet weak var weeklyView: UIView!
    
    @IBOutlet weak var day1View: UIView!
    @IBOutlet weak var day2View: UIView!
    @IBOutlet weak var day3View: UIView!
    @IBOutlet weak var day4View: UIView!
    @IBOutlet weak var day5View: UIView!
    @IBOutlet weak var day6View: UIView!
    @IBOutlet weak var day7View: UIView!
        
    @IBOutlet weak var day1Btn: UIButton!
    @IBOutlet weak var day2Btn: UIButton!
    @IBOutlet weak var day3Btn: UIButton!
    @IBOutlet weak var day4Btn: UIButton!
    @IBOutlet weak var day5Btn: UIButton!
    @IBOutlet weak var day6Btn: UIButton!
    @IBOutlet weak var day7Btn: UIButton!
    
    @IBOutlet weak var day1IV: UIImageView!
    @IBOutlet weak var day2IV: UIImageView!
    @IBOutlet weak var day3IV: UIImageView!
    @IBOutlet weak var day4IV: UIImageView!
    @IBOutlet weak var day5IV: UIImageView!
    @IBOutlet weak var day6IV: UIImageView!
    @IBOutlet weak var day7IV: UIImageView!
    
    @IBOutlet weak var upWeekBtn: UIButton!
    @IBOutlet weak var downWeekBtn: UIButton!
    @IBOutlet weak var week1Lbl: UILabel!
    
    //Monthly Custom View
    @IBOutlet weak var monthlyView: UIView!
    @IBOutlet weak var upMonthBtn: UIButton!
    @IBOutlet weak var downMonthBtn: UIButton!
    @IBOutlet weak var month1Lbl: UILabel!
    
    @IBOutlet weak var monthDay1IV: UIImageView!
    @IBOutlet weak var monthDay2IV: UIImageView!
    @IBOutlet weak var monthDay3IV: UIImageView!
    @IBOutlet weak var monthDay4IV: UIImageView!
    @IBOutlet weak var monthDay5IV: UIImageView!
    @IBOutlet weak var monthDay6IV: UIImageView!
    @IBOutlet weak var monthDay7IV: UIImageView!
    @IBOutlet weak var monthDay8IV: UIImageView!
    @IBOutlet weak var monthDay9IV: UIImageView!
    @IBOutlet weak var monthDay10IV: UIImageView!
    @IBOutlet weak var monthDay11IV: UIImageView!
    @IBOutlet weak var monthDay12IV: UIImageView!
    @IBOutlet weak var monthDay13IV: UIImageView!
    @IBOutlet weak var monthDay14IV: UIImageView!
    @IBOutlet weak var monthDay15IV: UIImageView!
    @IBOutlet weak var monthDay16IV: UIImageView!
    @IBOutlet weak var monthDay17IV: UIImageView!
    @IBOutlet weak var monthDay18IV: UIImageView!
    @IBOutlet weak var monthDay19IV: UIImageView!
    @IBOutlet weak var monthDay20IV: UIImageView!
    @IBOutlet weak var monthDay21IV: UIImageView!
    @IBOutlet weak var monthDay22IV: UIImageView!
    @IBOutlet weak var monthDay23IV: UIImageView!
    @IBOutlet weak var monthDay24IV: UIImageView!
    @IBOutlet weak var monthDay25IV: UIImageView!
    @IBOutlet weak var monthDay26IV: UIImageView!
    @IBOutlet weak var monthDay27IV: UIImageView!
    @IBOutlet weak var monthDay28IV: UIImageView!
    @IBOutlet weak var monthDay29IV: UIImageView!
    @IBOutlet weak var monthDay30IV: UIImageView!
    @IBOutlet weak var monthDay31IV: UIImageView!
    @IBOutlet weak var monthDayLIV: UIImageView!
    
    @IBOutlet weak var monthDay1Btn: UIButton!
    @IBOutlet weak var monthDay2Btn: UIButton!
    @IBOutlet weak var monthDay3Btn: UIButton!
    @IBOutlet weak var monthDay4Btn: UIButton!
    @IBOutlet weak var monthDay5Btn: UIButton!
    @IBOutlet weak var monthDay6Btn: UIButton!
    @IBOutlet weak var monthDay7Btn: UIButton!
    @IBOutlet weak var monthDay8Btn: UIButton!
    @IBOutlet weak var monthDay9Btn: UIButton!
    @IBOutlet weak var monthDay10Btn: UIButton!
    @IBOutlet weak var monthDay11Btn: UIButton!
    @IBOutlet weak var monthDay12Btn: UIButton!
    @IBOutlet weak var monthDay13Btn: UIButton!
    @IBOutlet weak var monthDay14Btn: UIButton!
    @IBOutlet weak var monthDay15Btn: UIButton!
    @IBOutlet weak var monthDay16Btn: UIButton!
    @IBOutlet weak var monthDay17Btn: UIButton!
    @IBOutlet weak var monthDay18Btn: UIButton!
    @IBOutlet weak var monthDay19Btn: UIButton!
    @IBOutlet weak var monthDay20Btn: UIButton!
    @IBOutlet weak var monthDay21Btn: UIButton!
    @IBOutlet weak var monthDay22Btn: UIButton!
    @IBOutlet weak var monthDay23Btn: UIButton!
    @IBOutlet weak var monthDay24Btn: UIButton!
    @IBOutlet weak var monthDay25Btn: UIButton!
    @IBOutlet weak var monthDay26Btn: UIButton!
    @IBOutlet weak var monthDay27Btn: UIButton!
    @IBOutlet weak var monthDay28Btn: UIButton!
    @IBOutlet weak var monthDay29Btn: UIButton!
    @IBOutlet weak var monthDay30Btn: UIButton!
    @IBOutlet weak var monthDay31Btn: UIButton!
    @IBOutlet weak var monthDayLBtn: UIButton!
    
    @IBOutlet weak var onTheBtn: UIButton!
    @IBOutlet weak var eachBtn: UIButton!
    @IBOutlet weak var onTheLbl: UILabel!
    @IBOutlet weak var eachLbl: UILabel!
    @IBOutlet weak var onTheSelectionImg: UIImageView!
    @IBOutlet weak var eachSelectionImg: UIImageView!
    
    @IBOutlet weak var monthDaySV: UIStackView!
    @IBOutlet weak var eachDayView: UIView!
    
    
    @IBOutlet weak var onTheDayMonthView: UIView!
    
    @IBOutlet weak var weekDayRepeatTB: UITableView!
    @IBOutlet weak var whichWeekDayRepeatTB: UITableView!
    
    //Yearly Custom View
    @IBOutlet weak var yearlyView: UIView!
    @IBOutlet weak var eachYearView: UIView!
    @IBOutlet weak var upYearBtn: UIButton!
    @IBOutlet weak var downYearBtn: UIButton!
    @IBOutlet weak var yearLbl: UILabel!
    
    @IBOutlet weak var yearMonth1Btn: UIButton!
    @IBOutlet weak var yearMonth2Btn: UIButton!
    @IBOutlet weak var yearMonth3Btn: UIButton!
    @IBOutlet weak var yearMonth4Btn: UIButton!
    @IBOutlet weak var yearMonth5Btn: UIButton!
    @IBOutlet weak var yearMonth6Btn: UIButton!
    @IBOutlet weak var yearMonth7Btn: UIButton!
    @IBOutlet weak var yearMonth8Btn: UIButton!
    @IBOutlet weak var yearMonth9Btn: UIButton!
    @IBOutlet weak var yearMonth10Btn: UIButton!
    @IBOutlet weak var yearMonth11Btn: UIButton!
    @IBOutlet weak var yearMonth12Btn: UIButton!
    
    @IBOutlet weak var yearMonth1IV: UIImageView!
    @IBOutlet weak var yearMonth2IV: UIImageView!
    @IBOutlet weak var yearMonth3IV: UIImageView!
    @IBOutlet weak var yearMonth4IV: UIImageView!
    @IBOutlet weak var yearMonth5IV: UIImageView!
    @IBOutlet weak var yearMonth6IV: UIImageView!
    @IBOutlet weak var yearMonth7IV: UIImageView!
    @IBOutlet weak var yearMonth8IV: UIImageView!
    @IBOutlet weak var yearMonth9IV: UIImageView!
    @IBOutlet weak var yearMonth10IV: UIImageView!
    @IBOutlet weak var yearMonth11IV: UIImageView!
    @IBOutlet weak var yearMonth12IV: UIImageView!
    
    
    @IBOutlet weak var eachYearBtn: UIButton!
    
    @IBOutlet weak var eachYearLbl: UILabel!
    
    @IBOutlet weak var eachSelectionYearImg: UIImageView!
    @IBOutlet weak var monthYearSV: UIStackView!
    
    @IBOutlet weak var weekDayRepeatYearTB: UITableView!
    @IBOutlet weak var whichWeekDayRepeatYearTB: UITableView!
    //Other
    @IBOutlet weak var okCustomBtn: UIButton!
    @IBOutlet weak var cancelCustomBtn: UIButton!
    
    
    
    
    @IBOutlet weak var customViewRightConstraint: NSLayoutConstraint!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "weekDayRepeatTableViewCell", bundle: nil)
        self.weekDayRepeatTB!.register(nib, forCellReuseIdentifier: "weekDayRepeatTableViewCell")
        let nib1 = UINib.init(nibName: "whichWeekDayRepeatTableViewCell", bundle: nil)
        self.whichWeekDayRepeatTB!.register(nib1, forCellReuseIdentifier: "whichWeekDayRepeatTableViewCell")
        let nib2 = UINib.init(nibName: "weekDayRepeatYearTableViewCell", bundle: nil)
        self.weekDayRepeatYearTB!.register(nib2, forCellReuseIdentifier: "weekDayRepeatYearTableViewCell")
        let nib3 = UINib.init(nibName: "whichWeekDayRepeatYearTableViewCell", bundle: nil)
        self.whichWeekDayRepeatYearTB!.register(nib3, forCellReuseIdentifier: "whichWeekDayRepeatYearTableViewCell")
        
        weekDayRepeatTB.separatorColor = tableSeperatorColor
        whichWeekDayRepeatTB.separatorColor = tableSeperatorColor
        weekDayRepeatYearTB.separatorColor = tableSeperatorColor
        whichWeekDayRepeatYearTB.separatorColor = tableSeperatorColor
        
        updateScreen()
        updateNoRepeatView()
        updateWeekView()
        updateMonthView()
        updateYearView()
        updateDayView()
    }
    
    func updateNoRepeatView(){
        noRepeatView?.backgroundColor    = .clear
        noRepeatLbl.textColor = mainTextColor
        noRepeatLbl.text = NSLocalizedString("event does not repeat", comment: "")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRowsInSection = 0
        if tableView == weekDayRepeatTB {numberOfRowsInSection =  weekDayLabels.count}
        if tableView == whichWeekDayRepeatTB {numberOfRowsInSection =  wichPartOfTheWeekDayLabels.count}
        if tableView == weekDayRepeatYearTB {numberOfRowsInSection =  weekDayLabels.count}
        if tableView == whichWeekDayRepeatYearTB {numberOfRowsInSection =  wichPartOfTheWeekDayYearLabels.count}
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.weekDayRepeatTB:
            let cell = weekDayRepeatTB!.dequeueReusableCell(withIdentifier: "weekDayRepeatTableViewCell", for: indexPath) as! weekDayRepeatTableViewCell
            
            cell.weekDayRepeatLbl.textColor = mainTextColor
            cell.weekDayRepeatLbl.text = weekDayLabels[indexPath.row]
            
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            
            if weekDayLabelsSelected[indexPath.row] {cell.weekDayTickIV.image = tickImage}
            else {cell.weekDayTickIV.image = tickNotSelectedImage}
            
            cell.weekDayTickIV!.layer.shadowColor = UIColor.black.cgColor
            cell.weekDayTickIV!.layer.shadowOpacity = shadowOpacityButtons
            cell.weekDayTickIV!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
            cell.weekDayTickIV!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
            
            return cell
            
        case self.whichWeekDayRepeatTB:
            let cell = whichWeekDayRepeatTB!.dequeueReusableCell(withIdentifier: "whichWeekDayRepeatTableViewCell", for: indexPath) as! whichWeekDayRepeatTableViewCell
            cell.whichWeekDayRepeatLbl.textColor = mainTextColor
            cell.whichWeekDayRepeatLbl.text = wichPartOfTheWeekDayLabels[indexPath.row]
            
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            
            if wichPartOfTheWeekDayLabelsSelected[indexPath.row] {cell.whichWeekDayTickIV.image = tickImage}
            else {cell.whichWeekDayTickIV.image = tickNotSelectedImage}
            
            cell.whichWeekDayTickIV.layer.shadowColor = UIColor.black.cgColor
            cell.whichWeekDayTickIV.layer.shadowOpacity = shadowOpacityButtons
            cell.whichWeekDayTickIV.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
            cell.whichWeekDayTickIV.layer.shadowRadius = CGFloat(shadowRadiusButtons)
            
            return cell
        
        case self.weekDayRepeatYearTB:
            let cell = weekDayRepeatYearTB!.dequeueReusableCell(withIdentifier: "weekDayRepeatYearTableViewCell", for: indexPath) as! weekDayRepeatYearTableViewCell
            
            cell.weekDayRepeatLbl.textColor = mainTextColor
            cell.weekDayRepeatLbl.text = weekDayLabels[indexPath.row]
            
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            
            if weekDayYearLabelsSelected[indexPath.row] {cell.weekDayTickIV.image = tickImage}
            else {cell.weekDayTickIV.image = tickNotSelectedImage}
            
            cell.weekDayTickIV.layer.shadowColor = UIColor.black.cgColor
            cell.weekDayTickIV.layer.shadowOpacity = shadowOpacityButtons
            cell.weekDayTickIV.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
            cell.weekDayTickIV.layer.shadowRadius = CGFloat(shadowRadiusButtons)
            
            
            return cell
            
        case self.whichWeekDayRepeatYearTB:
            let cell = whichWeekDayRepeatYearTB!.dequeueReusableCell(withIdentifier: "whichWeekDayRepeatYearTableViewCell", for: indexPath) as! whichWeekDayRepeatYearTableViewCell
            cell.whichWeekDayRepeatLbl.textColor = mainTextColor
            cell.whichWeekDayRepeatLbl.text = wichPartOfTheWeekDayLabels[indexPath.row]
            
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            
            if wichPartOfTheWeekDayYearLabelsSelected[indexPath.row] {cell.whichWeekDayTickIV.image = tickImage}
            else {cell.whichWeekDayTickIV.image = tickNotSelectedImage}
            
            cell.whichWeekDayTickIV.layer.shadowColor = UIColor.black.cgColor
            cell.whichWeekDayTickIV.layer.shadowOpacity = shadowOpacityButtons
            cell.whichWeekDayTickIV.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
            cell.whichWeekDayTickIV.layer.shadowRadius = CGFloat(shadowRadiusButtons)
            
            
            return cell
        default:
            let cell = weekDayRepeatTB!.dequeueReusableCell(withIdentifier: "weekDayRepeatTableViewCell", for: indexPath) as! weekDayRepeatTableViewCell
            return cell
        }
    }
        
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Cell selected")
        if tableView == weekDayRepeatTB {
            weekDayLabelsSelected = [false,false,false,false,false,false,false,false,false]
            weekDayLabelsSelected[indexPath.row] = true
            weekDayRepeatTB.reloadData()
        }
        if tableView == whichWeekDayRepeatTB {
            wichPartOfTheWeekDayLabelsSelected = [false,false,false,false,false,false]
            wichPartOfTheWeekDayLabelsSelected[indexPath.row] = true
            whichWeekDayRepeatTB.reloadData()
        }
        
        if tableView == weekDayRepeatYearTB {
            weekDayYearLabelsSelected = [false,false,false,false,false,false,false,false,false]
            weekDayYearLabelsSelected[indexPath.row] = true
            weekDayRepeatYearTB.reloadData()
        }
        if tableView == whichWeekDayRepeatYearTB {
            wichPartOfTheWeekDayYearLabelsSelected = [false,false,false,false,false,false]
            wichPartOfTheWeekDayYearLabelsSelected[indexPath.row] = true
            whichWeekDayRepeatYearTB.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool){
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
        recurrenceSelected = userSetRecurrence.hasreccurence
        if userSetRecurrence.hasreccurence {
        if userSetRecurrence.type == .daily {
            recurrenceSC.selectedSegmentIndex = 1
            recurrenceChanged(recurrenceSC)
            }
        if userSetRecurrence.type == .weekly {
            recurrenceSC.selectedSegmentIndex = 2
            recurrenceChanged(recurrenceSC)
            }
        if userSetRecurrence.type == .monthly {
            recurrenceSC.selectedSegmentIndex = 3
            recurrenceChanged(recurrenceSC)
            }
        if userSetRecurrence.type == .yearly {
            recurrenceSC.selectedSegmentIndex = 4
            recurrenceChanged(recurrenceSC)
            }
        }
        else{
            recurrenceSC.selectedSegmentIndex = 0
            recurrenceChanged(recurrenceSC)
         }
    }
    
    
    @IBAction func onTheBtnPressed() {
        onTheSelection = !onTheSelection
        if onTheSelection {eachSelection = false}
        else {eachSelection = true}
        updateEachAndOnTheBtnStates()
    }
    
    
    @IBAction func eachBtnPressed() {
        eachSelection = !eachSelection
        if eachSelection {onTheSelection = false}
        else {onTheSelection = true}
        updateEachAndOnTheBtnStates()
    }
    
    @IBAction func eachYearBtnPressed() {
        eachYearSelection = !eachYearSelection
 
        updateEachAndOnTheYearBtnStates()
    }
    
    
    
    
    
    func updateEachAndOnTheBtnStates(){
        if eachSelection {eachSelectionImg.image = tickImage}
        else {eachSelectionImg.image = tickNotSelectedImage}
        
        if onTheSelection {
            onTheSelectionImg.image = tickImage
            monthDaySV.isHidden = false
            eachDayView.isHidden = true
        }
        else {
            onTheSelectionImg.image = tickNotSelectedImage
            monthDaySV.isHidden = true
            eachDayView.isHidden = false
        }
    }
    
    func updateEachAndOnTheYearBtnStates(){
        if eachYearSelection {eachSelectionYearImg.image = tickImage}
        else {eachSelectionYearImg.image = tickNotSelectedImage}
        
        if eachYearSelection {
            //monthYearSV.isHidden = false
            
            eachYearView.alpha = 1.0
            eachYearView.isUserInteractionEnabled = true
            
        }
        else {
            //monthYearSV.isHidden = true
            eachYearView.alpha = 0.3
            eachYearView.isUserInteractionEnabled = false
            
        }
    }
    
    @IBAction func closeScreen(){
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func OKRecurrencePressed(_ sender: UIButton){
        switch (recurrenceSC.selectedSegmentIndex){
            case 0:
                print ("No repeat")
                //BEGIN - Clear recurrence arrays
                /*
                weekDaySelected = [false,false,false,false,false,false,false]
                weekDayLabelsSelected      = [true,false,false,false,false,false,false,false,false]
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
                */
                
                userSetRecurrence.hasreccurence = false
                
                userSetRecurrence.type = .daily
                userSetRecurrence.interval = 1
                
                userSetRecurrence.daysOfTheWeek = .none
                userSetRecurrence.daysOfTheMonth = .none
                userSetRecurrence.monthsOfTheYear = .none
                userSetRecurrence.weeksOfTheYear = .none
                userSetRecurrence.daysOfTheYear = .none
                userSetRecurrence.setPositions = .none
                userSetRecurrence.end = .none
            
            case 1:
                print ("Day repeat Selected")
                //BEGIN - Clear other arrays
                /*
                weekDaySelected = [false,false,false,false,false,false,false]
                weekDayLabelsSelected      = [true,false,false,false,false,false,false,false,false]
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
                */
                
                userSetRecurrence.hasreccurence = true
                userSetRecurrence.type = .daily
                userSetRecurrence.interval = numberOfCustomDaysToRepeat
                
                userSetRecurrence.daysOfTheWeek = .none
                userSetRecurrence.daysOfTheMonth = .none
                userSetRecurrence.monthsOfTheYear = .none
                userSetRecurrence.weeksOfTheYear = .none
                userSetRecurrence.daysOfTheYear = .none
                userSetRecurrence.setPositions = .none
                userSetRecurrence.end = .none
            //END
            case 2:
                print ("Week repeat Selected")
                //BEGIN - Clear other arrays
                /*
                //weekDaySelected = [false,false,false,false,false,false,false]
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
                //END
                */
                // Days of the week are ordered Sunday to Saturday, 1-7
                let tempDays = NSMutableArray() //clears the array
                
                if weekDaySelected[0]  {tempDays.add(EKRecurrenceDayOfWeek(.sunday))}
                if weekDaySelected[1]  {tempDays.add(EKRecurrenceDayOfWeek(.monday))}
                if weekDaySelected[2]  {tempDays.add(EKRecurrenceDayOfWeek(.tuesday))}
                if weekDaySelected[3]  {tempDays.add(EKRecurrenceDayOfWeek(.wednesday))}
                if weekDaySelected[4]  {tempDays.add(EKRecurrenceDayOfWeek(.thursday))}
                if weekDaySelected[5]  {tempDays.add(EKRecurrenceDayOfWeek(.friday))}
                if weekDaySelected[6]  {tempDays.add(EKRecurrenceDayOfWeek(.saturday))}
                print("day selected: \(tempDays)")
                
                //BEGIN - Update the week recurrence
                userSetRecurrence.hasreccurence = true
                
                userSetRecurrence.type = .weekly
                userSetRecurrence.interval = numberOfWeeksToRepeat
                userSetRecurrence.daysOfTheWeek = tempDays as? [EKRecurrenceDayOfWeek]
                print ("I repeat every \(numberOfWeeksToRepeat) weeks, on \(String(describing: userSetRecurrence.daysOfTheWeek))")
                userSetRecurrence.daysOfTheMonth = .none
                userSetRecurrence.monthsOfTheYear = .none
                userSetRecurrence.weeksOfTheYear = .none
                userSetRecurrence.daysOfTheYear = .none
                userSetRecurrence.setPositions = .none
                userSetRecurrence.end = .none
            //END
            case 3:
                print ("Month repeat Selected")
                //BEGIN - update the month recurrence
                // wipe it and below it will be allocated if user selected it
                userSetRecurrence.daysOfTheMonth = .none
                userSetRecurrence.daysOfTheWeek = .none
                userSetRecurrence.setPositions = .none
                //END
                
                
                //User selected a range of specific day of the months
                
                /*
                //BEGIN - Clear other arrays
                weekDaySelected = [false,false,false,false,false,false,false]
                //weekDayLabelsSelected = [false,false,false,false,false,false,false]
                //wichPartOfTheWeekDayLabelsSelected = [false,false,false,false,false,false]
                weekDayYearLabelsSelected  = [true,false,false,false,false,false,false,false,false]
                wichPartOfTheWeekDayYearLabelsSelected = [true,false,false,false,false,false]
                //monthDaySelected = [false,false,false,false,false,false,false,
                //                               false,false,false,false,false,false,false,
                //                               false,false,false,false,false,false,false,
                //                               false,false,false,false,false,false,false,
                //                               false,false,false,false]
                
                yearMonthSelected = [false,false,false,false,false,false,false,false, false,false,false,false,]
                //END
 
            */
                //BEGIN - for Month selection only one can be true (not the same for year)
                if onTheSelection {
                    var selectedDaysOfTheMonth:[NSNumber] = []
                    //BEGIN - I added -2, as the last one in the array should not be add as it will be handled in last line,to add last day of the month
                    for x in 0...monthDaySelected.count-2 {
                        if monthDaySelected[x] == true {
                            selectedDaysOfTheMonth.append(NSNumber(value:Int32((x+1))))
                            print ("Selected days are: \(x+1)")
                        }
                    }
                    if monthDaySelected[31] == true {
                        selectedDaysOfTheMonth.append(-1)
                        print ("Last day of the month is selected")
                    }
                    //END
                    userSetRecurrence.daysOfTheMonth = selectedDaysOfTheMonth
                }
                else {
                    let tempDays = NSMutableArray() //clears the array
                    if weekDayLabelsSelected[0]  {tempDays.add(EKRecurrenceDayOfWeek(.sunday))}
                    if weekDayLabelsSelected[1]  {tempDays.add(EKRecurrenceDayOfWeek(.monday))}
                    if weekDayLabelsSelected[2]  {tempDays.add(EKRecurrenceDayOfWeek(.tuesday))}
                    if weekDayLabelsSelected[3]  {tempDays.add(EKRecurrenceDayOfWeek(.wednesday))}
                    if weekDayLabelsSelected[4]  {tempDays.add(EKRecurrenceDayOfWeek(.thursday))}
                    if weekDayLabelsSelected[5]  {tempDays.add(EKRecurrenceDayOfWeek(.friday))}
                    if weekDayLabelsSelected[6]  {tempDays.add(EKRecurrenceDayOfWeek(.saturday))}
                    if weekDayLabelsSelected[7]  {
                        //weekDay selected
                        tempDays.add(EKRecurrenceDayOfWeek(.monday))
                        tempDays.add(EKRecurrenceDayOfWeek(.tuesday))
                        tempDays.add(EKRecurrenceDayOfWeek(.wednesday))
                        tempDays.add(EKRecurrenceDayOfWeek(.thursday))
                        tempDays.add(EKRecurrenceDayOfWeek(.friday))
                    }
                    if weekDayLabelsSelected[8]  {
                        //weekend selected
                        tempDays.add(EKRecurrenceDayOfWeek(.sunday))
                        tempDays.add(EKRecurrenceDayOfWeek(.saturday))
                    }
                    userSetRecurrence.daysOfTheWeek = tempDays as? [EKRecurrenceDayOfWeek]
                    
                    var tempSetPosition:[NSNumber] = []//clears the array
                    if wichPartOfTheWeekDayLabelsSelected[0] {tempSetPosition.append(1)}
                    if wichPartOfTheWeekDayLabelsSelected[1] {tempSetPosition.append(2)}
                    if wichPartOfTheWeekDayLabelsSelected[2] {tempSetPosition.append(3)}
                    if wichPartOfTheWeekDayLabelsSelected[3] {tempSetPosition.append(4)}
                    if wichPartOfTheWeekDayLabelsSelected[4] {tempSetPosition.append(5)}
                    if wichPartOfTheWeekDayLabelsSelected[5] {tempSetPosition.append(-1)}
                    userSetRecurrence.setPositions = tempSetPosition
                }
                userSetRecurrence.hasreccurence = true
                
                userSetRecurrence.type = .monthly
                userSetRecurrence.interval = numberOfMonthsToRepeat
                userSetRecurrence.monthsOfTheYear = .none
                userSetRecurrence.weeksOfTheYear = .none
                userSetRecurrence.daysOfTheYear = .none
                userSetRecurrence.end = .none
            //END
            case 4:
                print ("Year repeat Selected")
                userSetRecurrence.monthsOfTheYear = .none
                userSetRecurrence.daysOfTheWeek = .none
                userSetRecurrence.setPositions = .none
                
                
                //User selected a range of specific day of the months
                
                //BEGIN - Clear other arrays
                /*
                weekDaySelected = [true,false,false,false,false,false,false]
                weekDayLabelsSelected = [true,false,false,false,false,false,false,false,false]
                //weekDayYearLabelsSelected  = [false,false,false,false,false,false,false]
                //wichPartOfTheWeekDayYearLabelsSelected = [false,false,false,false,false,false]
                wichPartOfTheWeekDayLabelsSelected = [true,false,false,false,false,false]
                monthDaySelected = [false,false,false,false,false,false,false,
                                    false,false,false,false,false,false,false,
                                    false,false,false,false,false,false,false,
                                    false,false,false,false,false,false,false,
                                    false,false,false,false]
                //yearMonthSelected = [false,false,false,false,false,false,false,false, false,false,false,false,]
                //END
                */
                
                var selectedMonthOfTheYear:[NSNumber] = []
                //BEGIN
                for x in 0...yearMonthSelected.count-1 {
                    if yearMonthSelected[x] == true {
                        selectedMonthOfTheYear.append(NSNumber(value:Int32((x+1))))
                        print ("Selected Months are: \(x+1)")
                    }
                }
                userSetRecurrence.monthsOfTheYear = selectedMonthOfTheYear
                
                if eachYearSelection {
                
                let tempDays = NSMutableArray() //clears the array
                if weekDayYearLabelsSelected[0]  {tempDays.add(EKRecurrenceDayOfWeek(.sunday))}
                if weekDayYearLabelsSelected[1]  {tempDays.add(EKRecurrenceDayOfWeek(.monday))}
                if weekDayYearLabelsSelected[2]  {tempDays.add(EKRecurrenceDayOfWeek(.tuesday))}
                if weekDayYearLabelsSelected[3]  {tempDays.add(EKRecurrenceDayOfWeek(.wednesday))}
                if weekDayYearLabelsSelected[4]  {tempDays.add(EKRecurrenceDayOfWeek(.thursday))}
                if weekDayYearLabelsSelected[5]  {tempDays.add(EKRecurrenceDayOfWeek(.friday))}
                if weekDayYearLabelsSelected[6]  {tempDays.add(EKRecurrenceDayOfWeek(.saturday))}
                if weekDayYearLabelsSelected[7]  {
                    //weekDay selected
                    tempDays.add(EKRecurrenceDayOfWeek(.monday))
                    tempDays.add(EKRecurrenceDayOfWeek(.tuesday))
                    tempDays.add(EKRecurrenceDayOfWeek(.wednesday))
                    tempDays.add(EKRecurrenceDayOfWeek(.thursday))
                    tempDays.add(EKRecurrenceDayOfWeek(.friday))
                }
                if weekDayYearLabelsSelected[8]  {
                    //weekend selected
                    tempDays.add(EKRecurrenceDayOfWeek(.sunday))
                    tempDays.add(EKRecurrenceDayOfWeek(.saturday))
                }
                    userSetRecurrence.daysOfTheWeek = tempDays as? [EKRecurrenceDayOfWeek]
                    
                    var tempSetPosition:[NSNumber] = []//clears the array
                    
                    if wichPartOfTheWeekDayYearLabelsSelected[0] {tempSetPosition.append(1)}
                    if wichPartOfTheWeekDayYearLabelsSelected[1] {tempSetPosition.append(2)}
                    if wichPartOfTheWeekDayYearLabelsSelected[2] {tempSetPosition.append(3)}
                    if wichPartOfTheWeekDayYearLabelsSelected[3] {tempSetPosition.append(4)}
                    if wichPartOfTheWeekDayYearLabelsSelected[4] {tempSetPosition.append(5)}
                    if wichPartOfTheWeekDayYearLabelsSelected[5] {tempSetPosition.append(-1)}
                    userSetRecurrence.setPositions = tempSetPosition
                }
                
                userSetRecurrence.hasreccurence = true
                
                userSetRecurrence.type = .yearly
                userSetRecurrence.interval = numberOfYearsToRepeat
                userSetRecurrence.daysOfTheMonth = .none
                userSetRecurrence.weeksOfTheYear = .none
                userSetRecurrence.daysOfTheYear = .none
                
                userSetRecurrence.end = .none
        default:
            print ("ERROR - Segmented control fell through")
            
        }
        
        closeScreen()
    }
    
    func updateScreen (){
        
        
        recurrenceSC.setTitle(NSLocalizedString("None", comment: ""), forSegmentAt: 0)
        recurrenceSC.setTitle(NSLocalizedString("Daily", comment: ""), forSegmentAt: 1)
        recurrenceSC.setTitle(NSLocalizedString("Weekly", comment: ""), forSegmentAt: 2)
        recurrenceSC.setTitle(NSLocalizedString("Monthly", comment: ""), forSegmentAt: 3)
        recurrenceSC.setTitle(NSLocalizedString("Year", comment: ""), forSegmentAt: 4)
        
        onTheSelectionImg!.layer.shadowColor = UIColor.black.cgColor
        onTheSelectionImg!.layer.shadowOpacity = shadowOpacityButtons
        onTheSelectionImg!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        onTheSelectionImg!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        eachSelectionImg!.layer.shadowColor = UIColor.black.cgColor
        eachSelectionImg!.layer.shadowOpacity = shadowOpacityButtons
        eachSelectionImg!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        eachSelectionImg!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        
        eachSelectionYearImg!.layer.shadowColor = UIColor.black.cgColor
        eachSelectionYearImg!.layer.shadowOpacity = shadowOpacityButtons
        eachSelectionYearImg!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        eachSelectionYearImg!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        popupView!.layer.shadowColor = UIColor.black.cgColor
        popupView!.layer.shadowOpacity = shadowOpacityView
        popupView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        popupView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        popupView?.backgroundColor    = windowColor
        popupView?.layer.cornerRadius = cornerRadiusWindow
        popupView?.layer.borderWidth  = borderWidthWindow
        popupView?.layer.borderColor  = borderColor.cgColor
    
        headerLbl.textColor = mainTextColor
        
        
    
        
        
        okCustomBtn?.setImage(OKImg, for: .normal)
        okCustomBtn?.setImage(OKPressedImg, for: .highlighted)
        okCustomBtn!.layer.shadowColor = UIColor.black.cgColor
        okCustomBtn!.layer.shadowOpacity = shadowOpacityButtons
        okCustomBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        okCustomBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        cancelCustomBtn?.setImage(cancelPopupBtnImage, for: .normal)
        cancelCustomBtn?.setImage(cancelPopupBtnPressedImage, for: .highlighted)
        cancelCustomBtn!.layer.shadowColor = UIColor.black.cgColor
        cancelCustomBtn!.layer.shadowOpacity = shadowOpacityButtons
        cancelCustomBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        cancelCustomBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    
        onTheLbl.textColor = mainTextColor
        eachLbl.textColor = mainTextColor
        
        onTheLbl.text = NSLocalizedString("on the:", comment: "")
        eachLbl.text = NSLocalizedString("each:", comment: "")
        
        eachYearLbl.textColor = mainTextColor
        eachYearLbl.text = NSLocalizedString("each:", comment: "")
        recurrenceSC.tintColor = mainTextColor
        
        updateEachAndOnTheBtnStates()
        updateEachAndOnTheYearBtnStates()
    }
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerSegue")
        performSegue(withIdentifier: "TimerSegue", sender: nil)
    }
    //END
    
    override func viewWillDisappear(_ animated: Bool) {
        //BEGIN - Update the Settings screen in the background to update the repeat label
        NotificationCenter.default.post(name: Notification.Name("updateEventNotification"), object: nil, userInfo: ["key":"value"])
        //END
        
        print ("Stop notification")
        
        //BEGIN - Remove all notifications
        NotificationCenter.default.removeObserver(self)
        //END
    }

    @IBAction func recurrenceChanged(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex)
        {
        case 0:
            noRepeatView.isHidden = false
            dailyView.isHidden = true
            weeklyView.isHidden = true
            monthlyView.isHidden = true
            yearlyView.isHidden = true
            print ("No Repeat")
        case 1:
            noRepeatView.isHidden = true
            dailyView.isHidden = false
            weeklyView.isHidden = true
            monthlyView.isHidden = true
            yearlyView.isHidden = true
            print ("Day View selected")
        case 2:
            noRepeatView.isHidden = true
            dailyView.isHidden = true
            weeklyView.isHidden = false
            monthlyView.isHidden = true
            yearlyView.isHidden = true
            print ("Week View selected")
        case 3:
            noRepeatView.isHidden = true
            dailyView.isHidden = true
            weeklyView.isHidden = true
            monthlyView.isHidden = false
            yearlyView.isHidden = true
            print ("Month View selected")
        case 4:
            noRepeatView.isHidden = true
            dailyView.isHidden = true
            weeklyView.isHidden = true
            monthlyView.isHidden = true
            yearlyView.isHidden = false
            print ("Year View selected")
        default:
            print ("ERROR - Segmented control fell through!")
        }
    }

    @IBAction func dayStepper (_ sender: UIStepper){
        numberOfCustomDaysToRepeat = Int(sender.value)
        updateDayView()
    }
    
    @IBAction func monthDayPressed(_ sender: UIButton) {
        monthDaySelected[sender.tag] = !monthDaySelected[sender.tag]
        updateMonthView()
    }
    
    @IBAction func yearMonthDayPressed(_ sender: UIButton) {
        yearMonthSelected[sender.tag] = !yearMonthSelected[sender.tag]
        updateYearView()
    }
   
    
    
    
    
    func updateDayView(){
        
        if numberOfCustomDaysToRepeat == 1{
            day1Lbl.text = NSLocalizedString("every day", comment: "")
        }
        else{
            day1Lbl.text = "\(NSLocalizedString("every", comment: "")) \(numberOfCustomDaysToRepeat) \(NSLocalizedString("days", comment: ""))"
        }
        
        upDayBtn?.setImage(upBtnImage, for: .normal)
        upDayBtn?.setImage(upPressedBtnImage, for: .highlighted)
        upDayBtn?.layer.shadowColor = UIColor.black.cgColor
        upDayBtn?.layer.shadowOpacity = shadowOpacityButtons
        upDayBtn?.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upDayBtn?.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        downDayBtn?.setImage(downBtnImage, for: .normal)
        downDayBtn?.setImage(downPressedBtnImage, for: .highlighted)
        downDayBtn?.layer.shadowColor = UIColor.black.cgColor
        downDayBtn?.layer.shadowOpacity = shadowOpacityButtons
        downDayBtn?.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        downDayBtn?.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        day1Lbl.textColor = mainTextColor
        
        dailyView?.backgroundColor    = .clear
        
        
        print ("update day view and set day recurrence")
        
        //END
    }
    
    
    func updateMonthView(){
        //BEGIN - If no days on the month are previously selected, select the current day of the month
        let allValuesAreFalse = monthDaySelected.allSatisfy { $0 == false }
        if allValuesAreFalse == true
        {
            let dateComponent = Calendar.current.component(.day, from: eventStartDate)-1
            monthDaySelected[Int(dateComponent)] = true
        }
        //END
        
        
        if numberOfMonthsToRepeat == 1{
            month1Lbl.text = NSLocalizedString("every month", comment: "")
        }
        else{
            month1Lbl.text = "\(NSLocalizedString("every", comment: "")) \(numberOfMonthsToRepeat) \(NSLocalizedString("months", comment: ""))"
        }
        
        upMonthBtn?.setImage(upBtnImage, for: .normal)
        upMonthBtn?.setImage(upPressedBtnImage, for: .highlighted)
        upMonthBtn?.layer.shadowColor = UIColor.black.cgColor
        upMonthBtn?.layer.shadowOpacity = shadowOpacityButtons
        upMonthBtn?.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upMonthBtn?.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        downMonthBtn?.setImage(downBtnImage, for: .normal)
        downMonthBtn?.setImage(downPressedBtnImage, for: .highlighted)
        downMonthBtn?.layer.shadowColor = UIColor.black.cgColor
        downMonthBtn?.layer.shadowOpacity = shadowOpacityButtons
        downMonthBtn?.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        downMonthBtn?.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        month1Lbl.textColor = mainTextColor
        monthlyView?.backgroundColor    = .clear
        
    
        if monthDaySelected[0] {monthDay1IV.image = selectRectangleImg}
        else {monthDay1IV.image = notSelectRectangleImg}
        if monthDaySelected[1] {monthDay2IV.image = selectRectangleImg}
        else {monthDay2IV.image = notSelectRectangleImg}
        if monthDaySelected[2] {monthDay3IV.image = selectRectangleImg}
        else {monthDay3IV.image = notSelectRectangleImg}
        if monthDaySelected[3] {monthDay4IV.image = selectRectangleImg}
        else {monthDay4IV.image = notSelectRectangleImg}
        if monthDaySelected[4] {monthDay5IV.image = selectRectangleImg}
        else {monthDay5IV.image = notSelectRectangleImg}
        if monthDaySelected[5] {monthDay6IV.image = selectRectangleImg}
        else {monthDay6IV.image = notSelectRectangleImg}
        if monthDaySelected[6] {monthDay7IV.image = selectRectangleImg}
        else {monthDay7IV.image = notSelectRectangleImg}
        if monthDaySelected[7] {monthDay8IV.image = selectRectangleImg}
        else {monthDay8IV.image = notSelectRectangleImg}
        if monthDaySelected[8] {monthDay9IV.image = selectRectangleImg}
        else {monthDay9IV.image = notSelectRectangleImg}
        if monthDaySelected[9] {monthDay10IV.image = selectRectangleImg}
        else {monthDay10IV.image = notSelectRectangleImg}
        if monthDaySelected[10] {monthDay11IV.image = selectRectangleImg}
        else {monthDay11IV.image = notSelectRectangleImg}
        if monthDaySelected[11] {monthDay12IV.image = selectRectangleImg}
        else {monthDay12IV.image = notSelectRectangleImg}
        if monthDaySelected[12] {monthDay13IV.image = selectRectangleImg}
        else {monthDay13IV.image = notSelectRectangleImg}
        if monthDaySelected[13] {monthDay14IV.image = selectRectangleImg}
        else {monthDay14IV.image = notSelectRectangleImg}
        if monthDaySelected[14] {monthDay15IV.image = selectRectangleImg}
        else {monthDay15IV.image = notSelectRectangleImg}
        if monthDaySelected[15] {monthDay16IV.image = selectRectangleImg}
        else {monthDay16IV.image = notSelectRectangleImg}
        if monthDaySelected[16] {monthDay17IV.image = selectRectangleImg}
        else {monthDay17IV.image = notSelectRectangleImg}
        if monthDaySelected[17] {monthDay18IV.image = selectRectangleImg}
        else {monthDay18IV.image = notSelectRectangleImg}
        if monthDaySelected[18] {monthDay19IV.image = selectRectangleImg}
        else {monthDay19IV.image = notSelectRectangleImg}
        if monthDaySelected[19] {monthDay20IV.image = selectRectangleImg}
        else {monthDay20IV.image = notSelectRectangleImg}
        if monthDaySelected[20] {monthDay21IV.image = selectRectangleImg}
        else {monthDay21IV.image = notSelectRectangleImg}
        if monthDaySelected[21] {monthDay22IV.image = selectRectangleImg}
        else {monthDay22IV.image = notSelectRectangleImg}
        if monthDaySelected[22] {monthDay23IV.image = selectRectangleImg}
        else {monthDay23IV.image = notSelectRectangleImg}
        if monthDaySelected[23] {monthDay24IV.image = selectRectangleImg}
        else {monthDay24IV.image = notSelectRectangleImg}
        if monthDaySelected[24] {monthDay25IV.image = selectRectangleImg}
        else {monthDay25IV.image = notSelectRectangleImg}
        if monthDaySelected[25] {monthDay26IV.image = selectRectangleImg}
        else {monthDay26IV.image = notSelectRectangleImg}
        if monthDaySelected[26] {monthDay27IV.image = selectRectangleImg}
        else {monthDay27IV.image = notSelectRectangleImg}
        if monthDaySelected[27] {monthDay28IV.image = selectRectangleImg}
        else {monthDay28IV.image = notSelectRectangleImg}
        if monthDaySelected[28] {monthDay29IV.image = selectRectangleImg}
        else {monthDay29IV.image = notSelectRectangleImg}
        if monthDaySelected[29] {monthDay30IV.image = selectRectangleImg}
        else {monthDay30IV.image = notSelectRectangleImg}
        if monthDaySelected[30] {monthDay31IV.image = selectRectangleImg}
        else {monthDay31IV.image = notSelectRectangleImg}
        if monthDaySelected[31] {monthDayLIV.image = selectRectangleImg}
        else {monthDayLIV.image = notSelectRectangleImg}
        
        monthDayLBtn.setTitle(NSLocalizedString("l", comment: ""), for: .normal) //Set last day fo the month
        
        monthDay1Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay2Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay3Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay4Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay5Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay6Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay7Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay8Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay9Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay10Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay11Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay12Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay13Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay14Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay15Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay16Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay17Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay18Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay19Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay20Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay21Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay22Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay23Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay24Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay25Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay26Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay27Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay28Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay29Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay30Btn.setTitleColor(textTitleColor, for: .normal)
        monthDay31Btn.setTitleColor(textTitleColor, for: .normal)
        monthDayLBtn.setTitleColor(textTitleColor, for: .normal)
        
        //BEGIN update background of the table view for week and part of the week.
        weekDayRepeatYearTB.backgroundColor    = subWindowColor
        weekDayRepeatYearTB.layer.cornerRadius = subWindowborderRadius
        weekDayRepeatYearTB.layer.borderWidth  = subWindowborderWidth
        weekDayRepeatYearTB.layer.borderColor  = subWindowborderColor.cgColor
        
        whichWeekDayRepeatYearTB.backgroundColor    = subWindowColor
        whichWeekDayRepeatYearTB.layer.cornerRadius = subWindowborderRadius
        whichWeekDayRepeatYearTB.layer.borderWidth  = subWindowborderWidth
        whichWeekDayRepeatYearTB.layer.borderColor  = subWindowborderColor.cgColor
        //END
    }
    
    func updateYearView(){
        //BEGIN - If no days on thre month are previously selected, select the current day of the month
        let allValuesAreFalse = yearMonthSelected.allSatisfy { $0 == false }
        if allValuesAreFalse == true
        {
            let dateComponent = Calendar.current.component(.month, from: eventStartDate)-1
            yearMonthSelected[Int(dateComponent)] = true
        }
        //END
        
        
        if numberOfYearsToRepeat == 1{
            yearLbl.text = NSLocalizedString("every year in:", comment: "")
        }
        else{
            yearLbl.text = "\(NSLocalizedString("every", comment: "")) \(numberOfYearsToRepeat) \(NSLocalizedString("years in:", comment: ""))"
        }
        
        upYearBtn?.setImage(upBtnImage, for: .normal)
        upYearBtn?.setImage(upPressedBtnImage, for: .highlighted)
        upYearBtn?.layer.shadowColor = UIColor.black.cgColor
        upYearBtn?.layer.shadowOpacity = shadowOpacityButtons
        upYearBtn?.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upYearBtn?.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        downYearBtn?.setImage(downBtnImage, for: .normal)
        downYearBtn?.setImage(downPressedBtnImage, for: .highlighted)
        downYearBtn?.layer.shadowColor = UIColor.black.cgColor
        downYearBtn?.layer.shadowOpacity = shadowOpacityButtons
        downYearBtn?.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        downYearBtn?.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        yearLbl.textColor = mainTextColor
        yearlyView?.backgroundColor    = .clear
     
        if yearMonthSelected[0] {yearMonth1IV.image = selectRectangleImg}
        else {yearMonth1IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[1] {yearMonth2IV.image = selectRectangleImg}
        else {yearMonth2IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[2] {yearMonth3IV.image = selectRectangleImg}
        else {yearMonth3IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[3] {yearMonth4IV.image = selectRectangleImg}
        else {yearMonth4IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[4] {yearMonth5IV.image = selectRectangleImg}
        else {yearMonth5IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[5] {yearMonth6IV.image = selectRectangleImg}
        else {yearMonth6IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[6] {yearMonth7IV.image = selectRectangleImg}
        else {yearMonth7IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[7] {yearMonth8IV.image = selectRectangleImg}
        else {yearMonth8IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[8] {yearMonth9IV.image = selectRectangleImg}
        else {yearMonth9IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[9] {yearMonth10IV.image = selectRectangleImg}
        else {yearMonth10IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[10] {yearMonth11IV.image = selectRectangleImg}
        else {yearMonth11IV.image = notSelectRectangleImg}
        
        if yearMonthSelected[11] {yearMonth12IV.image = selectRectangleImg}
        else {yearMonth12IV.image = notSelectRectangleImg}
    
        yearMonth1Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth2Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth3Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth4Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth5Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth6Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth7Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth8Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth9Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth10Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth11Btn.setTitleColor(textTitleColor, for: .normal)
        yearMonth12Btn.setTitleColor(textTitleColor, for: .normal)
        
        yearMonth1Btn.setTitle(NSLocalizedString("jan", comment: ""), for: .normal)
        yearMonth2Btn.setTitle(NSLocalizedString("feb", comment: ""), for: .normal)
        yearMonth3Btn.setTitle(NSLocalizedString("mar", comment: ""), for: .normal)
        yearMonth4Btn.setTitle(NSLocalizedString("apr", comment: ""), for: .normal)
        yearMonth5Btn.setTitle(NSLocalizedString("may", comment: ""), for: .normal)
        yearMonth6Btn.setTitle(NSLocalizedString("jun", comment: ""), for: .normal)
        yearMonth7Btn.setTitle(NSLocalizedString("jul", comment: ""), for: .normal)
        yearMonth8Btn.setTitle(NSLocalizedString("aug", comment: ""), for: .normal)
        yearMonth9Btn.setTitle(NSLocalizedString("sep", comment: ""), for: .normal)
        yearMonth10Btn.setTitle(NSLocalizedString("oct", comment: ""), for: .normal)
        yearMonth11Btn.setTitle(NSLocalizedString("nov", comment: ""), for: .normal)
        yearMonth12Btn.setTitle(NSLocalizedString("dec", comment: ""), for: .normal)
    
        //BEGIN update background of the table view for week and part of the week.
        weekDayRepeatTB.backgroundColor    = subWindowColor
        weekDayRepeatTB.layer.cornerRadius = subWindowborderRadius
        weekDayRepeatTB.layer.borderWidth  = subWindowborderWidth
        weekDayRepeatTB.layer.borderColor  = subWindowborderColor.cgColor
        
        whichWeekDayRepeatTB.backgroundColor    = subWindowColor
        whichWeekDayRepeatTB.layer.cornerRadius = subWindowborderRadius
        whichWeekDayRepeatTB.layer.borderWidth  = subWindowborderWidth
        whichWeekDayRepeatTB.layer.borderColor  = subWindowborderColor.cgColor
        //END
    
    
    }

    @IBAction func upYearPressed() {
        numberOfYearsToRepeat = numberOfYearsToRepeat + 1
        if numberOfYearsToRepeat > 50 {numberOfYearsToRepeat = 50}
        updateYearView()
    }
    
    @IBAction func downYearPressed() {
        numberOfYearsToRepeat = numberOfYearsToRepeat - 1
        if numberOfYearsToRepeat == 0 {numberOfYearsToRepeat = 1}
        updateYearView()
    }
    
    @IBAction func upDayPressed() {
        numberOfCustomDaysToRepeat = numberOfCustomDaysToRepeat + 1
        if numberOfCustomDaysToRepeat > 30 {numberOfCustomDaysToRepeat = 30}
        updateDayView()
    }
    
    @IBAction func downDayPressed() {
        numberOfCustomDaysToRepeat = numberOfCustomDaysToRepeat - 1
        if numberOfCustomDaysToRepeat == 0 {numberOfCustomDaysToRepeat = 1}
        updateDayView()
    }
    
    @IBAction func weekBtnPressed(_ sender: UIButton) {
        
        switch (sender.tag) {
        case 0:
            weekDaySelected[0] = !weekDaySelected[0]
        case 1:
            weekDaySelected[1] = !weekDaySelected[1]
        case 2:
            weekDaySelected[2] = !weekDaySelected[2]
        case 3:
            weekDaySelected[3] = !weekDaySelected[3]
        case 4:
            weekDaySelected[4] = !weekDaySelected[4]
        case 5:
            weekDaySelected[5] = !weekDaySelected[5]
        case 6:
            weekDaySelected[6] = !weekDaySelected[6]
        default:
            print ("ERROR - Swtich of week button fell through")
        }
        updateWeekView()
    }
    
    func updateWeekView() {
        //BEGIN - If no weekdays are previously selected, select the current day of today
        let allValuesAreFalse = weekDaySelected.allSatisfy { $0 == false }
        if allValuesAreFalse == true
        {
            let dateComponent = Calendar.current.component(.weekday, from: eventStartDate)-1
            weekDaySelected[Int(dateComponent)] = true
        }
        //END
        
        
        let fmt = DateFormatter()
        let weekSymbols = fmt.shortWeekdaySymbols
        
        day1Btn.setTitle(weekSymbols![0], for: .normal)
        day2Btn.setTitle(weekSymbols![1], for: .normal)
        day3Btn.setTitle(weekSymbols![2], for: .normal)
        day4Btn.setTitle(weekSymbols![3], for: .normal)
        day5Btn.setTitle(weekSymbols![4], for: .normal)
        day6Btn.setTitle(weekSymbols![5], for: .normal)
        day7Btn.setTitle(weekSymbols![6], for: .normal)
        
        day1Btn.setTitleColor(textTitleColor, for: .normal)
        day2Btn.setTitleColor(textTitleColor, for: .normal)
        day3Btn.setTitleColor(textTitleColor, for: .normal)
        day4Btn.setTitleColor(textTitleColor, for: .normal)
        day5Btn.setTitleColor(textTitleColor, for: .normal)
        day6Btn.setTitleColor(textTitleColor, for: .normal)
        day7Btn.setTitleColor(textTitleColor, for: .normal)
        
        // Days of the week are ordered Sunday to Saturday, 1-7
        if weekDaySelected[0]  {day1IV.image = selectRectangleImg}
        else {day1IV.image = notSelectRectangleImg}
        
        if weekDaySelected[1]  {day2IV.image = selectRectangleImg}
        else {day2IV.image = notSelectRectangleImg}
        
        if weekDaySelected[2]  {day3IV.image = selectRectangleImg}
        else {day3IV.image = notSelectRectangleImg}
        
        if weekDaySelected[3]  {day4IV.image = selectRectangleImg}
        else {day4IV.image = notSelectRectangleImg}
        
        if weekDaySelected[4]  {day5IV.image = selectRectangleImg}
        else {day5IV.image = notSelectRectangleImg}
        
        if weekDaySelected[5]  {day6IV.image = selectRectangleImg}
        else {day6IV.image = notSelectRectangleImg}
        
        if weekDaySelected[6]  {day7IV.image = selectRectangleImg}
        else {day7IV.image = notSelectRectangleImg}
       
        weeklyView?.backgroundColor    = .clear
        
        upWeekBtn?.setImage(upBtnImage, for: .normal)
        upWeekBtn?.setImage(upPressedBtnImage, for: .highlighted)
        upWeekBtn?.layer.shadowColor = UIColor.black.cgColor
        upWeekBtn?.layer.shadowOpacity = shadowOpacityButtons
        upWeekBtn?.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        upWeekBtn?.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        downWeekBtn?.setImage(downBtnImage, for: .normal)
        downWeekBtn?.setImage(downPressedBtnImage, for: .highlighted)
        downWeekBtn?.layer.shadowColor = UIColor.black.cgColor
        downWeekBtn?.layer.shadowOpacity = shadowOpacityButtons
        downWeekBtn?.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        downWeekBtn?.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        week1Lbl.textColor = mainTextColor
        
        if numberOfWeeksToRepeat == 1{
            week1Lbl.text = NSLocalizedString("every week on", comment: "")
        }
        else{
            week1Lbl.text = "\(NSLocalizedString("every", comment: "")) \(numberOfWeeksToRepeat) \(NSLocalizedString("weeks on", comment: ""))"
        }
        
    }

    @IBAction func upWeekPressed() {
        numberOfWeeksToRepeat = numberOfWeeksToRepeat + 1
        if numberOfWeeksToRepeat > 5 {numberOfWeeksToRepeat = 5}
        updateWeekView()
    }
    
    @IBAction func downWeekPressed() {
        numberOfWeeksToRepeat = numberOfWeeksToRepeat - 1
        if numberOfWeeksToRepeat == 0 {numberOfWeeksToRepeat = 1}
        updateWeekView()
    }

    @IBAction func upMonthPressed() {
        numberOfMonthsToRepeat = numberOfMonthsToRepeat + 1
        if numberOfMonthsToRepeat > 12 {numberOfMonthsToRepeat = 12}
        updateMonthView()
    }
    
    @IBAction func downMonthPressed() {
        numberOfMonthsToRepeat = numberOfMonthsToRepeat - 1
        if numberOfMonthsToRepeat == 0 {numberOfMonthsToRepeat = 1}
        updateMonthView()
    }
}
