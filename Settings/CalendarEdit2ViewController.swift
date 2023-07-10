//
//  CalendarEdit2ViewController.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 18/7/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit

var requestedColourSelection: Int = 0

var calendarColorPicker0: UIColor = .red

var calendarColorPicker1: UIColor = .red
var calendarColorPicker2: UIColor = .red
var calendarColorPicker3: UIColor = .red
var calendarColorPicker4: UIColor = .red
var calendarColorPicker5: UIColor = .red
var calendarColorPicker6: UIColor = .red
var calendarColorPicker7: UIColor = .red
var calendarColorPicker8: UIColor = .red
var calendarColorPicker9: UIColor = .red
var calendarColorPicker10: UIColor = .red
var calendarColorPicker11: UIColor = .red

var calendarColorPicker12: UIColor = .red
var calendarColorPicker13: UIColor = .red
var calendarColorPicker14: UIColor = .red
var calendarColorPicker15: UIColor = .red
var calendarColorPicker16: UIColor = .red
var calendarColorPicker17: UIColor = .red
var calendarColorPicker18: UIColor = .red
var calendarColorPicker19: UIColor = .red
var calendarColorPicker20: UIColor = .red
var calendarColorPicker21: UIColor = .red
var calendarColorPicker22: UIColor = .red

var calendarColorPicker23: UIColor = .red
var calendarColorPicker24: UIColor = .red
var calendarColorPicker25: UIColor = .red
var calendarColorPicker26: UIColor = .red
var calendarColorPicker27: UIColor = .red
var calendarColorPicker28: UIColor = .red
var calendarColorPicker29: UIColor = .red
var calendarColorPicker30: UIColor = .red
var calendarColorPicker31: UIColor = .red
var calendarColorPicker32: UIColor = .red
var calendarColorPicker33: UIColor = .red

var calendarColorPicker34: UIColor = .red
var calendarColorPicker35: UIColor = .red
var calendarColorPicker36: UIColor = .red
var calendarColorPicker37: UIColor = .red
var calendarColorPicker38: UIColor = .red
var calendarColorPicker39: UIColor = .red
var calendarColorPicker40: UIColor = .red
var calendarColorPicker41: UIColor = .red
var calendarColorPicker42: UIColor = .red
var calendarColorPicker43: UIColor = .red
var calendarColorPicker44: UIColor = .red

var calendarColorPicker45: UIColor = .red
var calendarColorPicker46: UIColor = .red
var calendarColorPicker47: UIColor = .red
var calendarColorPicker48: UIColor = .red
var calendarColorPicker49: UIColor = .red
var calendarColorPicker50: UIColor = .red
var calendarColorPicker51: UIColor = .red
var calendarColorPicker52: UIColor = .red
var calendarColorPicker53: UIColor = .red
var calendarColorPicker54: UIColor = .red
var calendarColorPicker55: UIColor = .red

var calendarColorPicker56: UIColor = .red
var calendarColorPicker57: UIColor = .red
var calendarColorPicker58: UIColor = .red
var calendarColorPicker59: UIColor = .red
var calendarColorPicker60: UIColor = .red
var calendarColorPicker61: UIColor = .red
var calendarColorPicker62: UIColor = .red
var calendarColorPicker63: UIColor = .red
var calendarColorPicker64: UIColor = .red
var calendarColorPicker65: UIColor = .red
var calendarColorPicker66: UIColor = .red

var calendarColorPicker67: UIColor = .red
var calendarColorPicker68: UIColor = .red
var calendarColorPicker69: UIColor = .red
var calendarColorPicker70: UIColor = .red
var calendarColorPicker71: UIColor = .red
var calendarColorPicker72: UIColor = .red
var calendarColorPicker73: UIColor = .red
var calendarColorPicker74: UIColor = .red
var calendarColorPicker75: UIColor = .red
var calendarColorPicker76: UIColor = .red
var calendarColorPicker77: UIColor = .red

var calendarColorPicker78: UIColor = .red
var calendarColorPicker79: UIColor = .red
var calendarColorPicker80: UIColor = .red
var calendarColorPicker81: UIColor = .red
var calendarColorPicker82: UIColor = .red
var calendarColorPicker83: UIColor = .red
var calendarColorPicker84: UIColor = .red
var calendarColorPicker85: UIColor = .red
var calendarColorPicker86: UIColor = .red
var calendarColorPicker87: UIColor = .red
var calendarColorPicker88: UIColor = .red

var calendarColorPicker89: UIColor = .red
var calendarColorPicker90: UIColor = .red
var calendarColorPicker91: UIColor = .red
var calendarColorPicker92: UIColor = .red
var calendarColorPicker93: UIColor = .red
var calendarColorPicker94: UIColor = .red
var calendarColorPicker95: UIColor = .red
var calendarColorPicker96: UIColor = .red
var calendarColorPicker97: UIColor = .red
var calendarColorPicker98: UIColor = .red
var calendarColorPicker99: UIColor = .red

var reqCalendarColor:CGColor = calendarColorPicker0.cgColor

var reqCalendarName: String = NSLocalizedString("New Calendar", comment: "")

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class CalendarEdit2ViewController: UIViewController,UITextViewDelegate {

    @IBOutlet var topHeaderView: UIView!
    @IBOutlet var topHeaderImg: UIImageView!
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var topHeaderLbl: UILabel!
    @IBOutlet var calendarColorLbl: UILabel!
    //END
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var settingsWindowView: UIView!
    @IBOutlet var calendarName: UITextField?
    
    @IBOutlet var colourSelectionBtn0: UIButton!
    @IBOutlet var colourSelectionBtn1: UIButton!
    @IBOutlet var colourSelectionBtn2: UIButton!
    @IBOutlet var colourSelectionBtn3: UIButton!
    @IBOutlet var colourSelectionBtn4: UIButton!
    @IBOutlet var colourSelectionBtn5: UIButton!
    @IBOutlet var colourSelectionBtn6: UIButton!
    @IBOutlet var colourSelectionBtn7: UIButton!
    @IBOutlet var colourSelectionBtn8: UIButton!
    @IBOutlet var colourSelectionBtn9: UIButton!
    @IBOutlet var colourSelectionBtn10: UIButton!
    @IBOutlet var colourSelectionBtn11: UIButton!
    
    @IBOutlet var colourSelectionBtn12: UIButton!
    @IBOutlet var colourSelectionBtn13: UIButton!
    @IBOutlet var colourSelectionBtn14: UIButton!
    @IBOutlet var colourSelectionBtn15: UIButton!
    @IBOutlet var colourSelectionBtn16: UIButton!
    @IBOutlet var colourSelectionBtn17: UIButton!
    @IBOutlet var colourSelectionBtn18: UIButton!
    @IBOutlet var colourSelectionBtn19: UIButton!
    @IBOutlet var colourSelectionBtn20: UIButton!
    @IBOutlet var colourSelectionBtn21: UIButton!
    @IBOutlet var colourSelectionBtn22: UIButton!
    
    @IBOutlet var colourSelectionBtn23: UIButton!
    @IBOutlet var colourSelectionBtn24: UIButton!
    @IBOutlet var colourSelectionBtn25: UIButton!
    @IBOutlet var colourSelectionBtn26: UIButton!
    @IBOutlet var colourSelectionBtn27: UIButton!
    @IBOutlet var colourSelectionBtn28: UIButton!
    @IBOutlet var colourSelectionBtn29: UIButton!
    @IBOutlet var colourSelectionBtn30: UIButton!
    @IBOutlet var colourSelectionBtn31: UIButton!
    @IBOutlet var colourSelectionBtn32: UIButton!
    @IBOutlet var colourSelectionBtn33: UIButton!
    
    @IBOutlet var colourSelectionBtn34: UIButton!
    @IBOutlet var colourSelectionBtn35: UIButton!
    @IBOutlet var colourSelectionBtn36: UIButton!
    @IBOutlet var colourSelectionBtn37: UIButton!
    @IBOutlet var colourSelectionBtn38: UIButton!
    @IBOutlet var colourSelectionBtn39: UIButton!
    @IBOutlet var colourSelectionBtn40: UIButton!
    @IBOutlet var colourSelectionBtn41: UIButton!
    @IBOutlet var colourSelectionBtn42: UIButton!
    @IBOutlet var colourSelectionBtn43: UIButton!
    @IBOutlet var colourSelectionBtn44: UIButton!
    
    @IBOutlet var colourSelectionBtn45: UIButton!
    @IBOutlet var colourSelectionBtn46: UIButton!
    @IBOutlet var colourSelectionBtn47: UIButton!
    @IBOutlet var colourSelectionBtn48: UIButton!
    @IBOutlet var colourSelectionBtn49: UIButton!
    @IBOutlet var colourSelectionBtn50: UIButton!
    @IBOutlet var colourSelectionBtn51: UIButton!
    @IBOutlet var colourSelectionBtn52: UIButton!
    @IBOutlet var colourSelectionBtn53: UIButton!
    @IBOutlet var colourSelectionBtn54: UIButton!
    @IBOutlet var colourSelectionBtn55: UIButton!
    
    @IBOutlet var colourSelectionBtn56: UIButton!
    @IBOutlet var colourSelectionBtn57: UIButton!
    @IBOutlet var colourSelectionBtn58: UIButton!
    @IBOutlet var colourSelectionBtn59: UIButton!
    @IBOutlet var colourSelectionBtn60: UIButton!
    @IBOutlet var colourSelectionBtn61: UIButton!
    @IBOutlet var colourSelectionBtn62: UIButton!
    @IBOutlet var colourSelectionBtn63: UIButton!
    @IBOutlet var colourSelectionBtn64: UIButton!
    @IBOutlet var colourSelectionBtn65: UIButton!
    @IBOutlet var colourSelectionBtn66: UIButton!
    
    @IBOutlet var colourSelectionBtn67: UIButton!
    @IBOutlet var colourSelectionBtn68: UIButton!
    @IBOutlet var colourSelectionBtn69: UIButton!
    @IBOutlet var colourSelectionBtn70: UIButton!
    @IBOutlet var colourSelectionBtn71: UIButton!
    @IBOutlet var colourSelectionBtn72: UIButton!
    @IBOutlet var colourSelectionBtn73: UIButton!
    @IBOutlet var colourSelectionBtn74: UIButton!
    @IBOutlet var colourSelectionBtn75: UIButton!
    @IBOutlet var colourSelectionBtn76: UIButton!
    @IBOutlet var colourSelectionBtn77: UIButton!
    
    @IBOutlet var colourSelectionBtn78: UIButton!
    @IBOutlet var colourSelectionBtn79: UIButton!
    @IBOutlet var colourSelectionBtn80: UIButton!
    @IBOutlet var colourSelectionBtn81: UIButton!
    @IBOutlet var colourSelectionBtn82: UIButton!
    @IBOutlet var colourSelectionBtn83: UIButton!
    @IBOutlet var colourSelectionBtn84: UIButton!
    @IBOutlet var colourSelectionBtn85: UIButton!
    @IBOutlet var colourSelectionBtn86: UIButton!
    @IBOutlet var colourSelectionBtn87: UIButton!
    @IBOutlet var colourSelectionBtn88: UIButton!
    
    @IBOutlet var colourSelectionBtn89: UIButton!
    @IBOutlet var colourSelectionBtn90: UIButton!
    @IBOutlet var colourSelectionBtn91: UIButton!
    @IBOutlet var colourSelectionBtn92: UIButton!
    @IBOutlet var colourSelectionBtn93: UIButton!
    @IBOutlet var colourSelectionBtn94: UIButton!
    @IBOutlet var colourSelectionBtn95: UIButton!
    @IBOutlet var colourSelectionBtn96: UIButton!
    @IBOutlet var colourSelectionBtn97: UIButton!
    @IBOutlet var colourSelectionBtn98: UIButton!
    @IBOutlet var colourSelectionBtn99: UIButton!
    
    @IBOutlet var colourIV0: UIImageView!
    @IBOutlet var colourIV1: UIImageView!
    @IBOutlet var colourIV2: UIImageView!
    @IBOutlet var colourIV3: UIImageView!
    @IBOutlet var colourIV4: UIImageView!
    @IBOutlet var colourIV5: UIImageView!
    @IBOutlet var colourIV6: UIImageView!
    @IBOutlet var colourIV7: UIImageView!
    @IBOutlet var colourIV8: UIImageView!
    @IBOutlet var colourIV9: UIImageView!
    @IBOutlet var colourIV10: UIImageView!
    @IBOutlet var colourIV11: UIImageView!
    
    @IBOutlet var colourIV12: UIImageView!
    @IBOutlet var colourIV13: UIImageView!
    @IBOutlet var colourIV14: UIImageView!
    @IBOutlet var colourIV15: UIImageView!
    @IBOutlet var colourIV16: UIImageView!
    @IBOutlet var colourIV17: UIImageView!
    @IBOutlet var colourIV18: UIImageView!
    @IBOutlet var colourIV19: UIImageView!
    @IBOutlet var colourIV20: UIImageView!
    @IBOutlet var colourIV21: UIImageView!
    @IBOutlet var colourIV22: UIImageView!
    
    @IBOutlet var colourIV23: UIImageView!
    @IBOutlet var colourIV24: UIImageView!
    @IBOutlet var colourIV25: UIImageView!
    @IBOutlet var colourIV26: UIImageView!
    @IBOutlet var colourIV27: UIImageView!
    @IBOutlet var colourIV28: UIImageView!
    @IBOutlet var colourIV29: UIImageView!
    @IBOutlet var colourIV30: UIImageView!
    @IBOutlet var colourIV31: UIImageView!
    @IBOutlet var colourIV32: UIImageView!
    @IBOutlet var colourIV33: UIImageView!
    
    @IBOutlet var colourIV34: UIImageView!
    @IBOutlet var colourIV35: UIImageView!
    @IBOutlet var colourIV36: UIImageView!
    @IBOutlet var colourIV37: UIImageView!
    @IBOutlet var colourIV38: UIImageView!
    @IBOutlet var colourIV39: UIImageView!
    @IBOutlet var colourIV40: UIImageView!
    @IBOutlet var colourIV41: UIImageView!
    @IBOutlet var colourIV42: UIImageView!
    @IBOutlet var colourIV43: UIImageView!
    @IBOutlet var colourIV44: UIImageView!
    
    @IBOutlet var colourIV45: UIImageView!
    @IBOutlet var colourIV46: UIImageView!
    @IBOutlet var colourIV47: UIImageView!
    @IBOutlet var colourIV48: UIImageView!
    @IBOutlet var colourIV49: UIImageView!
    @IBOutlet var colourIV50: UIImageView!
    @IBOutlet var colourIV51: UIImageView!
    @IBOutlet var colourIV52: UIImageView!
    @IBOutlet var colourIV53: UIImageView!
    @IBOutlet var colourIV54: UIImageView!
    @IBOutlet var colourIV55: UIImageView!
    
    @IBOutlet var colourIV56: UIImageView!
    @IBOutlet var colourIV57: UIImageView!
    @IBOutlet var colourIV58: UIImageView!
    @IBOutlet var colourIV59: UIImageView!
    @IBOutlet var colourIV60: UIImageView!
    @IBOutlet var colourIV61: UIImageView!
    @IBOutlet var colourIV62: UIImageView!
    @IBOutlet var colourIV63: UIImageView!
    @IBOutlet var colourIV64: UIImageView!
    @IBOutlet var colourIV65: UIImageView!
    @IBOutlet var colourIV66: UIImageView!
    
    @IBOutlet var colourIV67: UIImageView!
    @IBOutlet var colourIV68: UIImageView!
    @IBOutlet var colourIV69: UIImageView!
    @IBOutlet var colourIV70: UIImageView!
    @IBOutlet var colourIV71: UIImageView!
    @IBOutlet var colourIV72: UIImageView!
    @IBOutlet var colourIV73: UIImageView!
    @IBOutlet var colourIV74: UIImageView!
    @IBOutlet var colourIV75: UIImageView!
    @IBOutlet var colourIV76: UIImageView!
    @IBOutlet var colourIV77: UIImageView!
    
    @IBOutlet var colourIV78: UIImageView!
    @IBOutlet var colourIV79: UIImageView!
    @IBOutlet var colourIV80: UIImageView!
    @IBOutlet var colourIV81: UIImageView!
    @IBOutlet var colourIV82: UIImageView!
    @IBOutlet var colourIV83: UIImageView!
    @IBOutlet var colourIV84: UIImageView!
    @IBOutlet var colourIV85: UIImageView!
    @IBOutlet var colourIV86: UIImageView!
    @IBOutlet var colourIV87: UIImageView!
    @IBOutlet var colourIV88: UIImageView!
    
    @IBOutlet var colourIV89: UIImageView!
    @IBOutlet var colourIV90: UIImageView!
    @IBOutlet var colourIV91: UIImageView!
    @IBOutlet var colourIV92: UIImageView!
    @IBOutlet var colourIV93: UIImageView!
    @IBOutlet var colourIV94: UIImageView!
    @IBOutlet var colourIV95: UIImageView!
    @IBOutlet var colourIV96: UIImageView!
    @IBOutlet var colourIV97: UIImageView!
    @IBOutlet var colourIV98: UIImageView!
    @IBOutlet var colourIV99: UIImageView!
    
    @IBOutlet var colourSelectionIV0: UIImageView!
    
    @IBOutlet var colourSelectionIV1: UIImageView!
    @IBOutlet var colourSelectionIV2: UIImageView!
    @IBOutlet var colourSelectionIV3: UIImageView!
    @IBOutlet var colourSelectionIV4: UIImageView!
    @IBOutlet var colourSelectionIV5: UIImageView!
    @IBOutlet var colourSelectionIV6: UIImageView!
    @IBOutlet var colourSelectionIV7: UIImageView!
    @IBOutlet var colourSelectionIV8: UIImageView!
    @IBOutlet var colourSelectionIV9: UIImageView!
    @IBOutlet var colourSelectionIV10: UIImageView!
    @IBOutlet var colourSelectionIV11: UIImageView!
    
    @IBOutlet var colourSelectionIV12: UIImageView!
    @IBOutlet var colourSelectionIV13: UIImageView!
    @IBOutlet var colourSelectionIV14: UIImageView!
    @IBOutlet var colourSelectionIV15: UIImageView!
    @IBOutlet var colourSelectionIV16: UIImageView!
    @IBOutlet var colourSelectionIV17: UIImageView!
    @IBOutlet var colourSelectionIV18: UIImageView!
    @IBOutlet var colourSelectionIV19: UIImageView!
    @IBOutlet var colourSelectionIV20: UIImageView!
    @IBOutlet var colourSelectionIV21: UIImageView!
    @IBOutlet var colourSelectionIV22: UIImageView!
    
    @IBOutlet var colourSelectionIV23: UIImageView!
    @IBOutlet var colourSelectionIV24: UIImageView!
    @IBOutlet var colourSelectionIV25: UIImageView!
    @IBOutlet var colourSelectionIV26: UIImageView!
    @IBOutlet var colourSelectionIV27: UIImageView!
    @IBOutlet var colourSelectionIV28: UIImageView!
    @IBOutlet var colourSelectionIV29: UIImageView!
    @IBOutlet var colourSelectionIV30: UIImageView!
    @IBOutlet var colourSelectionIV31: UIImageView!
    @IBOutlet var colourSelectionIV32: UIImageView!
    @IBOutlet var colourSelectionIV33: UIImageView!
    
    @IBOutlet var colourSelectionIV34: UIImageView!
    @IBOutlet var colourSelectionIV35: UIImageView!
    @IBOutlet var colourSelectionIV36: UIImageView!
    @IBOutlet var colourSelectionIV37: UIImageView!
    @IBOutlet var colourSelectionIV38: UIImageView!
    @IBOutlet var colourSelectionIV39: UIImageView!
    @IBOutlet var colourSelectionIV40: UIImageView!
    @IBOutlet var colourSelectionIV41: UIImageView!
    @IBOutlet var colourSelectionIV42: UIImageView!
    @IBOutlet var colourSelectionIV43: UIImageView!
    @IBOutlet var colourSelectionIV44: UIImageView!
    
    @IBOutlet var colourSelectionIV45: UIImageView!
    @IBOutlet var colourSelectionIV46: UIImageView!
    @IBOutlet var colourSelectionIV47: UIImageView!
    @IBOutlet var colourSelectionIV48: UIImageView!
    @IBOutlet var colourSelectionIV49: UIImageView!
    @IBOutlet var colourSelectionIV50: UIImageView!
    @IBOutlet var colourSelectionIV51: UIImageView!
    @IBOutlet var colourSelectionIV52: UIImageView!
    @IBOutlet var colourSelectionIV53: UIImageView!
    @IBOutlet var colourSelectionIV54: UIImageView!
    @IBOutlet var colourSelectionIV55: UIImageView!
    
    @IBOutlet var colourSelectionIV56: UIImageView!
    @IBOutlet var colourSelectionIV57: UIImageView!
    @IBOutlet var colourSelectionIV58: UIImageView!
    @IBOutlet var colourSelectionIV59: UIImageView!
    @IBOutlet var colourSelectionIV60: UIImageView!
    @IBOutlet var colourSelectionIV61: UIImageView!
    @IBOutlet var colourSelectionIV62: UIImageView!
    @IBOutlet var colourSelectionIV63: UIImageView!
    @IBOutlet var colourSelectionIV64: UIImageView!
    @IBOutlet var colourSelectionIV65: UIImageView!
    @IBOutlet var colourSelectionIV66: UIImageView!
    
    @IBOutlet var colourSelectionIV67: UIImageView!
    @IBOutlet var colourSelectionIV68: UIImageView!
    @IBOutlet var colourSelectionIV69: UIImageView!
    @IBOutlet var colourSelectionIV70: UIImageView!
    @IBOutlet var colourSelectionIV71: UIImageView!
    @IBOutlet var colourSelectionIV72: UIImageView!
    @IBOutlet var colourSelectionIV73: UIImageView!
    @IBOutlet var colourSelectionIV74: UIImageView!
    @IBOutlet var colourSelectionIV75: UIImageView!
    @IBOutlet var colourSelectionIV76: UIImageView!
    @IBOutlet var colourSelectionIV77: UIImageView!
    
    @IBOutlet var colourSelectionIV78: UIImageView!
    @IBOutlet var colourSelectionIV79: UIImageView!
    @IBOutlet var colourSelectionIV80: UIImageView!
    @IBOutlet var colourSelectionIV81: UIImageView!
    @IBOutlet var colourSelectionIV82: UIImageView!
    @IBOutlet var colourSelectionIV83: UIImageView!
    @IBOutlet var colourSelectionIV84: UIImageView!
    @IBOutlet var colourSelectionIV85: UIImageView!
    @IBOutlet var colourSelectionIV86: UIImageView!
    @IBOutlet var colourSelectionIV87: UIImageView!
    @IBOutlet var colourSelectionIV88: UIImageView!
    
    
    @IBOutlet var colourSelectionIV89: UIImageView!
    @IBOutlet var colourSelectionIV90: UIImageView!
    @IBOutlet var colourSelectionIV91: UIImageView!
    @IBOutlet var colourSelectionIV92: UIImageView!
    @IBOutlet var colourSelectionIV93: UIImageView!
    @IBOutlet var colourSelectionIV94: UIImageView!
    @IBOutlet var colourSelectionIV95: UIImageView!
    @IBOutlet var colourSelectionIV96: UIImageView!
    @IBOutlet var colourSelectionIV97: UIImageView!
    @IBOutlet var colourSelectionIV98: UIImageView!
    @IBOutlet var colourSelectionIV99: UIImageView!
    @IBOutlet var okCustomBtn: UIButton!
    @IBOutlet var cancelCustomBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        requestedColourSelection = 0
        setCalendarSelection (selectionNumber: requestedColourSelection)// Do any additional setup after loading the view.
    }
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    func setupCalendarColours()
    {
        calendarColorPicker1 = hexStringToUIColor(hex: "#F5F6F7")
        calendarColorPicker2 = hexStringToUIColor(hex: "#EAECEE")
        calendarColorPicker3 = hexStringToUIColor(hex: "#D5DADD")
        calendarColorPicker4 = hexStringToUIColor(hex: "#A9B4BE")
        calendarColorPicker5 = hexStringToUIColor(hex: "#8396AB")
        calendarColorPicker6 = hexStringToUIColor(hex: "#5B738B")
        calendarColorPicker7 = hexStringToUIColor(hex: "#475E75")
        calendarColorPicker8 = hexStringToUIColor(hex: "#354A5F")
        calendarColorPicker9 = hexStringToUIColor(hex: "#223548")
        calendarColorPicker10 = hexStringToUIColor(hex: "#1A2733")
        calendarColorPicker11 = hexStringToUIColor(hex: "#12171C")
        
        calendarColorPicker12 = hexStringToUIColor(hex: "#FFEAF4")
        calendarColorPicker13 = hexStringToUIColor(hex: "#FFD5EA")
        calendarColorPicker14 = hexStringToUIColor(hex: "#FFB2D2")
        calendarColorPicker15 = hexStringToUIColor(hex: "#FF8CB2")
        calendarColorPicker16 = hexStringToUIColor(hex: "#FF5C77")
        calendarColorPicker17 = hexStringToUIColor(hex: "#EE3939")
        calendarColorPicker18 = hexStringToUIColor(hex: "#D20A0A")
        calendarColorPicker19 = hexStringToUIColor(hex: "#AA0808")
        calendarColorPicker20 = hexStringToUIColor(hex: "#840606")
        calendarColorPicker21 = hexStringToUIColor(hex: "#5A0404")
        calendarColorPicker22 = hexStringToUIColor(hex: "#350000")
        
        calendarColorPicker23 = hexStringToUIColor(hex: "#FFF8D6")
        calendarColorPicker24 = hexStringToUIColor(hex: "#FFF3B8")
        calendarColorPicker25 = hexStringToUIColor(hex: "#FFDF72")
        calendarColorPicker26 = hexStringToUIColor(hex: "#FFC933")
        calendarColorPicker27 = hexStringToUIColor(hex: "#FFB300")
        calendarColorPicker28 = hexStringToUIColor(hex: "#E76500")
        calendarColorPicker29 = hexStringToUIColor(hex: "#C35500")
        calendarColorPicker30 = hexStringToUIColor(hex: "#A93E00")
        calendarColorPicker31 = hexStringToUIColor(hex: "#8D2A00")
        calendarColorPicker32 = hexStringToUIColor(hex: "#6D1900")
        calendarColorPicker33 = hexStringToUIColor(hex: "#450B00")
        
        calendarColorPicker34 = hexStringToUIColor(hex: "#F5FAE5")
        calendarColorPicker35 = hexStringToUIColor(hex: "#EBF5CB")
        calendarColorPicker36 = hexStringToUIColor(hex: "#BDE986")
        calendarColorPicker37 = hexStringToUIColor(hex: "#97DD40")
        calendarColorPicker38 = hexStringToUIColor(hex: "#5DC122")
        calendarColorPicker39 = hexStringToUIColor(hex: "#36A41D")
        calendarColorPicker40 = hexStringToUIColor(hex: "#188918")
        calendarColorPicker41 = hexStringToUIColor(hex: "#256F3A")
        calendarColorPicker42 = hexStringToUIColor(hex: "#1E592F")
        calendarColorPicker43 = hexStringToUIColor(hex: "#164323")
        calendarColorPicker44 = hexStringToUIColor(hex: "#0E2B16")
        
        calendarColorPicker45 = hexStringToUIColor(hex: "#DAFDF5")
        calendarColorPicker46 = hexStringToUIColor(hex: "#C2FCEE")
        calendarColorPicker47 = hexStringToUIColor(hex: "#64EDD2")
        calendarColorPicker48 = hexStringToUIColor(hex: "#2CE0BF")
        calendarColorPicker49 = hexStringToUIColor(hex: "#00CEAC")
        calendarColorPicker50 = hexStringToUIColor(hex: "#049F9A")
        calendarColorPicker51 = hexStringToUIColor(hex: "#07838F")
        calendarColorPicker52 = hexStringToUIColor(hex: "#046C7A")
        calendarColorPicker53 = hexStringToUIColor(hex: "#035663")
        calendarColorPicker54 = hexStringToUIColor(hex: "#02414C")
        calendarColorPicker55 = hexStringToUIColor(hex: "#012931")
        
        calendarColorPicker56 = hexStringToUIColor(hex: "#EBF8FF")
        calendarColorPicker57 = hexStringToUIColor(hex: "#D1EFFF")
        calendarColorPicker58 = hexStringToUIColor(hex: "#A6E0FF")
        calendarColorPicker59 = hexStringToUIColor(hex: "#89D1FF")
        calendarColorPicker60 = hexStringToUIColor(hex: "#4DB1FF")
        calendarColorPicker61 = hexStringToUIColor(hex: "#1B90FF")
        calendarColorPicker62 = hexStringToUIColor(hex: "#0070F2")
        calendarColorPicker63 = hexStringToUIColor(hex: "#0057D2")
        calendarColorPicker64 = hexStringToUIColor(hex: "#0040B0")
        calendarColorPicker65 = hexStringToUIColor(hex: "#002A86")
        calendarColorPicker66 = hexStringToUIColor(hex: "#00144A")
        
        calendarColorPicker67 = hexStringToUIColor(hex: "#F1ECFF")
        calendarColorPicker68 = hexStringToUIColor(hex: "#E2D8FF")
        calendarColorPicker69 = hexStringToUIColor(hex: "#D3B6FF")
        calendarColorPicker70 = hexStringToUIColor(hex: "#B894FF")
        calendarColorPicker71 = hexStringToUIColor(hex: "#9B76FF")
        calendarColorPicker72 = hexStringToUIColor(hex: "#7858FF")
        calendarColorPicker73 = hexStringToUIColor(hex: "#5D36FF")
        calendarColorPicker74 = hexStringToUIColor(hex: "#470CED")
        calendarColorPicker75 = hexStringToUIColor(hex: "#2C13AD")
        calendarColorPicker76 = hexStringToUIColor(hex: "#1C0C6E")
        calendarColorPicker77 = hexStringToUIColor(hex: "#0E0637")
        
        calendarColorPicker78 = hexStringToUIColor(hex: "#FFF0FA")
        calendarColorPicker79 = hexStringToUIColor(hex: "#FFDCF3")
        calendarColorPicker80 = hexStringToUIColor(hex: "#FFAFED")
        calendarColorPicker81 = hexStringToUIColor(hex: "#FF8AF0")
        calendarColorPicker82 = hexStringToUIColor(hex: "#F65AF2")
        calendarColorPicker83 = hexStringToUIColor(hex: "#F31DED")
        calendarColorPicker84 = hexStringToUIColor(hex: "#CC00DC")
        calendarColorPicker85 = hexStringToUIColor(hex: "#A100C2")
        calendarColorPicker86 = hexStringToUIColor(hex: "#7800A4")
        calendarColorPicker87 = hexStringToUIColor(hex: "#510080")
        calendarColorPicker88 = hexStringToUIColor(hex: "#28004A")
        
        calendarColorPicker89 = hexStringToUIColor(hex: "#FFF0F5")
        calendarColorPicker90 = hexStringToUIColor(hex: "#FFDCE8")
        calendarColorPicker91 = hexStringToUIColor(hex: "#DECBDA")
        calendarColorPicker92 = hexStringToUIColor(hex: "#FEADC8")
        calendarColorPicker93 = hexStringToUIColor(hex: "#FE83AE")
        calendarColorPicker94 = hexStringToUIColor(hex: "#FA4F96")
        calendarColorPicker95 = hexStringToUIColor(hex: "#DF1278")
        calendarColorPicker96 = hexStringToUIColor(hex: "#BA066C")
        calendarColorPicker97 = hexStringToUIColor(hex: "#9B015D")
        calendarColorPicker98 = hexStringToUIColor(hex: "#71014B")
        calendarColorPicker99 = hexStringToUIColor(hex: "#510136")
        
        //BEGIN - Setup colour selection plaques
        colourSelectionIV0.isHidden = true
        colourSelectionIV1.isHidden = true
        colourSelectionIV2.isHidden = true
        colourSelectionIV3.isHidden = true
        colourSelectionIV4.isHidden = true
        colourSelectionIV5.isHidden = true
        colourSelectionIV6.isHidden = true
        colourSelectionIV7.isHidden = true
        colourSelectionIV8.isHidden = true
        colourSelectionIV9.isHidden = true
        colourSelectionIV10.isHidden = true
        colourSelectionIV11.isHidden = true
        
        colourSelectionIV12.isHidden = true
        colourSelectionIV13.isHidden = true
        colourSelectionIV14.isHidden = true
        colourSelectionIV15.isHidden = true
        colourSelectionIV16.isHidden = true
        colourSelectionIV17.isHidden = true
        colourSelectionIV18.isHidden = true
        colourSelectionIV19.isHidden = true
        colourSelectionIV20.isHidden = true
        colourSelectionIV21.isHidden = true
        colourSelectionIV22.isHidden = true
        
        colourSelectionIV23.isHidden = true
        colourSelectionIV24.isHidden = true
        colourSelectionIV25.isHidden = true
        colourSelectionIV26.isHidden = true
        colourSelectionIV27.isHidden = true
        colourSelectionIV28.isHidden = true
        colourSelectionIV29.isHidden = true
        colourSelectionIV30.isHidden = true
        colourSelectionIV31.isHidden = true
        colourSelectionIV32.isHidden = true
        colourSelectionIV33.isHidden = true
        
        colourSelectionIV34.isHidden = true
        colourSelectionIV35.isHidden = true
        colourSelectionIV36.isHidden = true
        colourSelectionIV37.isHidden = true
        colourSelectionIV38.isHidden = true
        colourSelectionIV39.isHidden = true
        colourSelectionIV40.isHidden = true
        colourSelectionIV41.isHidden = true
        colourSelectionIV42.isHidden = true
        colourSelectionIV43.isHidden = true
        colourSelectionIV44.isHidden = true
        
        colourSelectionIV45.isHidden = true
        colourSelectionIV46.isHidden = true
        colourSelectionIV47.isHidden = true
        colourSelectionIV48.isHidden = true
        colourSelectionIV49.isHidden = true
        colourSelectionIV50.isHidden = true
        colourSelectionIV51.isHidden = true
        colourSelectionIV52.isHidden = true
        colourSelectionIV53.isHidden = true
        colourSelectionIV54.isHidden = true
        colourSelectionIV55.isHidden = true
        
        colourSelectionIV56.isHidden = true
        colourSelectionIV57.isHidden = true
        colourSelectionIV58.isHidden = true
        colourSelectionIV59.isHidden = true
        colourSelectionIV60.isHidden = true
        colourSelectionIV61.isHidden = true
        colourSelectionIV62.isHidden = true
        colourSelectionIV63.isHidden = true
        colourSelectionIV64.isHidden = true
        colourSelectionIV65.isHidden = true
        colourSelectionIV66.isHidden = true
        
        colourSelectionIV67.isHidden = true
        colourSelectionIV68.isHidden = true
        colourSelectionIV69.isHidden = true
        colourSelectionIV70.isHidden = true
        colourSelectionIV71.isHidden = true
        colourSelectionIV72.isHidden = true
        colourSelectionIV73.isHidden = true
        colourSelectionIV74.isHidden = true
        colourSelectionIV75.isHidden = true
        colourSelectionIV76.isHidden = true
        colourSelectionIV77.isHidden = true
        
        colourSelectionIV78.isHidden = true
        colourSelectionIV79.isHidden = true
        colourSelectionIV80.isHidden = true
        colourSelectionIV81.isHidden = true
        colourSelectionIV82.isHidden = true
        colourSelectionIV83.isHidden = true
        colourSelectionIV84.isHidden = true
        colourSelectionIV85.isHidden = true
        colourSelectionIV86.isHidden = true
        colourSelectionIV87.isHidden = true
        colourSelectionIV88.isHidden = true
        
        colourSelectionIV89.isHidden = true
        colourSelectionIV90.isHidden = true
        colourSelectionIV91.isHidden = true
        colourSelectionIV92.isHidden = true
        colourSelectionIV93.isHidden = true
        colourSelectionIV94.isHidden = true
        colourSelectionIV95.isHidden = true
        colourSelectionIV96.isHidden = true
        colourSelectionIV97.isHidden = true
        colourSelectionIV98.isHidden = true
        colourSelectionIV99.isHidden = true
        
        colourSelectionIV0.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV0.tintColor = attentionTextColor
        colourSelectionIV0.contentMode = .center
        
        colourSelectionIV1.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV1.tintColor = attentionTextColor
        colourSelectionIV1.contentMode = .center
        
        colourSelectionIV2.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV2.tintColor = attentionTextColor
        colourSelectionIV2.contentMode = .center
        
        colourSelectionIV3.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV3.tintColor = attentionTextColor
        colourSelectionIV3.contentMode = .center
        
        colourSelectionIV4.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV4.tintColor = attentionTextColor
        colourSelectionIV4.contentMode = .center
        
        colourSelectionIV5.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV5.tintColor = attentionTextColor
        colourSelectionIV5.contentMode = .center
        
        colourSelectionIV6.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV6.tintColor = attentionTextColor
        colourSelectionIV6.contentMode = .center
        
        colourSelectionIV7.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV7.tintColor = attentionTextColor
        colourSelectionIV7.contentMode = .center
        
        colourSelectionIV8.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV8.tintColor = attentionTextColor
        colourSelectionIV8.contentMode = .center
        
        colourSelectionIV9.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV9.tintColor = attentionTextColor
        colourSelectionIV9.contentMode = .center
        
        colourSelectionIV10.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV10.tintColor = attentionTextColor
        colourSelectionIV10.contentMode = .center
        
        colourSelectionIV11.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV11.tintColor = attentionTextColor
        colourSelectionIV11.contentMode = .center
        
        colourSelectionIV12.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV12.tintColor = attentionTextColor
        colourSelectionIV12.contentMode = .center
        colourSelectionIV13.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV13.tintColor = attentionTextColor
        colourSelectionIV13.contentMode = .center
        colourSelectionIV14.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV14.tintColor = attentionTextColor
        colourSelectionIV14.contentMode = .center
        colourSelectionIV15.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV15.tintColor = attentionTextColor
        colourSelectionIV15.contentMode = .center
        colourSelectionIV16.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV16.tintColor = attentionTextColor
        colourSelectionIV16.contentMode = .center
        colourSelectionIV17.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV17.tintColor = attentionTextColor
        colourSelectionIV17.contentMode = .center
        colourSelectionIV18.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV18.tintColor = attentionTextColor
        colourSelectionIV18.contentMode = .center
        colourSelectionIV19.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV19.tintColor = attentionTextColor
        colourSelectionIV19.contentMode = .center
        colourSelectionIV20.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV20.tintColor = attentionTextColor
        colourSelectionIV20.contentMode = .center
        colourSelectionIV21.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV21.tintColor = attentionTextColor
        colourSelectionIV21.contentMode = .center
        colourSelectionIV22.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV22.tintColor = attentionTextColor
        colourSelectionIV22.contentMode = .center
        
        colourSelectionIV23.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV23.tintColor = attentionTextColor
        colourSelectionIV23.contentMode = .center
        colourSelectionIV24.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV24.tintColor = attentionTextColor
        colourSelectionIV24.contentMode = .center
        colourSelectionIV25.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV25.tintColor = attentionTextColor
        colourSelectionIV25.contentMode = .center
        colourSelectionIV26.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV26.tintColor = attentionTextColor
        colourSelectionIV26.contentMode = .center
        colourSelectionIV27.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV27.tintColor = attentionTextColor
        colourSelectionIV27.contentMode = .center
        colourSelectionIV28.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV28.tintColor = attentionTextColor
        colourSelectionIV28.contentMode = .center
        colourSelectionIV29.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV29.tintColor = attentionTextColor
        colourSelectionIV29.contentMode = .center
        colourSelectionIV30.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV30.tintColor = attentionTextColor
        colourSelectionIV30.contentMode = .center
        colourSelectionIV31.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV31.tintColor = attentionTextColor
        colourSelectionIV31.contentMode = .center
        colourSelectionIV32.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV32.tintColor = attentionTextColor
        colourSelectionIV32.contentMode = .center
        colourSelectionIV33.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV33.tintColor = attentionTextColor
        colourSelectionIV33.contentMode = .center
        
        colourSelectionIV34.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV34.tintColor = attentionTextColor
        colourSelectionIV34.contentMode = .center
        colourSelectionIV35.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV35.tintColor = attentionTextColor
        colourSelectionIV35.contentMode = .center
        colourSelectionIV36.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV36.tintColor = attentionTextColor
        colourSelectionIV36.contentMode = .center
        colourSelectionIV37.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV37.tintColor = attentionTextColor
        colourSelectionIV37.contentMode = .center
        colourSelectionIV38.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV38.tintColor = attentionTextColor
        colourSelectionIV38.contentMode = .center
        colourSelectionIV39.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV39.tintColor = attentionTextColor
        colourSelectionIV39.contentMode = .center
        colourSelectionIV40.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV40.tintColor = attentionTextColor
        colourSelectionIV40.contentMode = .center
        colourSelectionIV41.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV41.tintColor = attentionTextColor
        colourSelectionIV41.contentMode = .center
        colourSelectionIV42.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV42.tintColor = attentionTextColor
        colourSelectionIV42.contentMode = .center
        colourSelectionIV43.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV43.tintColor = attentionTextColor
        colourSelectionIV43.contentMode = .center
        colourSelectionIV44.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV44.tintColor = attentionTextColor
        colourSelectionIV44.contentMode = .center
        
        colourSelectionIV45.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV45.tintColor = attentionTextColor
        colourSelectionIV45.contentMode = .center
        colourSelectionIV46.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV46.tintColor = attentionTextColor
        colourSelectionIV46.contentMode = .center
        colourSelectionIV47.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV47.tintColor = attentionTextColor
        colourSelectionIV47.contentMode = .center
        colourSelectionIV48.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV48.tintColor = attentionTextColor
        colourSelectionIV48.contentMode = .center
        colourSelectionIV49.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV49.tintColor = attentionTextColor
        colourSelectionIV49.contentMode = .center
        colourSelectionIV50.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV50.tintColor = attentionTextColor
        colourSelectionIV50.contentMode = .center
        colourSelectionIV51.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV51.tintColor = attentionTextColor
        colourSelectionIV51.contentMode = .center
        colourSelectionIV52.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV52.tintColor = attentionTextColor
        colourSelectionIV52.contentMode = .center
        colourSelectionIV53.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV53.tintColor = attentionTextColor
        colourSelectionIV53.contentMode = .center
        colourSelectionIV54.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV54.tintColor = attentionTextColor
        colourSelectionIV54.contentMode = .center
        colourSelectionIV55.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV55.tintColor = attentionTextColor
        colourSelectionIV55.contentMode = .center
        
        colourSelectionIV56.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV56.tintColor = attentionTextColor
        colourSelectionIV56.contentMode = .center
        colourSelectionIV57.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV57.tintColor = attentionTextColor
        colourSelectionIV57.contentMode = .center
        colourSelectionIV58.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV58.tintColor = attentionTextColor
        colourSelectionIV58.contentMode = .center
        colourSelectionIV59.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV59.tintColor = attentionTextColor
        colourSelectionIV59.contentMode = .center
        colourSelectionIV60.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV60.tintColor = attentionTextColor
        colourSelectionIV60.contentMode = .center
        colourSelectionIV61.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV61.tintColor = attentionTextColor
        colourSelectionIV61.contentMode = .center
        colourSelectionIV62.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV62.tintColor = attentionTextColor
        colourSelectionIV62.contentMode = .center
        colourSelectionIV63.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV63.tintColor = attentionTextColor
        colourSelectionIV63.contentMode = .center
        colourSelectionIV64.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV64.tintColor = attentionTextColor
        colourSelectionIV64.contentMode = .center
        colourSelectionIV65.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV65.tintColor = attentionTextColor
        colourSelectionIV65.contentMode = .center
        colourSelectionIV66.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV66.tintColor = attentionTextColor
        colourSelectionIV66.contentMode = .center
        
        colourSelectionIV67.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV67.tintColor = attentionTextColor
        colourSelectionIV67.contentMode = .center
        colourSelectionIV68.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV68.tintColor = attentionTextColor
        colourSelectionIV68.contentMode = .center
        colourSelectionIV69.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV69.tintColor = attentionTextColor
        colourSelectionIV69.contentMode = .center
        colourSelectionIV70.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV70.tintColor = attentionTextColor
        colourSelectionIV70.contentMode = .center
        colourSelectionIV71.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV71.tintColor = attentionTextColor
        colourSelectionIV71.contentMode = .center
        colourSelectionIV72.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV72.tintColor = attentionTextColor
        colourSelectionIV72.contentMode = .center
        colourSelectionIV73.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV73.tintColor = attentionTextColor
        colourSelectionIV73.contentMode = .center
        colourSelectionIV74.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV74.tintColor = attentionTextColor
        colourSelectionIV74.contentMode = .center
        colourSelectionIV75.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV75.tintColor = attentionTextColor
        colourSelectionIV75.contentMode = .center
        colourSelectionIV76.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV76.tintColor = attentionTextColor
        colourSelectionIV76.contentMode = .center
        colourSelectionIV77.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV77.tintColor = attentionTextColor
        colourSelectionIV77.contentMode = .center
        
        
        colourSelectionIV78.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV78.tintColor = attentionTextColor
        colourSelectionIV78.contentMode = .center
        colourSelectionIV79.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV79.tintColor = attentionTextColor
        colourSelectionIV79.contentMode = .center
        colourSelectionIV80.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV80.tintColor = attentionTextColor
        colourSelectionIV80.contentMode = .center
        colourSelectionIV81.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV81.tintColor = attentionTextColor
        colourSelectionIV81.contentMode = .center
        colourSelectionIV82.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV82.tintColor = attentionTextColor
        colourSelectionIV82.contentMode = .center
        colourSelectionIV83.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV83.tintColor = attentionTextColor
        colourSelectionIV83.contentMode = .center
        colourSelectionIV84.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV84.tintColor = attentionTextColor
        colourSelectionIV84.contentMode = .center
        colourSelectionIV85.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV85.tintColor = attentionTextColor
        colourSelectionIV85.contentMode = .center
        colourSelectionIV86.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV86.tintColor = attentionTextColor
        colourSelectionIV86.contentMode = .center
        colourSelectionIV87.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV87.tintColor = attentionTextColor
        colourSelectionIV87.contentMode = .center
        colourSelectionIV88.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV88.tintColor = attentionTextColor
        colourSelectionIV88.contentMode = .center
        
        
        colourSelectionIV89.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV89.tintColor = attentionTextColor
        colourSelectionIV89.contentMode = .center
        colourSelectionIV90.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV90.tintColor = attentionTextColor
        colourSelectionIV90.contentMode = .center
        colourSelectionIV91.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV91.tintColor = attentionTextColor
        colourSelectionIV91.contentMode = .center
        colourSelectionIV92.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV92.tintColor = attentionTextColor
        colourSelectionIV92.contentMode = .center
        colourSelectionIV93.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV93.tintColor = attentionTextColor
        colourSelectionIV93.contentMode = .center
        colourSelectionIV94.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV94.tintColor = attentionTextColor
        colourSelectionIV94.contentMode = .center
        colourSelectionIV95.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV95.tintColor = attentionTextColor
        colourSelectionIV95.contentMode = .center
        colourSelectionIV96.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV96.tintColor = attentionTextColor
        colourSelectionIV96.contentMode = .center
        colourSelectionIV97.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV97.tintColor = attentionTextColor
        colourSelectionIV97.contentMode = .center
        colourSelectionIV98.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV98.tintColor = attentionTextColor
        colourSelectionIV98.contentMode = .center
        colourSelectionIV99.image = UIImage(named: "ColorPickCalendarSelected")?.withRenderingMode(.alwaysTemplate)
        colourSelectionIV99.tintColor = attentionTextColor
        colourSelectionIV99.contentMode = .center
        
        
        //BEGIN - Setup colour plaques
        colourIV0.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV0.tintColor = calendarColorPicker0
        colourIV0.contentMode = .center
        
        colourIV1.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV1.tintColor = calendarColorPicker1
        colourIV1.contentMode = .center
        
        colourIV2.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV2.tintColor = calendarColorPicker2
        colourIV2.contentMode = .center
        
        colourIV3.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV3.tintColor = calendarColorPicker3
        colourIV3.contentMode = .center
        
        colourIV4.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV4.tintColor = calendarColorPicker4
        colourIV4.contentMode = .center
        
        colourIV5.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV5.tintColor = calendarColorPicker5
        colourIV5.contentMode = .center
        
        colourIV6.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV6.tintColor = calendarColorPicker6
        colourIV6.contentMode = .center
        
        colourIV7.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV7.tintColor = calendarColorPicker7
        colourIV7.contentMode = .center
        
        colourIV8.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV8.tintColor = calendarColorPicker8
        colourIV8.contentMode = .center
        
        colourIV9.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV9.tintColor = calendarColorPicker9
        colourIV9.contentMode = .center
        
        colourIV10.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV10.tintColor = calendarColorPicker10
        colourIV10.contentMode = .center
        
        colourIV11.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV11.tintColor = calendarColorPicker11
        colourIV11.contentMode = .center
        
        colourIV12.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV12.tintColor = calendarColorPicker12
        colourIV12.contentMode = .center
        colourIV13.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV13.tintColor = calendarColorPicker13
        colourIV13.contentMode = .center
        colourIV14.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV14.tintColor = calendarColorPicker14
        colourIV14.contentMode = .center
        colourIV15.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV15.tintColor = calendarColorPicker15
        colourIV15.contentMode = .center
        colourIV16.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV16.tintColor = calendarColorPicker16
        colourIV16.contentMode = .center
        colourIV17.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV17.tintColor = calendarColorPicker17
        colourIV17.contentMode = .center
        colourIV18.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV18.tintColor = calendarColorPicker18
        colourIV18.contentMode = .center
        colourIV19.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV19.tintColor = calendarColorPicker19
        colourIV19.contentMode = .center
        colourIV20.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV20.tintColor = calendarColorPicker20
        colourIV20.contentMode = .center
        colourIV21.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV21.tintColor = calendarColorPicker21
        colourIV21.contentMode = .center
        colourIV22.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV22.tintColor = calendarColorPicker22
        colourIV22.contentMode = .center
        
        colourIV23.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV23.tintColor = calendarColorPicker23
        colourIV23.contentMode = .center
        colourIV24.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV24.tintColor = calendarColorPicker24
        colourIV24.contentMode = .center
        colourIV25.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV25.tintColor = calendarColorPicker25
        colourIV25.contentMode = .center
        colourIV26.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV26.tintColor = calendarColorPicker26
        colourIV26.contentMode = .center
        colourIV27.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV27.tintColor = calendarColorPicker27
        colourIV27.contentMode = .center
        colourIV28.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV28.tintColor = calendarColorPicker28
        colourIV28.contentMode = .center
        colourIV29.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV29.tintColor = calendarColorPicker29
        colourIV29.contentMode = .center
        colourIV30.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV30.tintColor = calendarColorPicker30
        colourIV30.contentMode = .center
        colourIV31.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV31.tintColor = calendarColorPicker31
        colourIV31.contentMode = .center
        colourIV32.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV32.tintColor = calendarColorPicker32
        colourIV32.contentMode = .center
        colourIV33.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV33.tintColor = calendarColorPicker33
        colourIV33.contentMode = .center
        
        colourIV34.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV34.tintColor = calendarColorPicker34
        colourIV34.contentMode = .center
        colourIV35.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV35.tintColor = calendarColorPicker35
        colourIV35.contentMode = .center
        colourIV36.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV36.tintColor = calendarColorPicker36
        colourIV36.contentMode = .center
        colourIV37.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV37.tintColor = calendarColorPicker37
        colourIV37.contentMode = .center
        colourIV38.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV38.tintColor = calendarColorPicker38
        colourIV38.contentMode = .center
        colourIV39.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV39.tintColor = calendarColorPicker39
        colourIV39.contentMode = .center
        colourIV40.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV40.tintColor = calendarColorPicker40
        colourIV40.contentMode = .center
        colourIV41.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV41.tintColor = calendarColorPicker41
        colourIV41.contentMode = .center
        colourIV42.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV42.tintColor = calendarColorPicker42
        colourIV42.contentMode = .center
        colourIV43.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV43.tintColor = calendarColorPicker43
        colourIV43.contentMode = .center
        colourIV44.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV44.tintColor = calendarColorPicker44
        colourIV44.contentMode = .center
        
        colourIV45.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV45.tintColor = calendarColorPicker45
        colourIV45.contentMode = .center
        colourIV46.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV46.tintColor = calendarColorPicker46
        colourIV46.contentMode = .center
        colourIV47.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV47.tintColor = calendarColorPicker47
        colourIV47.contentMode = .center
        colourIV48.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV48.tintColor = calendarColorPicker48
        colourIV48.contentMode = .center
        colourIV49.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV49.tintColor = calendarColorPicker49
        colourIV49.contentMode = .center
        colourIV50.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV50.tintColor = calendarColorPicker50
        colourIV50.contentMode = .center
        colourIV51.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV51.tintColor = calendarColorPicker51
        colourIV51.contentMode = .center
        colourIV52.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV52.tintColor = calendarColorPicker52
        colourIV52.contentMode = .center
        colourIV53.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV53.tintColor = calendarColorPicker53
        colourIV53.contentMode = .center
        colourIV54.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV54.tintColor = calendarColorPicker54
        colourIV54.contentMode = .center
        colourIV55.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV55.tintColor = calendarColorPicker55
        colourIV55.contentMode = .center
        
        colourIV56.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV56.tintColor = calendarColorPicker56
        colourIV56.contentMode = .center
        colourIV57.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV57.tintColor = calendarColorPicker57
        colourIV57.contentMode = .center
        colourIV58.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV58.tintColor = calendarColorPicker58
        colourIV58.contentMode = .center
        colourIV59.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV59.tintColor = calendarColorPicker59
        colourIV59.contentMode = .center
        colourIV60.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV60.tintColor = calendarColorPicker60
        colourIV60.contentMode = .center
        colourIV61.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV61.tintColor = calendarColorPicker61
        colourIV61.contentMode = .center
        colourIV62.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV62.tintColor = calendarColorPicker62
        colourIV62.contentMode = .center
        colourIV63.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV63.tintColor = calendarColorPicker63
        colourIV63.contentMode = .center
        colourIV64.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV64.tintColor = calendarColorPicker64
        colourIV64.contentMode = .center
        colourIV65.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV65.tintColor = calendarColorPicker65
        colourIV65.contentMode = .center
        colourIV66.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV66.tintColor = calendarColorPicker66
        colourIV66.contentMode = .center
        
        colourIV67.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV67.tintColor = calendarColorPicker67
        colourIV67.contentMode = .center
        colourIV68.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV68.tintColor = calendarColorPicker68
        colourIV68.contentMode = .center
        colourIV69.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV69.tintColor = calendarColorPicker69
        colourIV69.contentMode = .center
        colourIV70.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV70.tintColor = calendarColorPicker70
        colourIV70.contentMode = .center
        colourIV71.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV71.tintColor = calendarColorPicker71
        colourIV71.contentMode = .center
        colourIV72.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV72.tintColor = calendarColorPicker72
        colourIV72.contentMode = .center
        colourIV73.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV73.tintColor = calendarColorPicker73
        colourIV73.contentMode = .center
        colourIV74.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV74.tintColor = calendarColorPicker74
        colourIV74.contentMode = .center
        colourIV75.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV75.tintColor = calendarColorPicker75
        colourIV75.contentMode = .center
        colourIV76.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV76.tintColor = calendarColorPicker76
        colourIV76.contentMode = .center
        colourIV77.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV77.tintColor = calendarColorPicker77
        colourIV77.contentMode = .center
        
        colourIV78.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV78.tintColor = calendarColorPicker78
        colourIV78.contentMode = .center
        colourIV79.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV79.tintColor = calendarColorPicker79
        colourIV79.contentMode = .center
        colourIV80.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV80.tintColor = calendarColorPicker80
        colourIV80.contentMode = .center
        colourIV81.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV81.tintColor = calendarColorPicker81
        colourIV81.contentMode = .center
        colourIV82.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV82.tintColor = calendarColorPicker82
        colourIV82.contentMode = .center
        colourIV83.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV83.tintColor = calendarColorPicker83
        colourIV83.contentMode = .center
        colourIV84.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV84.tintColor = calendarColorPicker84
        colourIV84.contentMode = .center
        colourIV85.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV85.tintColor = calendarColorPicker85
        colourIV85.contentMode = .center
        colourIV86.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV86.tintColor = calendarColorPicker86
        colourIV86.contentMode = .center
        colourIV87.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV87.tintColor = calendarColorPicker87
        colourIV87.contentMode = .center
        colourIV88.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV88.tintColor = calendarColorPicker88
        colourIV88.contentMode = .center
        
        colourIV89.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV89.tintColor = calendarColorPicker89
        colourIV89.contentMode = .center
        colourIV90.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV90.tintColor = calendarColorPicker90
        colourIV90.contentMode = .center
        colourIV91.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV91.tintColor = calendarColorPicker91
        colourIV91.contentMode = .center
        colourIV92.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV92.tintColor = calendarColorPicker92
        colourIV92.contentMode = .center
        colourIV93.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV93.tintColor = calendarColorPicker93
        colourIV93.contentMode = .center
        colourIV94.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV94.tintColor = calendarColorPicker94
        colourIV94.contentMode = .center
        colourIV95.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV95.tintColor = calendarColorPicker95
        colourIV95.contentMode = .center
        colourIV96.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV96.tintColor = calendarColorPicker96
        colourIV96.contentMode = .center
        colourIV97.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV97.tintColor = calendarColorPicker97
        colourIV97.contentMode = .center
        colourIV98.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV98.tintColor = calendarColorPicker98
        colourIV98.contentMode = .center
        colourIV99.image = UIImage(named: "ColorPickCalendar")?.withRenderingMode(.alwaysTemplate)
        colourIV99.tintColor = calendarColorPicker99
        colourIV99.contentMode = .center
    }
    
    
    
    func setCalendarSelection (selectionNumber: Int)
    {
        colourSelectionIV0.isHidden = true
        
        colourSelectionIV1.isHidden = true
        colourSelectionIV2.isHidden = true
        colourSelectionIV3.isHidden = true
        colourSelectionIV4.isHidden = true
        colourSelectionIV5.isHidden = true
        colourSelectionIV6.isHidden = true
        colourSelectionIV7.isHidden = true
        colourSelectionIV8.isHidden = true
        colourSelectionIV9.isHidden = true
        colourSelectionIV10.isHidden = true
        colourSelectionIV11.isHidden = true
        
        colourSelectionIV12.isHidden = true
        colourSelectionIV13.isHidden = true
        colourSelectionIV14.isHidden = true
        colourSelectionIV15.isHidden = true
        colourSelectionIV16.isHidden = true
        colourSelectionIV17.isHidden = true
        colourSelectionIV18.isHidden = true
        colourSelectionIV19.isHidden = true
        colourSelectionIV20.isHidden = true
        colourSelectionIV21.isHidden = true
        colourSelectionIV22.isHidden = true
        
        colourSelectionIV23.isHidden = true
        colourSelectionIV24.isHidden = true
        colourSelectionIV25.isHidden = true
        colourSelectionIV26.isHidden = true
        colourSelectionIV27.isHidden = true
        colourSelectionIV28.isHidden = true
        colourSelectionIV29.isHidden = true
        colourSelectionIV30.isHidden = true
        colourSelectionIV31.isHidden = true
        colourSelectionIV32.isHidden = true
        colourSelectionIV33.isHidden = true
        
        colourSelectionIV34.isHidden = true
        colourSelectionIV35.isHidden = true
        colourSelectionIV36.isHidden = true
        colourSelectionIV37.isHidden = true
        colourSelectionIV38.isHidden = true
        colourSelectionIV39.isHidden = true
        colourSelectionIV40.isHidden = true
        colourSelectionIV41.isHidden = true
        colourSelectionIV42.isHidden = true
        colourSelectionIV43.isHidden = true
        colourSelectionIV44.isHidden = true
        
        colourSelectionIV45.isHidden = true
        colourSelectionIV46.isHidden = true
        colourSelectionIV47.isHidden = true
        colourSelectionIV48.isHidden = true
        colourSelectionIV49.isHidden = true
        colourSelectionIV50.isHidden = true
        colourSelectionIV51.isHidden = true
        colourSelectionIV52.isHidden = true
        colourSelectionIV53.isHidden = true
        colourSelectionIV54.isHidden = true
        colourSelectionIV55.isHidden = true
        
        colourSelectionIV56.isHidden = true
        colourSelectionIV57.isHidden = true
        colourSelectionIV58.isHidden = true
        colourSelectionIV59.isHidden = true
        colourSelectionIV60.isHidden = true
        colourSelectionIV61.isHidden = true
        colourSelectionIV62.isHidden = true
        colourSelectionIV63.isHidden = true
        colourSelectionIV64.isHidden = true
        colourSelectionIV65.isHidden = true
        colourSelectionIV66.isHidden = true
        
        colourSelectionIV67.isHidden = true
        colourSelectionIV68.isHidden = true
        colourSelectionIV69.isHidden = true
        colourSelectionIV70.isHidden = true
        colourSelectionIV71.isHidden = true
        colourSelectionIV72.isHidden = true
        colourSelectionIV73.isHidden = true
        colourSelectionIV74.isHidden = true
        colourSelectionIV75.isHidden = true
        colourSelectionIV76.isHidden = true
        colourSelectionIV77.isHidden = true
        
        colourSelectionIV78.isHidden = true
        colourSelectionIV79.isHidden = true
        colourSelectionIV80.isHidden = true
        colourSelectionIV81.isHidden = true
        colourSelectionIV82.isHidden = true
        colourSelectionIV83.isHidden = true
        colourSelectionIV84.isHidden = true
        colourSelectionIV85.isHidden = true
        colourSelectionIV86.isHidden = true
        colourSelectionIV87.isHidden = true
        colourSelectionIV88.isHidden = true
        
        colourSelectionIV89.isHidden = true
        colourSelectionIV90.isHidden = true
        colourSelectionIV91.isHidden = true
        colourSelectionIV92.isHidden = true
        colourSelectionIV93.isHidden = true
        colourSelectionIV94.isHidden = true
        colourSelectionIV95.isHidden = true
        colourSelectionIV96.isHidden = true
        colourSelectionIV97.isHidden = true
        colourSelectionIV98.isHidden = true
        colourSelectionIV99.isHidden = true
        
        switch selectionNumber {
        case 0:
            colourSelectionIV0.isHidden = false
            reqCalendarColor = calendarColorPicker0.cgColor
        case 1:
            colourSelectionIV1.isHidden = false
            reqCalendarColor = calendarColorPicker1.cgColor
        case 2:
            colourSelectionIV2.isHidden = false
            reqCalendarColor = calendarColorPicker2.cgColor
        case 3:
            colourSelectionIV3.isHidden = false
            reqCalendarColor = calendarColorPicker3.cgColor
        case 4:
            colourSelectionIV4.isHidden = false
            reqCalendarColor = calendarColorPicker4.cgColor
        case 5:
            colourSelectionIV5.isHidden = false
            reqCalendarColor = calendarColorPicker5.cgColor
        case 6:
            colourSelectionIV6.isHidden = false
            reqCalendarColor = calendarColorPicker6.cgColor
        case 7:
            colourSelectionIV7.isHidden = false
            reqCalendarColor = calendarColorPicker7.cgColor
        case 8:
            colourSelectionIV8.isHidden = false
            reqCalendarColor = calendarColorPicker8.cgColor
        case 9:
            colourSelectionIV9.isHidden = false
            reqCalendarColor = calendarColorPicker9.cgColor
        case 10:
            colourSelectionIV10.isHidden = false
            reqCalendarColor = calendarColorPicker10.cgColor
        case 11:
            colourSelectionIV11.isHidden = false
            reqCalendarColor = calendarColorPicker11.cgColor
        case 12:
            colourSelectionIV12.isHidden = false
            reqCalendarColor = calendarColorPicker12.cgColor
        case 13:
            colourSelectionIV13.isHidden = false
            reqCalendarColor = calendarColorPicker13.cgColor
        case 14:
            colourSelectionIV14.isHidden = false
            reqCalendarColor = calendarColorPicker14.cgColor
        case 15:
            colourSelectionIV15.isHidden = false
            reqCalendarColor = calendarColorPicker15.cgColor
        case 16:
            colourSelectionIV16.isHidden = false
            reqCalendarColor = calendarColorPicker16.cgColor
        case 17:
            colourSelectionIV17.isHidden = false
            reqCalendarColor = calendarColorPicker17.cgColor
        case 18:
            colourSelectionIV18.isHidden = false
            reqCalendarColor = calendarColorPicker18.cgColor
        case 19:
            colourSelectionIV19.isHidden = false
            reqCalendarColor = calendarColorPicker19.cgColor
        case 20:
            colourSelectionIV20.isHidden = false
            reqCalendarColor = calendarColorPicker20.cgColor
        case 21:
            colourSelectionIV21.isHidden = false
            reqCalendarColor = calendarColorPicker21.cgColor
        case 22:
            colourSelectionIV22.isHidden = false
            reqCalendarColor = calendarColorPicker22.cgColor
        
        case 23:
            colourSelectionIV23.isHidden = false
            reqCalendarColor = calendarColorPicker23.cgColor
        case 24:
            colourSelectionIV24.isHidden = false
            reqCalendarColor = calendarColorPicker24.cgColor
        case 25:
            colourSelectionIV25.isHidden = false
            reqCalendarColor = calendarColorPicker25.cgColor
        case 26:
            colourSelectionIV26.isHidden = false
            reqCalendarColor = calendarColorPicker26.cgColor
        case 27:
            colourSelectionIV27.isHidden = false
            reqCalendarColor = calendarColorPicker27.cgColor
        case 28:
            colourSelectionIV28.isHidden = false
            reqCalendarColor = calendarColorPicker28.cgColor
        case 29:
            colourSelectionIV29.isHidden = false
            reqCalendarColor = calendarColorPicker29.cgColor
        case 30:
            colourSelectionIV30.isHidden = false
            reqCalendarColor = calendarColorPicker30.cgColor
        case 31:
            colourSelectionIV31.isHidden = false
            reqCalendarColor = calendarColorPicker31.cgColor
        case 32:
            colourSelectionIV32.isHidden = false
            reqCalendarColor = calendarColorPicker32.cgColor
        case 33:
            colourSelectionIV33.isHidden = false
            reqCalendarColor = calendarColorPicker33.cgColor
            
        case 34:
            colourSelectionIV34.isHidden = false
            reqCalendarColor = calendarColorPicker34.cgColor
        case 35:
            colourSelectionIV35.isHidden = false
            reqCalendarColor = calendarColorPicker35.cgColor
        case 36:
            colourSelectionIV36.isHidden = false
            reqCalendarColor = calendarColorPicker36.cgColor
        case 37:
            colourSelectionIV37.isHidden = false
            reqCalendarColor = calendarColorPicker37.cgColor
        case 38:
            colourSelectionIV38.isHidden = false
            reqCalendarColor = calendarColorPicker38.cgColor
        case 39:
            colourSelectionIV39.isHidden = false
            reqCalendarColor = calendarColorPicker39.cgColor
        case 40:
            colourSelectionIV40.isHidden = false
            reqCalendarColor = calendarColorPicker40.cgColor
        case 41:
            colourSelectionIV41.isHidden = false
            reqCalendarColor = calendarColorPicker41.cgColor
        case 42:
            colourSelectionIV42.isHidden = false
            reqCalendarColor = calendarColorPicker42.cgColor
        case 43:
            colourSelectionIV43.isHidden = false
            reqCalendarColor = calendarColorPicker43.cgColor
        case 44:
            colourSelectionIV44.isHidden = false
            reqCalendarColor = calendarColorPicker44.cgColor
            
        case 45:
            colourSelectionIV45.isHidden = false
            reqCalendarColor = calendarColorPicker45.cgColor
        case 46:
            colourSelectionIV46.isHidden = false
            reqCalendarColor = calendarColorPicker46.cgColor
        case 47:
            colourSelectionIV47.isHidden = false
            reqCalendarColor = calendarColorPicker47.cgColor
        case 48:
            colourSelectionIV48.isHidden = false
            reqCalendarColor = calendarColorPicker48.cgColor
        case 49:
            colourSelectionIV49.isHidden = false
            reqCalendarColor = calendarColorPicker49.cgColor
        case 50:
            colourSelectionIV50.isHidden = false
            reqCalendarColor = calendarColorPicker50.cgColor
        case 51:
            colourSelectionIV51.isHidden = false
            reqCalendarColor = calendarColorPicker51.cgColor
        case 52:
            colourSelectionIV52.isHidden = false
            reqCalendarColor = calendarColorPicker52.cgColor
        case 53:
            colourSelectionIV53.isHidden = false
            reqCalendarColor = calendarColorPicker53.cgColor
        case 54:
            colourSelectionIV54.isHidden = false
            reqCalendarColor = calendarColorPicker54.cgColor
        case 55:
            colourSelectionIV55.isHidden = false
            reqCalendarColor = calendarColorPicker55.cgColor
            
        case 56:
            colourSelectionIV56.isHidden = false
            reqCalendarColor = calendarColorPicker56.cgColor
        case 57:
            colourSelectionIV57.isHidden = false
            reqCalendarColor = calendarColorPicker57.cgColor
        case 58:
            colourSelectionIV58.isHidden = false
            reqCalendarColor = calendarColorPicker58.cgColor
        case 59:
            colourSelectionIV59.isHidden = false
            reqCalendarColor = calendarColorPicker59.cgColor
        case 60:
            colourSelectionIV60.isHidden = false
            reqCalendarColor = calendarColorPicker60.cgColor
        case 61:
            colourSelectionIV61.isHidden = false
            reqCalendarColor = calendarColorPicker61.cgColor
        case 62:
            colourSelectionIV62.isHidden = false
            reqCalendarColor = calendarColorPicker62.cgColor
        case 63:
            colourSelectionIV63.isHidden = false
            reqCalendarColor = calendarColorPicker63.cgColor
        case 64:
            colourSelectionIV64.isHidden = false
            reqCalendarColor = calendarColorPicker64.cgColor
        case 65:
            colourSelectionIV65.isHidden = false
            reqCalendarColor = calendarColorPicker65.cgColor
        case 66:
            colourSelectionIV66.isHidden = false
            reqCalendarColor = calendarColorPicker66.cgColor
            
        
        case 67:
            colourSelectionIV67.isHidden = false
            reqCalendarColor = calendarColorPicker67.cgColor
        case 68:
            colourSelectionIV68.isHidden = false
            reqCalendarColor = calendarColorPicker68.cgColor
        case 69:
            colourSelectionIV69.isHidden = false
            reqCalendarColor = calendarColorPicker69.cgColor
        case 70:
            colourSelectionIV70.isHidden = false
            reqCalendarColor = calendarColorPicker70.cgColor
        case 71:
            colourSelectionIV71.isHidden = false
            reqCalendarColor = calendarColorPicker71.cgColor
        case 72:
            colourSelectionIV72.isHidden = false
            reqCalendarColor = calendarColorPicker72.cgColor
        case 73:
            colourSelectionIV73.isHidden = false
            reqCalendarColor = calendarColorPicker73.cgColor
        case 74:
            colourSelectionIV74.isHidden = false
            reqCalendarColor = calendarColorPicker74.cgColor
        case 75:
            colourSelectionIV75.isHidden = false
            reqCalendarColor = calendarColorPicker75.cgColor
        case 76:
            colourSelectionIV76.isHidden = false
            reqCalendarColor = calendarColorPicker76.cgColor
        case 77:
            colourSelectionIV77.isHidden = false
            reqCalendarColor = calendarColorPicker77.cgColor
           
            
        case 78:
            colourSelectionIV78.isHidden = false
            reqCalendarColor = calendarColorPicker78.cgColor
        case 79:
            colourSelectionIV79.isHidden = false
            reqCalendarColor = calendarColorPicker79.cgColor
        case 80:
            colourSelectionIV80.isHidden = false
            reqCalendarColor = calendarColorPicker80.cgColor
        case 81:
            colourSelectionIV81.isHidden = false
            reqCalendarColor = calendarColorPicker81.cgColor
        case 82:
            colourSelectionIV82.isHidden = false
            reqCalendarColor = calendarColorPicker82.cgColor
        case 83:
            colourSelectionIV83.isHidden = false
            reqCalendarColor = calendarColorPicker83.cgColor
        case 84:
            colourSelectionIV84.isHidden = false
            reqCalendarColor = calendarColorPicker84.cgColor
        case 85:
            colourSelectionIV85.isHidden = false
            reqCalendarColor = calendarColorPicker85.cgColor
        case 86:
            colourSelectionIV86.isHidden = false
            reqCalendarColor = calendarColorPicker86.cgColor
        case 87:
            colourSelectionIV87.isHidden = false
            reqCalendarColor = calendarColorPicker87.cgColor
        case 88:
            colourSelectionIV88.isHidden = false
            reqCalendarColor = calendarColorPicker88.cgColor
            
        case 89:
            colourSelectionIV89.isHidden = false
            reqCalendarColor = calendarColorPicker78.cgColor
        case 90:
            colourSelectionIV90.isHidden = false
            reqCalendarColor = calendarColorPicker79.cgColor
        case 91:
            colourSelectionIV91.isHidden = false
            reqCalendarColor = calendarColorPicker80.cgColor
        case 92:
            colourSelectionIV92.isHidden = false
            reqCalendarColor = calendarColorPicker81.cgColor
        case 93:
            colourSelectionIV93.isHidden = false
            reqCalendarColor = calendarColorPicker82.cgColor
        case 94:
            colourSelectionIV94.isHidden = false
            reqCalendarColor = calendarColorPicker83.cgColor
        case 95:
            colourSelectionIV95.isHidden = false
            reqCalendarColor = calendarColorPicker84.cgColor
        case 96:
            colourSelectionIV96.isHidden = false
            reqCalendarColor = calendarColorPicker85.cgColor
        case 97:
            colourSelectionIV97.isHidden = false
            reqCalendarColor = calendarColorPicker86.cgColor
        case 98:
            colourSelectionIV98.isHidden = false
            reqCalendarColor = calendarColorPicker87.cgColor
        case 99:
            colourSelectionIV99.isHidden = false
            reqCalendarColor = calendarColorPicker99.cgColor
        default:
            print ("ERROR -  Calendar Bubble Selection fell Through!")
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("Stop All notification")
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerSegue")
        performSegue(withIdentifier: "TimerSegue", sender: nil)
    }
    //END
    
    
    
    @objc func screenModeHasChanged()
        {
            print ("I updated the screen MODE")
            setupCalendarColours()
            updateScreen()
            setCalendarSelection (selectionNumber: requestedColourSelection)
        }
    
    
    
    
    override func viewWillAppear(_ animated: Bool){
        print ("Calendar Edit View Appear")
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in settings screen
        eventAccessApproved = EventStoreAuthorizations()
        photoAccessApproved = PhotoAuthorizations()
        updateScreen()
        
        reqCalendarName = getCalendarName(calendarID: calendarSelectedID)
        calendarColorPicker0 = UIColor(cgColor: getCalendarColour(calendarID: calendarSelectedID))
        setupCalendarColours() //This line needs to sit here after the calendarColorPicker0, has been initialsed with selected calendar
        setCalendarSelection (selectionNumber: requestedColourSelection)// Do any additional setup after loading the view.
        if userWantToCreateNewCalendar {
            calendarName!.text = NSLocalizedString("New Calendar", comment: "")
        }
        else
        {
            calendarName!.text = getCalendarName(calendarID: calendarSelectedID)
        }
        updateCalendarNameInputField()
        reqCalendarColor = getCalendarColour(calendarID: calendarSelectedID)
        
        updateCalendarNameInputField()
        //colourSelectionView0.backgroundColor = UIColor(cgColor: reqCalendarColor)
        
    }
    
    func updateScreen(){
        topHeaderLbl.textColor = mainTextColor
        if userWantToCreateNewCalendar
        {
            topHeaderLbl.text = NSLocalizedString("Create Calendar", comment: "")
        }
        else
        {
            topHeaderLbl.text = NSLocalizedString("Edit Calendar", comment: "")
        }
        topHeaderImg?.image = topHeaderImage
        
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        settingsWindowView!.layer.shadowColor = UIColor.black.cgColor
        settingsWindowView!.layer.shadowOpacity = shadowOpacityView
        settingsWindowView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        settingsWindowView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        settingsWindowView?.backgroundColor    = windowColor
        settingsWindowView?.layer.cornerRadius = cornerRadiusWindow
        settingsWindowView?.layer.borderWidth  = borderWidthWindow
        settingsWindowView?.layer.borderColor  = borderColor.cgColor
        
        backgroundImageView?.image = backgroundImage
        
        
        calendarName!.layer.borderWidth  = 1
        calendarName!.layer.borderColor = subTextColor.cgColor
        calendarName!.backgroundColor = windowColor
        calendarName?.attributedPlaceholder = NSAttributedString(string: (NSLocalizedString("Type the name of your Calendar here!", comment: "")), attributes: [NSAttributedString.Key.foregroundColor : subTextColor])
        calendarName!.textColor = mainTextColor
        
        calendarColorLbl.textColor = mainTextColor
        calendarColorLbl.text = NSLocalizedString("Calendar Colour", comment: "")
        
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
        
        colourSelectionBtn0.setTitle("", for: .normal)
        colourSelectionBtn1.setTitle("", for: .normal)
        colourSelectionBtn2.setTitle("", for: .normal)
        colourSelectionBtn3.setTitle("", for: .normal)
        colourSelectionBtn4.setTitle("", for: .normal)
        colourSelectionBtn5.setTitle("", for: .normal)
        colourSelectionBtn6.setTitle("", for: .normal)
        colourSelectionBtn7.setTitle("", for: .normal)
        colourSelectionBtn8.setTitle("", for: .normal)
        colourSelectionBtn9.setTitle("", for: .normal)
        colourSelectionBtn10.setTitle("", for: .normal)
        colourSelectionBtn11.setTitle("", for: .normal)
        
        colourSelectionBtn12.setTitle("", for: .normal)
        colourSelectionBtn13.setTitle("", for: .normal)
        colourSelectionBtn14.setTitle("", for: .normal)
        colourSelectionBtn15.setTitle("", for: .normal)
        colourSelectionBtn16.setTitle("", for: .normal)
        colourSelectionBtn17.setTitle("", for: .normal)
        colourSelectionBtn18.setTitle("", for: .normal)
        colourSelectionBtn19.setTitle("", for: .normal)
        colourSelectionBtn20.setTitle("", for: .normal)
        colourSelectionBtn21.setTitle("", for: .normal)
        colourSelectionBtn22.setTitle("", for: .normal)
        
        colourSelectionBtn23.setTitle("", for: .normal)
        colourSelectionBtn24.setTitle("", for: .normal)
        colourSelectionBtn25.setTitle("", for: .normal)
        colourSelectionBtn26.setTitle("", for: .normal)
        colourSelectionBtn27.setTitle("", for: .normal)
        colourSelectionBtn28.setTitle("", for: .normal)
        colourSelectionBtn29.setTitle("", for: .normal)
        colourSelectionBtn30.setTitle("", for: .normal)
        colourSelectionBtn31.setTitle("", for: .normal)
        colourSelectionBtn32.setTitle("", for: .normal)
        colourSelectionBtn33.setTitle("", for: .normal)
       
        colourSelectionBtn34.setTitle("", for: .normal)
        colourSelectionBtn35.setTitle("", for: .normal)
        colourSelectionBtn36.setTitle("", for: .normal)
        colourSelectionBtn37.setTitle("", for: .normal)
        colourSelectionBtn38.setTitle("", for: .normal)
        colourSelectionBtn39.setTitle("", for: .normal)
        colourSelectionBtn40.setTitle("", for: .normal)
        colourSelectionBtn41.setTitle("", for: .normal)
        colourSelectionBtn42.setTitle("", for: .normal)
        colourSelectionBtn43.setTitle("", for: .normal)
        colourSelectionBtn44.setTitle("", for: .normal)
        
        colourSelectionBtn45.setTitle("", for: .normal)
        colourSelectionBtn46.setTitle("", for: .normal)
        colourSelectionBtn47.setTitle("", for: .normal)
        colourSelectionBtn48.setTitle("", for: .normal)
        colourSelectionBtn49.setTitle("", for: .normal)
        colourSelectionBtn50.setTitle("", for: .normal)
        colourSelectionBtn51.setTitle("", for: .normal)
        colourSelectionBtn52.setTitle("", for: .normal)
        colourSelectionBtn53.setTitle("", for: .normal)
        colourSelectionBtn54.setTitle("", for: .normal)
        colourSelectionBtn55.setTitle("", for: .normal)
        
        colourSelectionBtn56.setTitle("", for: .normal)
        colourSelectionBtn57.setTitle("", for: .normal)
        colourSelectionBtn58.setTitle("", for: .normal)
        colourSelectionBtn59.setTitle("", for: .normal)
        colourSelectionBtn60.setTitle("", for: .normal)
        colourSelectionBtn61.setTitle("", for: .normal)
        colourSelectionBtn62.setTitle("", for: .normal)
        colourSelectionBtn63.setTitle("", for: .normal)
        colourSelectionBtn64.setTitle("", for: .normal)
        colourSelectionBtn65.setTitle("", for: .normal)
        colourSelectionBtn66.setTitle("", for: .normal)
        
        colourSelectionBtn67.setTitle("", for: .normal)
        colourSelectionBtn68.setTitle("", for: .normal)
        colourSelectionBtn69.setTitle("", for: .normal)
        colourSelectionBtn70.setTitle("", for: .normal)
        colourSelectionBtn71.setTitle("", for: .normal)
        colourSelectionBtn72.setTitle("", for: .normal)
        colourSelectionBtn73.setTitle("", for: .normal)
        colourSelectionBtn74.setTitle("", for: .normal)
        colourSelectionBtn75.setTitle("", for: .normal)
        colourSelectionBtn76.setTitle("", for: .normal)
        colourSelectionBtn77.setTitle("", for: .normal)
        
        
        colourSelectionBtn78.setTitle("", for: .normal)
        colourSelectionBtn79.setTitle("", for: .normal)
        colourSelectionBtn80.setTitle("", for: .normal)
        colourSelectionBtn81.setTitle("", for: .normal)
        colourSelectionBtn82.setTitle("", for: .normal)
        colourSelectionBtn83.setTitle("", for: .normal)
        colourSelectionBtn84.setTitle("", for: .normal)
        colourSelectionBtn85.setTitle("", for: .normal)
        colourSelectionBtn86.setTitle("", for: .normal)
        colourSelectionBtn87.setTitle("", for: .normal)
        colourSelectionBtn88.setTitle("", for: .normal)
        
        colourSelectionBtn89.setTitle("", for: .normal)
        colourSelectionBtn90.setTitle("", for: .normal)
        colourSelectionBtn91.setTitle("", for: .normal)
        colourSelectionBtn92.setTitle("", for: .normal)
        colourSelectionBtn93.setTitle("", for: .normal)
        colourSelectionBtn94.setTitle("", for: .normal)
        colourSelectionBtn95.setTitle("", for: .normal)
        colourSelectionBtn96.setTitle("", for: .normal)
        colourSelectionBtn97.setTitle("", for: .normal)
        colourSelectionBtn98.setTitle("", for: .normal)
        colourSelectionBtn99.setTitle("", for: .normal)
        if userWantToCreateNewCalendar == false
        {
            //The first colour picker becomes the current calendar colour it has when modifying it, so user can go back to this colour.
            reqCalendarColor = getCalendarColour(calendarID: calendarSelectedID)
            calendarColorPicker0 = UIColor(cgColor: reqCalendarColor)
            
        }
    }
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close View")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func OKPressed()
    {
        if calendarName!.text!.count > 0
        {
            reqCalendarName  = calendarName!.text!
        }
        else
        {
            reqCalendarName = NSLocalizedString("New Calendar", comment: "")
            reqCalendarColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
       
        }
        
        if userWantToCreateNewCalendar {
            createNewCalendar(withName:reqCalendarName, withColor: reqCalendarColor)
        
        }
        else
        {
            updateCalendar()
        }
            
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateCalendarNameInputField() {
        if calendarName!.text!.count > 0 //Only do a search if there are more than 2 characters input, to prevent a slow delay
        {
            self.calendarName!.layer.borderWidth = textfieldBorderWidthNormal
            self.calendarName!.layer.cornerRadius = textfieldRadius
            self.calendarName!.layer.borderColor = mainTextColor.cgColor
        }
        else
        {
            self.calendarName!.layer.borderWidth = textfieldBorderWidthHighlight
            self.calendarName!.layer.cornerRadius = textfieldRadius
            self.calendarName!.layer.borderColor = attentionTextColor.cgColor
        }
        
    }
    
    @IBAction func closeKeyboard(_ sender: Any) {
        print ("Close the keyboard")
        
    }
    
    @IBAction func updateCalendar()
    {
        if eventAccessApproved {
            let calendarStore = EKEvent.init(eventStore: eventStore)
            calendarStore.calendar = eventStore.calendar(withIdentifier: calendarSelectedID)
            //calendarStore.calendar.cgColor = UIColor(red: 0.2, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
            calendarStore.calendar.cgColor = reqCalendarColor
            
            calendarStore.calendar.title = reqCalendarName
            do
            {
                try eventStore.saveCalendar(calendarStore.calendar, commit: true)
            }
            catch
            {
                print("ERROR - Saving the Calendar")
            }
        }
    }
      
    @IBAction func colourPickerPressed(_ sender: UIButton)
    {
        requestedColourSelection = sender.tag
        setCalendarSelection (selectionNumber: requestedColourSelection)
    }

    
    
    func createNewCalendar(withName: String, withColor: CGColor) {
        if eventAccessApproved {
            let calendar = EKCalendar(for: .event, eventStore: eventStore)
            
            calendar.title = withName
            calendar.cgColor = withColor
            
            guard let source = bestPossibleEKSource() else {
                return // source is required, otherwise calendar cannot be saved
            }
            calendar.source = source
            try! eventStore.saveCalendar(calendar, commit: true)
        }
   }
    
    func bestPossibleEKSource() -> EKSource? {
        
        let `default` = eventStore.defaultCalendarForNewEvents?.source
        let iCloud = eventStore.sources.first(where: { $0.title == "iCloud" }) // this is fragile, user can rename the source
        let local = eventStore.sources.first(where: { $0.sourceType == .local })
        
        return `default` ?? iCloud ?? local
    }

}

