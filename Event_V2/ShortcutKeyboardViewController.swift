//
//  ShortcutKeyboardViewController.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 10/8/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

var undoStringArray :[String] = [""]

class ShortcutKeyboardViewController: UIViewController {
    //var undoCharacter:Int = 1
    @IBOutlet var keyboardBackgroundView: UIView!
    @IBOutlet var row1Key1View: UIView!
    @IBOutlet var row1Key2View: UIView!
    @IBOutlet var row1Key3View: UIView!
    @IBOutlet var row1Key4View: UIView!
    @IBOutlet var row1Key5View: UIView!
    @IBOutlet var row1Key6View: UIView!
   
    @IBOutlet var row2Key1View: UIView!
    @IBOutlet var row2Key2View: UIView!
    @IBOutlet var row2Key3View: UIView!
    @IBOutlet var row2Key4View: UIView!
    @IBOutlet var row2Key5View: UIView!
    @IBOutlet var row2Key6View: UIView!
  
    @IBOutlet var row3Key1View: UIView!
    @IBOutlet var row3Key2View: UIView!
    @IBOutlet var row3Key3View: UIView!
    @IBOutlet var row3Key4View: UIView!
    @IBOutlet var row3Key5View: UIView!
    @IBOutlet var row3Key6View: UIView!
    
    @IBOutlet var row4Key1View: UIView!
    @IBOutlet var row4Key2View: UIView!
    @IBOutlet var row4Key3View: UIView!
    @IBOutlet var row4Key4View: UIView!
    @IBOutlet var row4Key5View: UIView!
    @IBOutlet var row4Key6View: UIView!
    
    @IBOutlet var row1Key1Lbl: UILabel!
    @IBOutlet var row1Key2Lbl: UILabel!
    @IBOutlet var row1Key3Lbl: UILabel!
    @IBOutlet var row1Key4Lbl: UILabel!
    @IBOutlet var row1Key5Lbl: UILabel!
   
    @IBOutlet var row2Key1Lbl: UILabel!
    @IBOutlet var row2Key2Lbl: UILabel!
    @IBOutlet var row2Key3Lbl: UILabel!
    @IBOutlet var row2Key4Lbl: UILabel!
    @IBOutlet var row2Key5Lbl: UILabel!
    
    
    @IBOutlet var row3Key1Lbl: UILabel!
    @IBOutlet var row3Key2Lbl: UILabel!
    @IBOutlet var row3Key3Lbl: UILabel!
    @IBOutlet var row3Key4Lbl: UILabel!
    @IBOutlet var row3Key5Lbl: UILabel!
    
    
    @IBOutlet var row4Key1Lbl: UILabel!
    @IBOutlet var row4Key2Lbl: UILabel!
    @IBOutlet var row4Key3Lbl: UILabel!
    @IBOutlet var row4Key4Lbl: UILabel!
    @IBOutlet var row4Key5Lbl: UILabel!
    
    
    @IBOutlet var keyboardEditBtn: UIButton!
    @IBOutlet var keyboardCloseBtn: UIButton!
    @IBOutlet var keyboardDeleteBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateKeyboardText()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateKeyboardText), name: Notification.Name("updateShortcutKeyboardNotification"), object: nil)
        
        row1Key1Lbl.textColor = keyboardTextColor
        row1Key2Lbl.textColor = keyboardTextColor
        row1Key3Lbl.textColor = keyboardTextColor
        row1Key4Lbl.textColor = keyboardTextColor
        row1Key5Lbl.textColor = keyboardTextColor
        
        row2Key1Lbl.textColor = keyboardTextColor
        row2Key2Lbl.textColor = keyboardTextColor
        row2Key3Lbl.textColor = keyboardTextColor
        row2Key4Lbl.textColor = keyboardTextColor
        row2Key5Lbl.textColor = keyboardTextColor
        
        
        row3Key1Lbl.textColor = keyboardTextColor
        row3Key2Lbl.textColor = keyboardTextColor
        row3Key3Lbl.textColor = keyboardTextColor
        row3Key4Lbl.textColor = keyboardTextColor
        row3Key5Lbl.textColor = keyboardTextColor
        
        
        row4Key1Lbl.textColor = keyboardTextColor
        row4Key2Lbl.textColor = keyboardTextColor
        row4Key3Lbl.textColor = keyboardTextColor
        row4Key4Lbl.textColor = keyboardTextColor
        row4Key5Lbl.textColor = keyboardTextColor
        
        
        keyboardBackgroundView?.backgroundColor = keyboardBackgroundColor
        
        row1Key1View?.backgroundColor    = keyboardKeyColor
        row1Key1View?.layer.cornerRadius = cornerRadiusWindow
        row1Key1View?.layer.borderWidth  = borderWidthWindow
        row1Key1View?.layer.borderColor  = borderColor.cgColor
        
        row1Key2View?.backgroundColor    = keyboardKeyColor
        row1Key2View?.layer.cornerRadius = cornerRadiusWindow
        row1Key2View?.layer.borderWidth  = borderWidthWindow
        row1Key2View?.layer.borderColor  = borderColor.cgColor
        
        row1Key3View?.backgroundColor    = keyboardKeyColor
        row1Key3View?.layer.cornerRadius = cornerRadiusWindow
        row1Key3View?.layer.borderWidth  = borderWidthWindow
        row1Key3View?.layer.borderColor  = borderColor.cgColor
        
        row1Key4View?.backgroundColor    = keyboardKeyColor
        row1Key4View?.layer.cornerRadius = cornerRadiusWindow
        row1Key4View?.layer.borderWidth  = borderWidthWindow
        row1Key4View?.layer.borderColor  = borderColor.cgColor
        
        row1Key5View?.backgroundColor    = keyboardKeyColor
        row1Key5View?.layer.cornerRadius = cornerRadiusWindow
        row1Key5View?.layer.borderWidth  = borderWidthWindow
        row1Key5View?.layer.borderColor  = borderColor.cgColor
        
        row1Key6View?.backgroundColor    = keyboardKeyColor
        row1Key6View?.layer.cornerRadius = cornerRadiusWindow
        row1Key6View?.layer.borderWidth  = borderWidthWindow
        row1Key6View?.layer.borderColor  = borderColor.cgColor
        
        row2Key1View?.backgroundColor    = keyboardKeyColor
        row2Key1View?.layer.cornerRadius = cornerRadiusWindow
        row2Key1View?.layer.borderWidth  = borderWidthWindow
        row2Key1View?.layer.borderColor  = borderColor.cgColor
        
        row2Key2View?.backgroundColor    = keyboardKeyColor
        row2Key2View?.layer.cornerRadius = cornerRadiusWindow
        row2Key2View?.layer.borderWidth  = borderWidthWindow
        row2Key2View?.layer.borderColor  = borderColor.cgColor
        
        row2Key3View?.backgroundColor    = keyboardKeyColor
        row2Key3View?.layer.cornerRadius = cornerRadiusWindow
        row2Key3View?.layer.borderWidth  = borderWidthWindow
        row2Key3View?.layer.borderColor  = borderColor.cgColor
        
        row2Key4View?.backgroundColor    = keyboardKeyColor
        row2Key4View?.layer.cornerRadius = cornerRadiusWindow
        row2Key4View?.layer.borderWidth  = borderWidthWindow
        row2Key4View?.layer.borderColor  = borderColor.cgColor
        
        row2Key5View?.backgroundColor    = keyboardKeyColor
        row2Key5View?.layer.cornerRadius = cornerRadiusWindow
        row2Key5View?.layer.borderWidth  = borderWidthWindow
        row2Key5View?.layer.borderColor  = borderColor.cgColor
        
        row2Key6View?.backgroundColor    = keyboardKeyColor
        row2Key6View?.layer.cornerRadius = cornerRadiusWindow
        row2Key6View?.layer.borderWidth  = borderWidthWindow
        row2Key6View?.layer.borderColor  = borderColor.cgColor
        
        row3Key1View?.backgroundColor    = keyboardKeyColor
        row3Key1View?.layer.cornerRadius = cornerRadiusWindow
        row3Key1View?.layer.borderWidth  = borderWidthWindow
        row3Key1View?.layer.borderColor  = borderColor.cgColor
        
        row3Key2View?.backgroundColor    = keyboardKeyColor
        row3Key2View?.layer.cornerRadius = cornerRadiusWindow
        row3Key2View?.layer.borderWidth  = borderWidthWindow
        row3Key2View?.layer.borderColor  = borderColor.cgColor
        
        row3Key3View?.backgroundColor    = keyboardKeyColor
        row3Key3View?.layer.cornerRadius = cornerRadiusWindow
        row3Key3View?.layer.borderWidth  = borderWidthWindow
        row3Key3View?.layer.borderColor  = borderColor.cgColor
        
        row3Key4View?.backgroundColor    = keyboardKeyColor
        row3Key4View?.layer.cornerRadius = cornerRadiusWindow
        row3Key4View?.layer.borderWidth  = borderWidthWindow
        row3Key4View?.layer.borderColor  = borderColor.cgColor
        
        row3Key5View?.backgroundColor    = keyboardKeyColor
        row3Key5View?.layer.cornerRadius = cornerRadiusWindow
        row3Key5View?.layer.borderWidth  = borderWidthWindow
        row3Key5View?.layer.borderColor  = borderColor.cgColor
        
        row3Key6View?.backgroundColor    = .clear
        //row3Key6View?.layer.cornerRadius = cornerRadiusWindow
        //row3Key6View?.layer.borderWidth  = borderWidthWindow
        //row3Key6View?.layer.borderColor  = borderColor.cgColor
        
        row4Key1View?.backgroundColor    = keyboardKeyColor
        row4Key1View?.layer.cornerRadius = cornerRadiusWindow
        row4Key1View?.layer.borderWidth  = borderWidthWindow
        row4Key1View?.layer.borderColor  = borderColor.cgColor
        
        row4Key2View?.backgroundColor    = keyboardKeyColor
        row4Key2View?.layer.cornerRadius = cornerRadiusWindow
        row4Key2View?.layer.borderWidth  = borderWidthWindow
        row4Key2View?.layer.borderColor  = borderColor.cgColor
        
        row4Key3View?.backgroundColor    = keyboardKeyColor
        row4Key3View?.layer.cornerRadius = cornerRadiusWindow
        row4Key3View?.layer.borderWidth  = borderWidthWindow
        row4Key3View?.layer.borderColor  = borderColor.cgColor
        
        row4Key4View?.backgroundColor    = keyboardKeyColor
        row4Key4View?.layer.cornerRadius = cornerRadiusWindow
        row4Key4View?.layer.borderWidth  = borderWidthWindow
        row4Key4View?.layer.borderColor  = borderColor.cgColor
        
        row4Key5View?.backgroundColor    = keyboardKeyColor
        row4Key5View?.layer.cornerRadius = cornerRadiusWindow
        row4Key5View?.layer.borderWidth  = borderWidthWindow
        row4Key5View?.layer.borderColor  = borderColor.cgColor
        
        row4Key6View?.backgroundColor    = keyboardKeyColor
        row4Key6View?.layer.cornerRadius = cornerRadiusWindow
        row4Key6View?.layer.borderWidth  = borderWidthWindow
        row4Key6View?.layer.borderColor  = borderColor.cgColor
        
        // Do any additional setup after loading the view.
        
        keyboardCloseBtn!.setImage(keyboardCloseImage, for: .normal)
        keyboardCloseBtn!.layer.shadowColor = UIColor.black.cgColor
        keyboardCloseBtn!.layer.shadowOpacity = shadowOpacityButtons
        keyboardCloseBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        keyboardCloseBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
   
        keyboardDeleteBtn!.setImage(keyboardDeleteImage, for: .normal)
        keyboardDeleteBtn!.layer.shadowColor = UIColor.black.cgColor
        keyboardDeleteBtn!.layer.shadowOpacity = shadowOpacityButtons
        keyboardDeleteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        keyboardDeleteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        keyboardEditBtn!.setImage(keyboardEditImage, for: .normal)
        keyboardEditBtn!.layer.shadowColor = UIColor.black.cgColor
        keyboardEditBtn!.layer.shadowOpacity = shadowOpacityButtons
        keyboardEditBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        keyboardEditBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    
    }
    
    @objc func updateKeyboardText() {
        row1Key1Lbl.text = quickPickList1[0]
        row1Key2Lbl.text = quickPickList1[1]
        row1Key3Lbl.text = quickPickList1[2]
        row1Key4Lbl.text = quickPickList1[3]
        row1Key5Lbl.text = quickPickList1[4]
        row2Key1Lbl.text = quickPickList1[6]
        row2Key2Lbl.text = quickPickList1[7]
        row2Key3Lbl.text = quickPickList1[8]
        row2Key4Lbl.text = quickPickList1[9]
        row2Key5Lbl.text = quickPickList1[10]
        row3Key1Lbl.text = quickPickList1[12]
        row3Key2Lbl.text = quickPickList1[13]
        row3Key3Lbl.text = quickPickList1[14]
        row3Key4Lbl.text = quickPickList1[15]
        row3Key5Lbl.text = quickPickList1[16]
        
        row4Key1Lbl.text = quickPickList1[18]
        row4Key2Lbl.text = quickPickList1[19]
        row4Key3Lbl.text = quickPickList1[20]
        row4Key4Lbl.text = quickPickList1[21]
        row4Key5Lbl.text = quickPickList1[22]
        
        
    }
    
    @IBAction func keyPress(_ sender: UIButton) {
        switch (sender.tag) {
        case 11:
            let stringItem = "・" + row1Key1Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row1Key1View?.alpha = 0.5
            }) { (finished) in
                self.row1Key1View?.alpha = 1.0 }
            
        case 12:
            let stringItem = "・" + row1Key2Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row1Key2View?.alpha = 0.5
            }) { (finished) in
                self.row1Key2View?.alpha = 1.0 }
            
        case 13:
            let stringItem = "・" + row1Key3Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row1Key3View?.alpha = 0.5
            }) { (finished) in
                self.row1Key3View?.alpha = 1.0 }
            
        case 14:
            let stringItem = "・" + row1Key4Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row1Key4View?.alpha = 0.5
            }) { (finished) in
                self.row1Key4View?.alpha = 1.0 }
            
        case 15:
            let stringItem = "・" + row1Key5Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row1Key5View?.alpha = 0.5
            }) { (finished) in
                self.row1Key5View?.alpha = 1.0 }
            
        case 16:
            print ("Error - Delete button pressed")
            
        case 21:
            let stringItem = "・" + row2Key1Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row2Key1View?.alpha = 0.5
            }) { (finished) in
                self.row2Key1View?.alpha = 1.0 }
            
        case 22:
            let stringItem = "・" + row2Key2Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row2Key2View?.alpha = 0.5
            }) { (finished) in
                self.row2Key2View?.alpha = 1.0 }
            
        case 23:
            let stringItem = "・" + row2Key3Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row2Key3View?.alpha = 0.5
            }) { (finished) in
                self.row2Key3View?.alpha = 1.0 }
            
        case 24:
            let stringItem = "・" + row2Key4Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row2Key4View?.alpha = 0.5
            }) { (finished) in
                self.row2Key4View?.alpha = 1.0 }
            
        case 25:
            let stringItem = "・" + row2Key5Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row2Key5View?.alpha = 0.5
            }) { (finished) in
                self.row2Key5View?.alpha = 1.0 }
            
        case 26:
            print ("Error - Keyboard Edit")
            
        case 31:
            let stringItem = "・" + row3Key1Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row3Key1View?.alpha = 0.5
            }) { (finished) in
                self.row3Key1View?.alpha = 1.0 }
            
        case 32:
            let stringItem = "・" + row3Key2Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row3Key2View?.alpha = 0.5
            }) { (finished) in
                self.row3Key2View?.alpha = 1.0 }
            
        case 33:
            let stringItem = "・" + row3Key3Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row3Key3View?.alpha = 0.5
            }) { (finished) in
                self.row3Key3View?.alpha = 1.0 }
            
        case 34:
            let stringItem = "・" + row3Key4Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row3Key4View?.alpha = 0.5
            }) { (finished) in
                self.row3Key4View?.alpha = 1.0 }
            
        case 35:
            let stringItem = "・" + row3Key5Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row3Key5View?.alpha = 0.5
            }) { (finished) in
                self.row3Key5View?.alpha = 1.0 }
            
        case 36:
            print ("Error - Spare Key")
            
        case 41:
            let stringItem = "・" + row4Key1Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row4Key1View?.alpha = 0.5
            }) { (finished) in
                self.row4Key1View?.alpha = 1.0 }
            
        case 42:
            let stringItem = "・" + row4Key2Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row4Key2View?.alpha = 0.5
            }) { (finished) in
                self.row4Key2View?.alpha = 1.0 }
            
        case 43:
            let stringItem = "・" + row4Key3Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row4Key3View?.alpha = 0.5
            }) { (finished) in
                self.row4Key3View?.alpha = 1.0 }
            
        case 44:
            let stringItem = "・" + row4Key4Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row4Key4View?.alpha = 0.5
            }) { (finished) in
                self.row4Key4View?.alpha = 1.0 }
           
        case 45:
            let stringItem = "・" + row4Key5Lbl.text!
            undoStringArray.append(stringItem)
            shoppingListTextString = shoppingListTextString + stringItem
            UIView.animate(withDuration: 0.2, animations: {
                self.row4Key5View?.alpha = 0.5
            }) { (finished) in
                self.row4Key5View?.alpha = 1.0 }
            
        
        default:
            print ("ERROR! - keyboard switch fell Through")
            break
        }
        NotificationCenter.default.post(name: Notification.Name("updateShoppingListNotification"), object: nil, userInfo: ["key":"value"])
    }
    
    @IBAction func deleteKeyPress() {
        //var tempString = shoppingListTextString.removeLast()
        if shoppingListTextString.count != 0 {
            shoppingListTextString.removeLast()}
        NotificationCenter.default.post(name: Notification.Name("updateShoppingListNotification"), object: nil, userInfo: ["key":"value"])
    }
    
   
    
    
    @IBAction func closeKeyboard(_ sender: Any) {
        print ("Close the shortcut View")
        
        screenSaverAllowed = true //allow to show the screen saver again once you are out off the settings screen
        //BEGIN - stop and remove the timer
        self.dismiss(animated: true, completion: nil)
        //END
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        print ("--------------View Appear - No screen saver")
        screenSaverAllowed = false
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("View will disappear")
        print ("Stop notification")
        screenSaverAllowed = true
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AlarmNotification"), object: nil)
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerExpiredSegue10")
        performSegue(withIdentifier: "TimerExpiredSegue10", sender: nil)
    }

}
