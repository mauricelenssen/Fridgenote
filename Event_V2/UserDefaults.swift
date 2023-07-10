//
//  UserDefaults.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 25/7/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import Foundation
import EventKit

//BEGIN - inapp product Code
let productID = "com.au.mauricelenssen.fridgenote.removeLimit"
//END

let calendarUpdateFrequency: Double = 300 //update the calendar 5 minutes
//let calendarUpdateFrequency: Double = 30 //update the calendar 30 seconds


//BEGIN - This hold an array with calendar ID the user has selected to be included to show in the birthday tile, so he can chose more than one if needed
var birthdayCalendarsSelected: [String] = []
var familyCalendarsSelected: [String] = []
//END

var eventStartDate: Date = Date()
var eventStopDate: Date = Date()

//BEGIN - This hold an array with calendar ID the user has selected to be included to show in the day calenda tile, so he can chose more than one if needed
var dayCalendarsSelected: [String] = []
var userDayCalendars: [EKCalendar] = []
var birthdayCalendars: [EKCalendar] = []
//var familyCalendars: [EKCalendar] = []

var notesTitles: [String] = [NSLocalizedString("Note", comment: "")]
var notesText: [String] = [NSLocalizedString("Type your Note here", comment: "")]


//END
var toDoTextString: String = NSLocalizedString("Please add your To Do List here.", comment: "")
    
var shoppingListTextString: String = NSLocalizedString("Please add your Shopping List here.", comment: "")

var screenSaverDelayBeforeStart:Double  = 60 //seconds before the photo slider start, after the fridge door hasn't been moved
var screenSaverUserEnabled = false //The screen saver feature is enabled/disablec  by User
var selectedCalendarName  = "Empty" //This strings is the selected 1st calender the user want to see
var selectedCalendarType: Int = 0
var photoDelayBetweenPhotos: Double = 10 //seconds before a new photo is displayed when photo slide show is played
var userSelectedPhotoAlbum: String = ""
var screenDayTimeBrightness:Float   = 0.8
var screenNightTimeBrightness:Float = 0.3
var screenSleepTimeBrightness:Float = 0.0
var nightTime: Double =  1200    // 20:00 20*60
var dayTime: Double   =  480     // 8:00 8*60
var sleepTime: Double = 1320     // 22:00 22*60
var fridgeDoorSensitivity:Float = 0.3
var fridgeDoorMovementUserEnabled = false      //the app will not interrupt the slide show by default.
//var userSelectedDate: Date = Date()
var clockInPhoto: Bool = true
var dateInPhoto: Bool = true
var photoMotion: Bool = true
var photoMotionSpeed: Float = 0.1 //percentage of max speed used to zoom into photos
var photoShuffle: Bool = true  //Shuffle the photo when in screensaver mode
let numberOfBirthdaysShown: Int = 10
var displayCreationDateInPhoto: Bool = true //This variable shows the date in the screensavers photos
var colouredFamilyCalendar: Bool = false //This variable tells the family view if the event need to be coloured in, our shown the Classic look, with just a colour event colour
var colouredTodayCalendar: Bool = false //This variable tells the Today view if the event need to be coloured in, our shown the Classic look, with just a colour event colour
var locationInPhoto: Bool = true //Display the location of the photo that is shown in the screensaver app, if GPS data is included in the image.

//BEGIN - Global Button shadows
let shadowOpacityButtons: Float = 0.3
let shadowRadiusButtons: Float = 2
let shadowOffsetWidthButtons = 1
let shadowOffsetHeightButtons = 1
//END

//BEGIN - Global View shadows
let shadowOpacityView: Float = 0.3
let shadowRadiusView: Float = 2
let shadowOffsetHeightView = 1
let shadowOffsetWidthView = 1
//END

//BEGIN - Global View shadows


let textfieldRadius: CGFloat = 6
let textfieldBorderWidthHighlight: CGFloat = 4
let textfieldBorderWidthNormal: CGFloat = 2
//END

//BEGIN - When the program start the timer and birthday calendar are displayed, so the max birthday calendar is hidden
var birthdayCalendarViewMax = false
//END

//BEGIN - This variable tells the app if the user bought the inappp purchase or not, soyou can diasble the button
var inAppPurchased:Bool = false
//END

//BEGIN - This variable tells the app how many free agenda items can be added before the app locks and the user is forced to buy it
var agendaCreationLimit:Int = 10
//END

//BEGIN This function loads all the user defaults in the global Variables.
func loadUserDefaults() {
    let defaults = UserDefaults.standard
    if (defaults.bool(forKey:"userDefaultsAreAvailable") == true){
        birthdayCalendarsSelected = defaults.stringArray(forKey: "birthdayCalendarsSelectedField")!
        birthdayCalendars.removeAll()
        //BEGIN - read array of birthday selected Calendars
        
        if eventAccessApproved {
            for n in birthdayCalendarsSelected
            {
                let tempCalendar = eventStore.calendar(withIdentifier: n)
                if tempCalendar != nil{
                    birthdayCalendars.append(tempCalendar!)
                }
                
            }
        }
        //END
        
        dayCalendarsSelected = defaults.stringArray(forKey: "dayCalendarsSelectedField")!
        
        //BEGIN - read array of user selected Calendars
        userDayCalendars.removeAll()
        if eventAccessApproved {
            for n in dayCalendarsSelected
            {
                let tempCalendar = eventStore.calendar(withIdentifier: n)
                if tempCalendar != nil {
                    
                    userDayCalendars.append(tempCalendar!)
                }
            }
        }
        //END
        toDoTextString = defaults.string(forKey: "ToDoField")!
        shoppingListTextString = defaults.string(forKey: "ShoppingListField")!
        screenSaverDelayBeforeStart = defaults.double(forKey: "screenSaverDelayBeforeStartField")
        screenSaverUserEnabled = defaults.bool(forKey: "screenSaverUserEnabledField")
        selectedCalendarName = defaults.string(forKey: "selectedCalendarField")!
        selectedCalendarType = defaults.integer(forKey: "selectedCalendarTypeField")
        photoDelayBetweenPhotos = defaults.double(forKey: "delayBetweenPhotosField")
        userSelectedPhotoAlbum = defaults.string(forKey: "userSelectedPhotoAlbumField")!
        screenDayTimeBrightness = defaults.float(forKey: "userSelectedDayScreenBrightnessField")
        screenNightTimeBrightness = defaults.float(forKey: "userSelectedNightScreenBrightnessField")
        screenSleepTimeBrightness = defaults.float(forKey: "userSelectedSleepScreenBrightnessField")
        dayTime = defaults.double(forKey: "dayTimeField")
        nightTime = defaults.double(forKey: "nightTimeField")
        sleepTime = defaults.double(forKey: "sleepTimeField")
        
        fridgeDoorSensitivity = defaults.float(forKey: "fridgeDoorSensitivityField")
        fridgeDoorMovementUserEnabled = defaults.bool(forKey: "fridgeDoorMovementUserEnabledField")
        quickPickList1 = defaults.stringArray(forKey: "quickPickList1Field")!
        
        clockInPhoto = defaults.bool(forKey: "clockInPhotoField")
        dateInPhoto = defaults.bool(forKey: "dateInPhotoField")
        photoMotion = defaults.bool(forKey: "photoMotionField")
        photoShuffle = defaults.bool(forKey: "photoShuffleField")
        photoMotionSpeed = defaults.float(forKey: "photoMotionSpeedField")
        screenTheme = defaults.integer(forKey: "screenThemeField")
        inAppPurchased = defaults.bool(forKey: "inAppPurchasedField")
        agendaCreationLimit = defaults.integer(forKey: "agendaCreationLimitField")
        displayCreationDateInPhoto = defaults.bool(forKey: "displayCreationDateInPhotoField")
        
        print ("the inapp purchase value is \(inAppPurchased)")
        
        if defaults.object(forKey: "notesTitleField") == nil {
            print ("No notes Titles Found")
        }
        else {
            notesTitles = defaults.stringArray(forKey: "notesTitleField")!
        }
        
        if defaults.object(forKey: "notesTextField") == nil {
            print ("No notes Titles Found")
        }
        else {
            notesText = defaults.stringArray(forKey: "notesTextField")!
        }
        
        if defaults.object(forKey: "startDayWeekField") == nil {
            print ("No startDayWeekField found in user defaults")
            weekStartDay = 1 //Sunday 
        }
        else {
            weekStartDay = defaults.integer(forKey: "startDayWeekField") 
        }
    
        if defaults.object(forKey: "familyCalendarsSelectedField") == nil {
            print ("No familyCalendarsField found in user defaults")
        }
        else
        {
            familyCalendarsSelected = defaults.stringArray(forKey: "familyCalendarsSelectedField")!
        }
        
        
        if defaults.object(forKey: "colouredFamilyCalendarUIField") == nil {
            print ("No colouredFamilyCalendarUI found in user defaults")
            colouredFamilyCalendar = false
        }
        else
        {
            colouredFamilyCalendar = defaults.bool(forKey: "colouredFamilyCalendarUIField")
        }
        
        if defaults.object(forKey: "colouredTodayCalendarUIField") == nil {
            print ("No colouredTodayCalendarUI found in user defaults")
            colouredTodayCalendar = false
        }
        else
        {
            colouredTodayCalendar = defaults.bool(forKey: "colouredTodayCalendarUIField")
        }
        
        if defaults.object(forKey: "locationInPhotoField") == nil {
            print ("No locationInPhoto found in user defaults")
            locationInPhoto = true
        }
        else
        {
            locationInPhoto = defaults.bool(forKey: "locationInPhotoField")
        }
        
        
        
        
        
        //BEGIN - Create an array with calendar names,colourtype in order how they are saved in the defaults.
        let calendarData = readUserCalendarData()
        familyCalendarName.removeAll()
        familyCalendarColor.removeAll()
        familyCalendarType.removeAll()
        
        for s in 0..<familyCalendarsSelected.count
        {
            for n in 0..<calendarData.name.count
            {
                if calendarData.id[n] == familyCalendarsSelected[s]
                {
                    familyCalendarName.append (calendarData.name[n])
                    familyCalendarColor.append (calendarData.calendarColor[n])
                    familyCalendarType.append (calendarData.type[n])
                }
            }
        }
        //END
     }
    
}
//END

//BEGIN - This function saves the global defaults, it can be used after the user exits the settings screen
func saveUserDefaults() {
    let defaults = UserDefaults.standard
    let temp:Bool = true
    defaults.set(temp, forKey: "userDefaultsAreAvailable")
    defaults.set(toDoTextString, forKey: "ToDoField")
    defaults.set(shoppingListTextString, forKey: "ShoppingListField")
    defaults.set(screenSaverDelayBeforeStart, forKey: "screenSaverDelayBeforeStartField")
    defaults.set(screenSaverUserEnabled, forKey: "screenSaverUserEnabledField")
    defaults.set(selectedCalendarName, forKey: "selectedCalendarField")
    defaults.set(selectedCalendarType, forKey: "selectedCalendarTypeField")
    defaults.set(photoDelayBetweenPhotos, forKey: "delayBetweenPhotosField")
    defaults.set(userSelectedPhotoAlbum, forKey: "userSelectedPhotoAlbumField")
    defaults.set(screenDayTimeBrightness, forKey: "userSelectedDayScreenBrightnessField")
    defaults.set(screenNightTimeBrightness, forKey: "userSelectedNightScreenBrightnessField")
    defaults.set(screenSleepTimeBrightness, forKey: "userSelectedSleepScreenBrightnessField")
    defaults.set(dayTime,forKey: "dayTimeField")
    defaults.set(nightTime,forKey: "nightTimeField")
    defaults.set(sleepTime,forKey: "sleepTimeField")
    defaults.set(fridgeDoorSensitivity,forKey: "fridgeDoorSensitivityField")
    defaults.set(fridgeDoorMovementUserEnabled,forKey: "fridgeDoorMovementUserEnabledField")
    
    defaults.set(quickPickList1,forKey: "quickPickList1Field")
    
    defaults.set(clockInPhoto,forKey: "clockInPhotoField")
    defaults.set(dateInPhoto,forKey: "dateInPhotoField")
    defaults.set(photoMotion,forKey: "photoMotionField")
    defaults.set(photoShuffle,forKey: "photoShuffleField")
    defaults.set(photoMotionSpeed,forKey: "photoMotionSpeedField")
    defaults.set(screenTheme,forKey: "screenThemeField")
    defaults.set(birthdayCalendarsSelected,forKey: "birthdayCalendarsSelectedField")
    defaults.set(dayCalendarsSelected,forKey: "dayCalendarsSelectedField")
    defaults.set(inAppPurchased,forKey: "inAppPurchasedField")
    defaults.set(agendaCreationLimit,forKey: "agendaCreationLimitField")
    defaults.set(displayCreationDateInPhoto,forKey: "displayCreationDateInPhotoField")
    
    defaults.set(notesTitles,forKey: "notesTitleField")
    defaults.set(notesText,forKey: "notesTextField")
    defaults.set(weekStartDay,forKey: "startDayWeekField")
    defaults.set(familyCalendarsSelected,forKey: "familyCalendarsSelectedField")
    defaults.set(colouredFamilyCalendar,forKey: "colouredFamilyCalendarUIField")
    defaults.set(colouredTodayCalendar,forKey: "colouredTodayCalendarUIField")
    defaults.set(locationInPhoto,forKey: "locationInPhotoField")
    
}



//END
