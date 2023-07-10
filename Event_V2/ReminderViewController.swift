//
//  ReminderViewController.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 28/9/2022.
//  Copyright © 2022 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import EventKit

var SelectedRow: Int = 0
var keyboardHeight: Int = 400
class ReminderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet var closeBtn: UIButton!
    
    @IBOutlet var topHeaderView: UIImageView!
    @IBOutlet var headerLbl: UILabel!
    
    @IBOutlet var notesTableView: UITableView?
    @IBOutlet var notesView: UIView?
    @IBOutlet var noteTitleView: UIView?
    @IBOutlet var backgroundView: UIImageView?
    @IBOutlet var notesTitleTF: UITextField?
    @IBOutlet var notesTextTV: UITextView?
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var newNoteBtn: UIButton!
    @IBOutlet var shareBtn:   UIButton!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "ReminderTableViewCell", bundle: nil)
        self.notesTableView!.register(nib, forCellReuseIdentifier: "ReminderTableViewCell")
        
        notesTitleTF?.text = notesTitles[0]
        notesTextTV?.text = notesText[0]
        notesTitleTF?.textColor = mainTextColor
        
        textViewHeight.constant = screenHeight-190
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("Cell Selected)")
        notesTitles[SelectedRow] = notesTitleTF!.text!
        notesText[SelectedRow] = notesTextTV!.text!
        
        notesTitleTF?.text = notesTitles[indexPath.row]
        notesTitleTF?.textColor = mainTextColor
        
        notesTextTV?.text = notesText[indexPath.row]
        notesTextTV?.textColor = mainTextColor
        SelectedRow = indexPath.row
        notesTableView?.reloadData()
        //let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        //selectedCell.contentView.backgroundColor = buttonPressedColor
        
    }
   
    //BEGIN - User pressed the remove keyboard key so store both strings, as you don't know if user swapped between text views
    @IBAction func textViewDidChange() {
        print ("Text view did end edit")
        screenSaverCounter = 0 //Reset the screen saver counter
        storeNoteData()
        notesTableView?.reloadData()
    }
    //END
    
    //BEGIN - User pressed the remove keyboard key so store both strings, as you don't know if user swapped between text views
    func textFieldDidEndEditing(_ textField: UITextField) {
        print ("Text Field did end edit")
        
        screenSaverCounter = 0 //Reset the screen saver counter
        storeNoteData()
    }
    //END
    func storeNoteData()
    {
        print ("STOOOOOOORING")
        notesTitles[SelectedRow] = notesTitleTF!.text!
        notesText[SelectedRow] = notesTextTV!.text!
        saveUserDefaults()
     }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return notesTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell: UITableViewCell?
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTableViewCell", for: indexPath) as! ReminderTableViewCell
        cell.noteTitleLbl.text = notesTitles[indexPath.row]
        cell.noteTitleLbl.textColor = mainTextColor
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none //do not show a selection color
        if SelectedRow == indexPath.row {
            cell.contentView.backgroundColor = buttonPressedColor
        }
        
        return cell
    }


    @IBAction func addNote(){
        //MAX notes you can add is 20
        if notesTitles.count > 19 {
            generalWarningHeaderText = NSLocalizedString("Note Limit Reached", comment: "")
            generalWarningText = NSLocalizedString("To create a new Note, you need to delete one first.", comment: "")
            popupwarning()
        }
        else{
            let titleString = NSLocalizedString("Note", comment: "") + " \(notesTitles.count+1)"
            notesTitles.append(titleString)
            notesText.append(NSLocalizedString("Type your Note here", comment: ""))
            SelectedRow = notesTitles.count-1
            notesTitleTF!.text! = notesTitles[SelectedRow]
            notesTextTV!.text! =  notesText[SelectedRow]
            notesTableView?.reloadData()
            
        }
    }
    
    
    
    func deleteNote(){
        if notesTitles.count != 0 {
            notesTitles.remove(at: SelectedRow)
            notesText.remove(at: SelectedRow)
            SelectedRow = 0 //Make sure new selected note is the 1st note, else nothing is shown
            if notesTitles.count == 0 {
                notesTitleTF?.text = ""
                notesTextTV?.text = ""
            }
            else
            {
                notesTitleTF?.text = notesTitles[SelectedRow]
                notesTextTV?.text = notesText[SelectedRow]
            }
        }
        notesTableView?.reloadData()
    }
    
    @IBAction func shareButtonActionToDoList(_ sender: AnyObject) {
        screenSaverCounter = 0 //Reset the screen saver counter
        let activityVC = UIActivityViewController(activityItems: [notesTextTV?.text as Any], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = notesView
        activityVC.popoverPresentationController?.sourceRect = notesView!.bounds
        present(activityVC, animated: true, completion: nil)
        activityVC.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            
            if completed  {
                //self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    func updateScreen(){
        shareBtn?.setImage(shareBtnImage, for: .normal)
        shareBtn?.setImage(shareBtnPressedImage, for: .highlighted)
        shareBtn!.layer.shadowColor = UIColor.black.cgColor
        shareBtn!.layer.shadowOpacity = shadowOpacityButtons
        shareBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        shareBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        notesTableView?.separatorColor = tableSeperatorColor
        notesTitleTF?.textColor = mainTextColor
        notesTextTV?.textColor = mainTextColor
        
        notesTitleTF!.layer.borderWidth = textfieldBorderWidthNormal
        notesTitleTF!.layer.cornerRadius = textfieldRadius
        notesTitleTF!.layer.borderColor = mainTextColor.cgColor
        
        if (dayMode == true){
            notesTitleTF!.keyboardAppearance = UIKeyboardAppearance.light
            notesTextTV!.keyboardAppearance = UIKeyboardAppearance.light
        }
        else {
            notesTitleTF!.keyboardAppearance = UIKeyboardAppearance.dark
            notesTextTV!.keyboardAppearance = UIKeyboardAppearance.dark
        }
        
        //topHeaderView?.image = topHeaderImage
        backgroundView?.image = backgroundImage
        headerLbl.textColor = mainTextColor
        headerLbl.text =  NSLocalizedString("Notes", comment: "")
        topHeaderView?.image = topHeaderImage
        
        
        closeBtn?.setImage(closePressedImage, for: .highlighted)
        closeBtn?.setImage(closeImage, for: .normal)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    
        notesView!.layer.shadowColor = UIColor.black.cgColor
        notesView!.layer.shadowOpacity = shadowOpacityView
        notesView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        notesView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        notesView?.backgroundColor    = windowColor
        notesView?.layer.cornerRadius = cornerRadiusWindow
        notesView?.layer.borderWidth  = borderWidthWindow
        notesView?.layer.borderColor  = borderColor.cgColor
        
        noteTitleView!.layer.shadowColor = UIColor.black.cgColor
        noteTitleView!.layer.shadowOpacity = shadowOpacityView
        noteTitleView!.layer.shadowOffset = CGSize(width: shadowOffsetWidthView, height: shadowOffsetHeightView)
        noteTitleView!.layer.shadowRadius = CGFloat(shadowRadiusView)
        
        noteTitleView?.backgroundColor    = windowColor
        noteTitleView?.layer.cornerRadius = cornerRadiusWindow
        noteTitleView?.layer.borderWidth  = borderWidthWindow
        noteTitleView?.layer.borderColor  = borderColor.cgColor
        
        deleteBtn?.setImage(deleteImage, for: .normal)
        deleteBtn?.setImage(deletePressedImage, for: .highlighted)
        deleteBtn!.layer.shadowColor = UIColor.black.cgColor
        deleteBtn!.layer.shadowOpacity = shadowOpacityButtons
        deleteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        deleteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    
        newNoteBtn?.setImage(EditCalendarBtnImage, for: .normal)
        newNoteBtn?.setImage(EditCalendarPressedBtnImage, for: .highlighted)
        newNoteBtn!.layer.shadowColor = UIColor.black.cgColor
        newNoteBtn!.layer.shadowOpacity = shadowOpacityButtons
        newNoteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        newNoteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        
        
        
        
    
    
    }
    
    @objc func screenModeHasChanged()
        {
            print ("I updated the screen MODE")
            notesTableView?.reloadData()
            updateScreen()
        }
    
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool) {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false //no slide show allowed, so you can see and read the menu
        SelectedRow = 0
        textViewHeight.constant = screenHeight-190
        let eventStore = EKEventStore()
        let calendars =
            eventStore.calendars(for: EKEntityType.reminder)

        for calendar in calendars as [EKCalendar] {
            print("Calendar = \(calendar.title)")
        }
        
        
                                       
       //BEGIN - monitor if Calendar has been loaded in
        NotificationCenter.default.addObserver(self, selector: #selector(self.screenModeHasChanged), name: Notification.Name("ScreenModeNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.screensaverRequested), name: Notification.Name("ScreensaverNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteNote(notification:)), name: Notification.Name("DeleteReminderNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        updateScreen()
    //END
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            keyboardHeight = Int(keyboardRectangle.height)
            textViewHeight.constant = CGFloat(Int(screenHeight)-150-keyboardHeight)
            print ("Keyboard Height is: \(keyboardHeight)")
        }
    }
    
    
    @objc func deleteNote(notification: Notification){
        print ("Delete the Note")
        deleteNote()
    }
    
    @objc func keyboardWillDisappear() {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = true // enable the screen saver
        notesTableView?.reloadData()
        
        storeNoteData()
        textViewHeight.constant = screenHeight-190
        print ("Keyboard is removed")
    }
    
    @objc func keyboardWillAppear() {
        screenSaverCounter = 0 //Reset the screen saver counter
        screenSaverAllowed = false // prevent the screen saver to start else it could start when keyboard is up
        
        print ("Keyboard is up")
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
        storeNoteData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func popupwarning(){
        performSegue(withIdentifier: "WarningSegue", sender: nil)
    }

    @IBAction func popupDeleteWarning(){
        //Only show delete warning if there is still a note to delete
        if notesTitles.count != 0 {
        performSegue(withIdentifier: "DeleteNoteSegue", sender: nil)
        }
        
    }

}
