//
//  EditShortcutKeyboardViewController.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 12/8/20.
//  Copyright © 2020 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

class EditShortcutKeyboardViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var keyBoardBackgroundView: UIView!
    
    @IBOutlet var row1Key1TF: UITextField!
    @IBOutlet var row1Key2TF: UITextField!
    @IBOutlet var row1Key3TF: UITextField!
    @IBOutlet var row1Key4TF: UITextField!
    @IBOutlet var row1Key5TF: UITextField!
    
    @IBOutlet var row2Key1TF: UITextField!
    @IBOutlet var row2Key2TF: UITextField!
    @IBOutlet var row2Key3TF: UITextField!
    @IBOutlet var row2Key4TF: UITextField!
    @IBOutlet var row2Key5TF: UITextField!
    
    @IBOutlet var row3Key1TF: UITextField!
    @IBOutlet var row3Key2TF: UITextField!
    @IBOutlet var row3Key3TF: UITextField!
    @IBOutlet var row3Key4TF: UITextField!
    @IBOutlet var row3Key5TF: UITextField!
    
    
    @IBOutlet var row4Key1TF: UITextField!
    @IBOutlet var row4Key2TF: UITextField!
    @IBOutlet var row4Key3TF: UITextField!
    @IBOutlet var row4Key4TF: UITextField!
    @IBOutlet var row4Key5TF: UITextField!
    
    
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
    
    @IBOutlet var row1Key1IV: UIImageView!
    @IBOutlet var row1Key2IV: UIImageView!
    @IBOutlet var row1Key3IV: UIImageView!
    @IBOutlet var row1Key4IV: UIImageView!
    @IBOutlet var row1Key5IV: UIImageView!
    
    
    @IBOutlet var row2Key1IV: UIImageView!
    @IBOutlet var row2Key2IV: UIImageView!
    @IBOutlet var row2Key3IV: UIImageView!
    @IBOutlet var row2Key4IV: UIImageView!
    @IBOutlet var row2Key5IV: UIImageView!
    
    
    @IBOutlet var row3Key1IV: UIImageView!
    @IBOutlet var row3Key2IV: UIImageView!
    @IBOutlet var row3Key3IV: UIImageView!
    @IBOutlet var row3Key4IV: UIImageView!
    @IBOutlet var row3Key5IV: UIImageView!
    
    @IBOutlet var row4Key1IV: UIImageView!
    @IBOutlet var row4Key2IV: UIImageView!
    @IBOutlet var row4Key3IV: UIImageView!
    @IBOutlet var row4Key4IV: UIImageView!
    @IBOutlet var row4Key5IV: UIImageView!
    
    @IBOutlet var keyboardCloseBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in settings screen
        
        //row1Key1TF.text = quickPickList1[0]
        if (dayMode == true){
            row1Key1TF.keyboardAppearance = UIKeyboardAppearance.light
            row1Key2TF.keyboardAppearance = UIKeyboardAppearance.light
            row1Key3TF.keyboardAppearance = UIKeyboardAppearance.light
            row1Key4TF.keyboardAppearance = UIKeyboardAppearance.light
            row1Key5TF.keyboardAppearance = UIKeyboardAppearance.light
            
            
            row2Key1TF.keyboardAppearance = UIKeyboardAppearance.light
            row2Key2TF.keyboardAppearance = UIKeyboardAppearance.light
            row2Key3TF.keyboardAppearance = UIKeyboardAppearance.light
            row2Key4TF.keyboardAppearance = UIKeyboardAppearance.light
            row2Key5TF.keyboardAppearance = UIKeyboardAppearance.light
            
            
            row3Key1TF.keyboardAppearance = UIKeyboardAppearance.light
            row3Key2TF.keyboardAppearance = UIKeyboardAppearance.light
            row3Key3TF.keyboardAppearance = UIKeyboardAppearance.light
            row3Key4TF.keyboardAppearance = UIKeyboardAppearance.light
            row3Key5TF.keyboardAppearance = UIKeyboardAppearance.light
            
            
            row4Key1TF.keyboardAppearance = UIKeyboardAppearance.light
            row4Key2TF.keyboardAppearance = UIKeyboardAppearance.light
            row4Key3TF.keyboardAppearance = UIKeyboardAppearance.light
            row4Key4TF.keyboardAppearance = UIKeyboardAppearance.light
            row4Key5TF.keyboardAppearance = UIKeyboardAppearance.light
            
        }
        else{
            row1Key1TF.keyboardAppearance = UIKeyboardAppearance.dark
            row1Key2TF.keyboardAppearance = UIKeyboardAppearance.dark
            row1Key3TF.keyboardAppearance = UIKeyboardAppearance.dark
            row1Key4TF.keyboardAppearance = UIKeyboardAppearance.dark
            row1Key5TF.keyboardAppearance = UIKeyboardAppearance.dark
            
            
            row2Key1TF.keyboardAppearance = UIKeyboardAppearance.dark
            row2Key2TF.keyboardAppearance = UIKeyboardAppearance.dark
            row2Key3TF.keyboardAppearance = UIKeyboardAppearance.dark
            row2Key4TF.keyboardAppearance = UIKeyboardAppearance.dark
            row2Key5TF.keyboardAppearance = UIKeyboardAppearance.dark
            
            
            row3Key1TF.keyboardAppearance = UIKeyboardAppearance.dark
            row3Key2TF.keyboardAppearance = UIKeyboardAppearance.dark
            row3Key3TF.keyboardAppearance = UIKeyboardAppearance.dark
            row3Key4TF.keyboardAppearance = UIKeyboardAppearance.dark
            row3Key5TF.keyboardAppearance = UIKeyboardAppearance.dark
            
            
            row4Key1TF.keyboardAppearance = UIKeyboardAppearance.dark
            row4Key2TF.keyboardAppearance = UIKeyboardAppearance.dark
            row4Key3TF.keyboardAppearance = UIKeyboardAppearance.dark
            row4Key4TF.keyboardAppearance = UIKeyboardAppearance.dark
            row4Key5TF.keyboardAppearance = UIKeyboardAppearance.dark
            
        }
        
        row1Key1TF.textColor = keyboardTextColor
        row1Key2TF.textColor = keyboardTextColor
        row1Key3TF.textColor = keyboardTextColor
        row1Key4TF.textColor = keyboardTextColor
        row1Key5TF.textColor = keyboardTextColor
        
        
        row2Key1TF.textColor = keyboardTextColor
        row2Key2TF.textColor = keyboardTextColor
        row2Key3TF.textColor = keyboardTextColor
        row2Key4TF.textColor = keyboardTextColor
        row2Key5TF.textColor = keyboardTextColor
        
        
        row3Key1TF.textColor = keyboardTextColor
        row3Key2TF.textColor = keyboardTextColor
        row3Key3TF.textColor = keyboardTextColor
        row3Key4TF.textColor = keyboardTextColor
        row3Key5TF.textColor = keyboardTextColor
        
        
        row4Key1TF.textColor = keyboardTextColor
        row4Key2TF.textColor = keyboardTextColor
        row4Key3TF.textColor = keyboardTextColor
        row4Key4TF.textColor = keyboardTextColor
        row4Key5TF.textColor = keyboardTextColor
        
        
        row1Key1TF.text = quickPickList1[0]
        row1Key2TF.text = quickPickList1[1]
        row1Key3TF.text = quickPickList1[2]
        row1Key4TF.text = quickPickList1[3]
        row1Key5TF.text = quickPickList1[4]
        
    
        row2Key1TF.text = quickPickList1[6]
        row2Key2TF.text = quickPickList1[7]
        row2Key3TF.text = quickPickList1[8]
        row2Key4TF.text = quickPickList1[9]
        row2Key5TF.text = quickPickList1[10]
        
    
        row3Key1TF.text = quickPickList1[12]
        row3Key2TF.text = quickPickList1[13]
        row3Key3TF.text = quickPickList1[14]
        row3Key4TF.text = quickPickList1[15]
        row3Key5TF.text = quickPickList1[16]
        
    
        row4Key1TF.text = quickPickList1[18]
        row4Key2TF.text = quickPickList1[19]
        row4Key3TF.text = quickPickList1[20]
        row4Key4TF.text = quickPickList1[21]
        row4Key5TF.text = quickPickList1[22]
               
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
        
        row1Key6View?.backgroundColor    = .clear
        
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
        
        row2Key6View?.backgroundColor    = .clear
        
        
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
    
        keyBoardBackgroundView?.backgroundColor    = keyboardBackgroundColor
        
        keyboardCloseBtn!.setImage(keyboardCloseImage, for: .normal)
        keyboardCloseBtn!.layer.shadowColor = UIColor.black.cgColor
        keyboardCloseBtn!.layer.shadowOpacity = shadowOpacityButtons
        keyboardCloseBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        keyboardCloseBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        row1Key1IV.image = editImg
        row1Key2IV.image = editImg
        row1Key3IV.image = editImg
        row1Key4IV.image = editImg
        row1Key5IV.image = editImg
        
        row2Key1IV.image = editImg
        row2Key2IV.image = editImg
        row2Key3IV.image = editImg
        row2Key4IV.image = editImg
        row2Key5IV.image = editImg
        
        row3Key1IV.image = editImg
        row3Key2IV.image = editImg
        row3Key3IV.image = editImg
        row3Key4IV.image = editImg
        row3Key5IV.image = editImg
        
        row4Key1IV.image = editImg
        row4Key2IV.image = editImg
        row4Key3IV.image = editImg
        row4Key4IV.image = editImg
        row4Key5IV.image = editImg
        
        row1Key1TF!.becomeFirstResponder()
        //BEGIN - when keyboard is removed, also close the edit viewcontroller
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        //END
    }
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        print ("View Appear - No screen saver")
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //prevent slide show to start when in settings screen
        
        updateUserKeyboard()
    }
    
    
    
    @IBAction func updateUserKeyboard() {
        print ("Keyboard Update")
        if row1Key1TF.text!.isEmpty {row1Key1IV.isHidden = false}
        else {row1Key1IV.isHidden = true}
        if row1Key2TF.text!.isEmpty {row1Key2IV.isHidden = false}
        else {row1Key2IV.isHidden = true}
        if row1Key3TF.text!.isEmpty {row1Key3IV.isHidden = false}
        else {row1Key3IV.isHidden = true}
        if row1Key4TF.text!.isEmpty {row1Key4IV.isHidden = false}
        else {row1Key4IV.isHidden = true}
        if row1Key5TF.text!.isEmpty {row1Key5IV.isHidden = false}
        else {row1Key5IV.isHidden = true}
        
        if row2Key1TF.text!.isEmpty {row2Key1IV.isHidden = false}
        else {row2Key1IV.isHidden = true}
        if row2Key2TF.text!.isEmpty {row2Key2IV.isHidden = false}
        else {row2Key2IV.isHidden = true}
        if row2Key3TF.text!.isEmpty {row2Key3IV.isHidden = false}
        else {row2Key3IV.isHidden = true}
        if row2Key4TF.text!.isEmpty {row2Key4IV.isHidden = false}
        else {row2Key4IV.isHidden = true}
        if row2Key5TF.text!.isEmpty {row2Key5IV.isHidden = false}
        else {row2Key5IV.isHidden = true}
        
        if row3Key1TF.text!.isEmpty {row3Key1IV.isHidden = false}
        else {row3Key1IV.isHidden = true}
        if row3Key2TF.text!.isEmpty {row3Key2IV.isHidden = false}
        else {row3Key2IV.isHidden = true}
        if row3Key3TF.text!.isEmpty {row3Key3IV.isHidden = false}
        else {row3Key3IV.isHidden = true}
        if row3Key4TF.text!.isEmpty {row3Key4IV.isHidden = false}
        else {row3Key4IV.isHidden = true}
        if row3Key5TF.text!.isEmpty {row3Key5IV.isHidden = false}
        else {row3Key5IV.isHidden = true}
        
        
        if row4Key1TF.text!.isEmpty {row4Key1IV.isHidden = false}
        else {row4Key1IV.isHidden = true}
        if row4Key2TF.text!.isEmpty {row4Key2IV.isHidden = false}
        else {row4Key2IV.isHidden = true}
        if row4Key3TF.text!.isEmpty {row4Key3IV.isHidden = false}
        else {row4Key3IV.isHidden = true}
        if row4Key4TF.text!.isEmpty {row4Key4IV.isHidden = false}
        else {row4Key4IV.isHidden = true}
        if row4Key5TF.text!.isEmpty {row4Key5IV.isHidden = false}
        else {row4Key5IV.isHidden = true}
    }
    
    // calls when textfield becomes 1st responder
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        updateUserKeyboard()
        print ("gffdgdfgfdgfdgdfgdgdgdfgd")
        switch (textField.tag) {
        case 11:
            row1Key1IV.isHidden = true
        case 12:
            row1Key2IV.isHidden = true
        case 13:
            row1Key3IV.isHidden = true
        case 14:
            row1Key4IV.isHidden = true
        case 15:
            row1Key5IV.isHidden = true
        case 21:
            row2Key1IV.isHidden = true
            print ("GFDGFDGDFGDFGDFGDFGDFGDFGDFGGDFGDFG")
        case 22:
            row2Key2IV.isHidden = true
        case 23:
            row2Key3IV.isHidden = true
        case 24:
            row2Key4IV.isHidden = true
        case 25:
            row2Key5IV.isHidden = true
        case 31:
            row3Key1IV.isHidden = true
        case 32:
            row3Key2IV.isHidden = true
        case 33:
            row3Key3IV.isHidden = true
        case 34:
            row3Key4IV.isHidden = true
        case 35:
            row3Key5IV.isHidden = true
        case 41:
            row4Key1IV.isHidden = true
        case 42:
            row4Key2IV.isHidden = true
        case 43:
            row4Key3IV.isHidden = true
        case 44:
            row4Key4IV.isHidden = true
        case 45:
            row4Key5IV.isHidden = true
        default:
            print ("ERROR! - Edit keyboard switch fell through!")
            
        }
        return true
    }
    
    
    
    
    @IBAction func closeKeyboard(_ sender: Any) {
        print ("Close the shortcut View")
        //BEGIN -Save the new defaults
        quickPickList1[0] = row1Key1TF.text!
        quickPickList1[1] = row1Key2TF.text!
        quickPickList1[2] = row1Key3TF.text!
        quickPickList1[3] = row1Key4TF.text!
        quickPickList1[4] = row1Key5TF.text!
        
        quickPickList1[6] = row2Key1TF.text!
        quickPickList1[7] = row2Key2TF.text!
        quickPickList1[8] = row2Key3TF.text!
        quickPickList1[9] = row2Key4TF.text!
        quickPickList1[10] = row2Key5TF.text!
        
        quickPickList1[12] = row3Key1TF.text!
        quickPickList1[13] = row3Key2TF.text!
        quickPickList1[14] = row3Key3TF.text!
        quickPickList1[15] = row3Key4TF.text!
        quickPickList1[16] = row3Key5TF.text!
        
        quickPickList1[18] = row4Key1TF.text!
        quickPickList1[19] = row4Key2TF.text!
        quickPickList1[20] = row4Key3TF.text!
        quickPickList1[21] = row4Key4TF.text!
        quickPickList1[22] = row4Key5TF.text!
        
        saveUserDefaults()
        //END
        NotificationCenter.default.post(name: Notification.Name("updateShortcutKeyboardNotification"), object: nil, userInfo: ["key":"value"])
        screenSaverAllowed = true //allow to show the screen saver again once you are out off the settings screen
        //BEGIN - stop and remove the timer
        self.dismiss(animated: true, completion: nil)
        //END
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("View will disappear, Main Loop")
        screenSaverAllowed = true
        NotificationCenter.default.removeObserver(self) //Remove Alarm and keyboard notifications
    }

}



