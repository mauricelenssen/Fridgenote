//
//  ColorDefinitions.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 25/7/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import Foundation
import UIKit

//BEGIN - global window and Color setup
//let cornerRadiusWindow:CGFloat  = 7
let cornerRadiusWindow:CGFloat  = 14
let borderWidthWindow:CGFloat = 1
let borderColorNight = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.15)
var borderColorDay = UIColor(red: 113.0/255.0, green: 121.0/255.0, blue: 132.0/255.0, alpha: 0.15)
var borderColor = borderColorDay

//BEGIN - Settings Icons
let reminderImageDay = UIImage(named: "ReminderBtnDay") as UIImage?
let reminderImageNight = UIImage(named: "ReminderBtnNight") as UIImage?
var reminderImage = reminderImageDay

let reminderPressedImageDay = UIImage(named: "ReminderPressedBtnDay") as UIImage?
let reminderPressedImageNight = UIImage(named: "ReminderPressedBtnNight") as UIImage?
var reminderPressedImage = reminderPressedImageDay

//BEGIN - Settings Icons
let lockImageDay = UIImage(named: "Lock_Day") as UIImage?
let lockImageNight = UIImage(named: "Lock_Night") as UIImage?
var lockImage = lockImageDay

let lockPressedImageDay = UIImage(named: "Lock_Pressed_Day") as UIImage?
let lockPressedImageNight = UIImage(named: "Lock_Pressed_Night") as UIImage?
var lockPressedImage = lockPressedImageDay

let WeekOutlookImageDay = UIImage(named: "7DayOutlookBtnDay") as UIImage?
let WeekOutlookImageNight = UIImage(named: "7DayOutlookBtnNight") as UIImage?
let WeekOutlookPressedImageDay = UIImage(named: "7DayOutlookPressedBtnDay") as UIImage?
let WeekOutlookPressedImageNight = UIImage(named: "7DayOutlookPressedBtnNight") as UIImage?

var weekOutlookImage = WeekOutlookImageDay
var weekOutlookPressedImage = WeekOutlookPressedImageDay

let timerImageDay = UIImage(named: "TimerBtnDay") as UIImage?
let timerImageNight = UIImage(named: "TimerBtnNight") as UIImage?
var timerImage = timerImageDay

let timerPressedImageDay = UIImage(named: "TimerPressedBtnDay") as UIImage?
let timerPressedImageNight = UIImage(named: "TimerPressedBtnNight") as UIImage?
var timerPressedImage = timerPressedImageDay

let timerActiveImageDay = UIImage(named: "TimerActiveBtnDay") as UIImage?
let timerActiveImageNight = UIImage(named: "TimerActiveBtnNight") as UIImage?
var timerActiveImage = timerActiveImageDay

let timerActivePressedImageDay = UIImage(named: "TimerActivePressedBtnDay") as UIImage?
let timerActivePressedImageNight = UIImage(named: "TimerActivePressedBtnNight") as UIImage?
var timerActivePressedImage = timerActivePressedImageDay


let infoSettingsImageDay = UIImage(named: "Info_Settings_Day") as UIImage?
let infoSettingsImageNight = UIImage(named: "Info_Settings_Night") as UIImage?
var infoSettingsImage = infoSettingsImageDay

let calendarSelectionSettingsImageDay = UIImage(named: "CalendarLibrary_Settings_Day") as UIImage?
let calendarSelectionSettingsImageNight = UIImage(named: "CalendarLibrary_Settings_Night") as UIImage?
var calendarSelectionSettingsImage = calendarSelectionSettingsImageDay

let inAppSettingsImageDay = UIImage(named: "Inapp_Settings_Day") as UIImage?
let inAppSettingsImageNight = UIImage(named: "Inapp_Settings_Night") as UIImage?
var inAppSettingsImage = inAppSettingsImageDay

let photoLibrarySelectionSettingsImageDay = UIImage(named: "PhotoLibrary_Settings_Day") as UIImage?
let photoLibrarySelectionSettingsImageNight = UIImage(named: "PhotoLibrary_Settings_Night") as UIImage?
var photoLibrarySelectionSettingsImage = photoLibrarySelectionSettingsImageDay

let photoDisplaySettingsImageDay = UIImage(named: "Photo_Settings_Day") as UIImage?
let photoDisplaySettingsImageNight = UIImage(named: "Photo_Settings_Night") as UIImage?
var photoDisplaySettingsImage = photoDisplaySettingsImageDay

let inAppRestoreSettingsImageDay = UIImage(named: "InappRestore_Settings_Day") as UIImage?
let inAppRestoreSettingsImageNight = UIImage(named: "InappRestore_Settings_Night") as UIImage?
var inAppRestoreSettingsImage = inAppRestoreSettingsImageDay

let screenBrightnessSettingsImageDay = UIImage(named: "Brightness_Settings_Day") as UIImage?
let screenBrightnessSettingsImageNight = UIImage(named: "Brightness_Settings_Night") as UIImage?
var screenBrightnessSettingsImage = screenBrightnessSettingsImageDay

let calendarEditSettingsImageDay = UIImage(named: "CalendarCreation_Settings_Day") as UIImage?
let calendarEditSettingsImageNight = UIImage(named: "CalendarCreation_Settings_Night") as UIImage?
var calendarEditSettingsImage = calendarEditSettingsImageDay



//BEGIN - temporary storage of user drawn noticebord info
var userDrawingImg: UIImage? = UIImage()
//END

let dayBackgroundImage = UIImage(named: "Day Base Screen") as UIImage?
var backgroundImage = dayBackgroundImage



let amBtnImageDay = UIImage(named: "amBtnDay") as UIImage?
var amBtnImage = amBtnImageDay

let pmBtnImageDay = UIImage(named: "pmBtnDay") as UIImage?
var pmBtnImage = pmBtnImageDay


let collapseDrawerImageDay = UIImage(named: "CollapseDrawerDay") as UIImage?
let collapseDrawerImageNight = UIImage(named: "CollapseDrawerNight") as UIImage?
var collapseDrawerImage = collapseDrawerImageDay

let collapseDrawerPressedImageDay = UIImage(named: "CollapseDrawerPressedDay") as UIImage?
let collapseDrawerPressedImageNight = UIImage(named: "CollapseDrawerPressedNight") as UIImage?
var collapseDrawerPressedImage = collapseDrawerPressedImageDay


let expandDrawerImageDay = UIImage(named: "ExpandDrawerDay") as UIImage?
let expandDrawerImageNight = UIImage(named: "ExpandDrawerNight") as UIImage?
var expandDrawerImage = expandDrawerImageDay

let expandDrawerPressedImageDay = UIImage(named: "ExpandDrawerPressedDay") as UIImage?
let expandDrawerPressedImageNight = UIImage(named: "ExpandDrawerPressedNight") as UIImage?
var expandDrawerPressedImage = expandDrawerPressedImageDay

let moreArrowImageDay = UIImage(named: "MoreArrowDay") as UIImage?
let moreArrowImageNight = UIImage(named: "MoreArrowNight") as UIImage?
var moreArrowImage = moreArrowImageDay

let updateButtonImageDay = UIImage(named: "UpdatePopupBtnDay") as UIImage?
let updateButtonImageNight = UIImage(named: "UpdatePopupBtnNight") as UIImage?
var updateButtonImage = updateButtonImageDay

let updatePressedButtonImageDay = UIImage(named: "UpdatePopupPressedBtnDay") as UIImage?
let updatePressedButtonImageNight = UIImage(named: "UpdatePopupPressedBtnNight") as UIImage?
var updatePressedButtonImage = updatePressedButtonImageDay

let keyboardCloseImageDay = UIImage(named: "KeyboardCloseBtnDay") as UIImage?
var keyboardCloseImage = keyboardCloseImageDay



let lineBreakImageDay = UIImage(named: "LineBreakDay") as UIImage?
let lineBreakImageNight = UIImage(named: "LineBreakNight") as UIImage?
var lineBreakImage = lineBreakImageDay

let keyboardDeleteImageDay = UIImage(named: "KeyboardDeleteBtnDay") as UIImage?
var keyboardDeleteImage = keyboardDeleteImageDay

let keyboardEditImageDay = UIImage(named: "KeyboardEditBtnDay") as UIImage?
var keyboardEditImage = keyboardEditImageDay

let maxBirthdayCaldendarImageDay = UIImage(named: "MaxCurrentEventBtnDay") as UIImage?
var maxBirthdayCaldendarImage = maxBirthdayCaldendarImageDay

let minBirthdayCaldendarImageDay = UIImage(named: "MinCurrentEventBtnDay") as UIImage?
var minBirthdayCaldendarImage = minBirthdayCaldendarImageDay

let editImgDay = UIImage(named: "EditImgDay") as UIImage?
let editImgNight = UIImage(named: "EditImgNight") as UIImage?
var editImg = editImgDay



let selectRectangleImgDay = UIImage(named: "selectRectangleDay") as UIImage?
let selectRectangleImgNight = UIImage(named: "selectRectangleNight") as UIImage?
var selectRectangleImg = selectRectangleImgDay

let notSelectRectangleImgDay = UIImage(named: "notSelectRectangleDay") as UIImage?
let notSelectRectangleImgNight = UIImage(named: "notSelectRectangleNight") as UIImage?
var notSelectRectangleImg = notSelectRectangleImgDay

let OKImgDay = UIImage(named: "OKBtnDay") as UIImage?
let OKImgNight = UIImage(named: "OKBtnNight") as UIImage?
var OKImg = OKImgDay

let OKPressedImgDay = UIImage(named: "OKPressedBtnDay") as UIImage?
let OKPressedImgNight = UIImage(named: "OKPressedBtnNight") as UIImage?
var OKPressedImg = OKPressedImgDay


let cancelCalendarEventImageDay = UIImage(named: "CancelCalendarEventBtnDay") as UIImage?
var cancelCalendarEventImage = cancelCalendarEventImageDay
let addCalendarEventImageDay = UIImage(named: "AddCalendarEventBtnDay") as UIImage?
var addCalendarEventImage = addCalendarEventImageDay
let updateCalendarEventImageDay = UIImage(named: "UpdateCalendarEventBtnDay") as UIImage?
var updateCalendarEventImage = updateCalendarEventImageDay
let deleteCalendarEventImageDay = UIImage(named: "DeleteCalendarEventBtnDay") as UIImage?
var deleteCalendarEventImage = deleteCalendarEventImageDay

let cancelCalendarEventPressedImageDay = UIImage(named: "CancelCalendarEventPressedBtnDay") as UIImage?
var cancelCalendarEventPressedImage = cancelCalendarEventPressedImageDay
let addCalendarEventPressedImageDay = UIImage(named: "AddCalendarEventPressedBtnDay") as UIImage?
var addCalendarEventPressedImage = addCalendarEventPressedImageDay
let updateCalendarEventPressedImageDay = UIImage(named: "UpdateCalendarEventPressedBtnDay") as UIImage?
var updateCalendarEventPressedImage = updateCalendarEventPressedImageDay
let deleteCalendarEventPressedImageDay = UIImage(named: "DeleteCalendarEventPressedBtnDay") as UIImage?
var deleteCalendarEventPressedImage = deleteCalendarEventPressedImageDay

let selectPhotoAlbumImageDay = UIImage(named: "SelectPhotoAlbumBtnDay") as UIImage?
var selectPhotoAlbumImage = selectPhotoAlbumImageDay
let selectPhotoAlbumImagePressedDay = UIImage(named: "SelectPhotoAlbumPressedBtnDay") as UIImage?
var selectPhotoAlbumImagePressed = selectPhotoAlbumImagePressedDay

let calendarMarkerImageDay = UIImage(named: "CalendarMarkerDay") as UIImage?
var calendarMarkerImage = calendarMarkerImageDay

let todayMarkerImageDay = UIImage(named: "TodayMarkerDay") as UIImage?
var todayMarkerImage = todayMarkerImageDay

let TopHeaderImageDay = UIImage(named: "TopHeaderDay") as UIImage?
var topHeaderImage = TopHeaderImageDay

let TopHeaderTitleBoxImageDay = UIImage(named: "HeaderTitleBoxDay") as UIImage?
let TopHeaderTitleBoxImageNight = UIImage(named: "HeaderTitleBoxNight") as UIImage?
var headerTitleImage = TopHeaderTitleBoxImageDay

let TopHeaderTitleBoxWeekImageDay = UIImage(named: "HeaderTitleBoxWeekDay") as UIImage?
var TopHeaderTitleBoxWeekImage = TopHeaderTitleBoxWeekImageDay

let vibrationMaxImageDay = UIImage(named: "VibrationMaxDay") as UIImage?
var vibrationMaxImage = vibrationMaxImageDay

let vibrationMinImageDay = UIImage(named: "VibrationMinDay") as UIImage?
var vibrationMinImage = vibrationMinImageDay

let brightnessMaxImageDay = UIImage(named: "BrightnessMaxDay") as UIImage?
var brightnessMaxImage = brightnessMaxImageDay

let brightnessMinImageDay = UIImage(named: "BrightnessMinDay") as UIImage?
var brightnessMinImage = brightnessMinImageDay

let cancelPopupBtnImageDay = UIImage(named: "CancelPopupBtnDay") as UIImage?
var cancelPopupBtnImage = cancelPopupBtnImageDay

let deletePopupBtnImageDay = UIImage(named: "DeletePopupBtnDay") as UIImage?
var deletePopupBtnImage = deletePopupBtnImageDay

let cancelPopupBtnImagePressedDay = UIImage(named: "CancelPopupPressedBtnDay") as UIImage?
var cancelPopupBtnPressedImage = cancelPopupBtnImagePressedDay

let deletePopupBtnImagePressedDay = UIImage(named: "DeletePopupPressedBtnDay") as UIImage?
var deletePopupBtnPressedImage = deletePopupBtnImagePressedDay

let photoSlideShowImageDay = UIImage(named: "PhotoSlideShowBtnDay") as UIImage?
var photoSlideShowImage = photoSlideShowImageDay

let photoSlideShowImagePressedDay = UIImage(named: "PhotoSlideShowBtnPressedDay") as UIImage?
let photoSlideShowImagePressedNight = UIImage(named: "PhotoSlideShowBtnPressedNight") as UIImage?
var photoSlideShowPressedImage = photoSlideShowImagePressedDay


let noteBtnImageDay = UIImage(named: "NoteBtnDay") as UIImage?
var noteBtnImage = noteBtnImageDay

let noteBtnImagePressedDay = UIImage(named: "NoteBtnPressedDay") as UIImage?
let noteBtnImagePressedNight = UIImage(named: "NoteBtnPressedNight") as UIImage?
var noteBtnPressedImage = noteBtnImagePressedDay


let settingsImageDay = UIImage(named: "SettingsBtnDay") as UIImage?
var settingsImage = settingsImageDay

let settingsPressedImageDay = UIImage(named: "SettingsBtnPressedDay") as UIImage?
let settingsPressedImageNight = UIImage(named: "SettingsBtnPressedNight") as UIImage?
var settingsPressedImage = settingsPressedImageDay

let yesterdayImageDay = UIImage(named: "YesterdayBtnDay") as UIImage?
var yesterdayImage = yesterdayImageDay

let nextDayImageDay = UIImage(named: "NextDayBtnDay") as UIImage?
var nextDayImage = nextDayImageDay

let closeImageDay = UIImage(named: "CloseBtnDay") as UIImage?
let closeImageNight = UIImage(named: "CloseBtnNight") as UIImage?
let closePressedImageDay = UIImage(named: "ClosePressedBtnDay") as UIImage?
let closePressedImageNight = UIImage(named: "ClosePressedBtnNight") as UIImage?

var closeImage = closeImageDay
var closePressedImage = closePressedImageDay

let searchCalendarImageDay = UIImage(named: "SearchCalendarBtnDay") as UIImage?
let searchCalendarImageNight = UIImage(named: "SearchCalendarBtnNight") as UIImage?
let searchCalendarPressedImageDay = UIImage(named: "SearchCalendarPressedBtnDay") as UIImage?
let searchCalendarPressedImageNight = UIImage(named: "SearchCalendarPressedBtnNight") as UIImage?

var searchCalendarImage = searchCalendarImageDay
var searchCalendarPressedImage = searchCalendarPressedImageDay

//let plusBtnImageDay = UIImage(named: "PlusBtnDay") as UIImage?
//var plusBtnImage = plusBtnImageDay

let upBtnImageDay = UIImage(named: "UpBtnDay") as UIImage?
var upBtnImage = upBtnImageDay
let upPressedBtnImageDay = UIImage(named: "UpPressedBtnDay") as UIImage?
var upPressedBtnImage = upPressedBtnImageDay
let downBtnImageDay = UIImage(named: "DownBtnDay") as UIImage?
var downBtnImage = downBtnImageDay
let downPressedBtnImageDay = UIImage(named: "DownPressedBtnDay") as UIImage?
var downPressedBtnImage = downPressedBtnImageDay


let EditCalendarBtnImageDay = UIImage(named: "EditCalendarBtnDay") as UIImage?
let EditCalendarBtnImageNight = UIImage(named: "EditCalendarBtnNight") as UIImage?
let EditCalendarPressedBtnImageDay = UIImage(named: "EditCalendarPressedBtnDay") as UIImage?
let EditCalendarPressedBtnImageNight = UIImage(named: "EditCalendarPressedBtnNight") as UIImage?




var EditCalendarBtnImage = EditCalendarBtnImageDay
var EditCalendarPressedBtnImage = EditCalendarPressedBtnImageDay


let weekViewBtnImageDay = UIImage(named: "WeekViewBtnDay") as UIImage?
let weekViewBtnImageNight = UIImage(named: "WeekViewBtnNight") as UIImage?
let weekViewPressedBtnImageDay = UIImage(named: "WeekViewPressedBtnDay") as UIImage?
let weekViewPressedBtnImageNight = UIImage(named: "WeekViewPressedBtnNight") as UIImage?
var weekViewBtnImage = weekViewBtnImageDay
var weekViewPressedBtnImage = weekViewPressedBtnImageDay


let monthViewBtnImageNight = UIImage(named: "MonthViewBtnNight") as UIImage?
let monthViewBtnImageDay = UIImage(named: "MonthViewBtnDay") as UIImage?
let monthViewPressedBtnImageNight = UIImage(named: "MonthViewPressedBtnNight") as UIImage?
let monthViewPressedBtnImageDay = UIImage(named: "MonthViewPressedBtnDay") as UIImage?

var monthViewBtnImage = monthViewBtnImageDay
var monthViewPressedBtnImage = monthViewPressedBtnImageDay

let upcommingEventImgNight = UIImage(named: "UpcommingEventBtnNight") as UIImage?
let upcommingEventImgDay = UIImage(named: "UpcommingEventBtnDay") as UIImage?
let upcommingEventPressedImgNight = UIImage(named: "UpcommingEventPressedBtnNight") as UIImage?
let upcommingEventPressedImgDay = UIImage(named: "UpcommingEventPressedBtnDay") as UIImage?

var upcommingEventImg = upcommingEventImgDay
var upcommingEventPressedImg = upcommingEventPressedImgDay

let startBtnImageDay = UIImage(named: "StartBtnDay") as UIImage?
var startBtnImage = startBtnImageDay
let startPressedBtnImageDay = UIImage(named: "StartPressedBtnDay") as UIImage?
var startPressedBtnImage = startPressedBtnImageDay

let resetBtnImageDay = UIImage(named: "ResetBtnDay") as UIImage?
var resetBtnImage = resetBtnImageDay
let resetPressedBtnImageDay = UIImage(named: "ResetPressedBtnDay") as UIImage?
var resetPressedBtnImage = resetPressedBtnImageDay


let deleteImageDay = UIImage(named: "ClearBtnDay") as UIImage?
let deleteImageNight = UIImage(named: "ClearBtnNight") as UIImage?

let deleteImagePressedDay = UIImage(named: "ClearBtnPressedDay") as UIImage?
let deleteImagePressedNight = UIImage(named: "ClearBtnPressedNight") as UIImage?

var deleteImage = deleteImageDay
var deletePressedImage = deleteImagePressedDay

let tickImageDay = UIImage(named: "TickDay") as UIImage?
var tickImage = tickImageDay

let tickNotSelectedImageDay = UIImage(named: "TickNotSelectedDay") as UIImage?
var tickNotSelectedImage = tickNotSelectedImageDay


let minutes10BtnImageDay = UIImage(named: "10MINBtnDay") as UIImage?
var minutes10BtnImage = minutes10BtnImageDay
let minutes10PressedBtnImageDay = UIImage(named: "10MINPressedBtnDay") as UIImage?
var minutes10PressedBtnImage = minutes10PressedBtnImageDay

let minute1BtnImageDay = UIImage(named: "1MINBtnDay") as UIImage?
var minute1BtnImage = minute1BtnImageDay
let minute1PressedBtnImageDay = UIImage(named: "1MINPressedBtnDay") as UIImage?
var minute1PressedBtnImage = minute1PressedBtnImageDay

let seconds10BtnImageDay = UIImage(named: "10SECBtnDay") as UIImage?
var seconds10BtnImage = seconds10BtnImageDay
let seconds10PressedBtnImageDay = UIImage(named: "10SECPressedBtnDay") as UIImage?
var seconds10PressedBtnImage = seconds10PressedBtnImageDay

let shareBtnImageDay = UIImage(named: "ShareBtnDay") as UIImage?
let shareBtnImageNight = UIImage(named: "ShareBtnNight") as UIImage?
let shareBtnImagePresssedDay = UIImage(named: "ShareBtnPressedDay") as UIImage?
let shareBtnImagePressedNight = UIImage(named: "ShareBtnPressedNight") as UIImage?
var shareBtnImage = shareBtnImageDay
var shareBtnPressedImage = shareBtnImagePresssedDay

let addBtnImageDay = UIImage(named: "CreateEventBtnDay") as UIImage?
var addBtnImage = addBtnImageDay

let addPressedBtnImageDay = UIImage(named: "CreateEventPressedBtnDay") as UIImage?
var addPressedBtnImage = addPressedBtnImageDay

//Not used
//let infoImageDay = UIImage(named: "InfoBtnDay") as UIImage?
//var infoImage = infoImageDay

let favouritesImageDay = UIImage(named: "FavouritesBtnDay") as UIImage?
let favouritesImagePressedDay = UIImage(named: "FavouritesBtnPressedDay") as UIImage?
let favouritesImagePressedNight = UIImage(named: "FavouritesBtnPressedNight") as UIImage?
var favouritesImage = favouritesImageDay
var favouritesPressedImage = favouritesImagePressedDay

let backImageDay = UIImage(named: "BackBtnDay") as UIImage?
let backImageNight = UIImage(named: "BackBtnNight") as UIImage?
let backPressedImageDay = UIImage(named: "BackPressedBtnDay") as UIImage?
let backPressedImageNight = UIImage(named: "BackPressedBtnNight") as UIImage?

var backImage = backImageDay
var backPressedImage = backPressedImageDay

let forwardImageDay = UIImage(named: "ForwardBtnDay") as UIImage?
let forwardImageNight = UIImage(named: "ForwardBtnNight") as UIImage?
let forwardPressedImageDay = UIImage(named: "ForwardPressedBtnDay") as UIImage?
let forwardPressedImageNight = UIImage(named: "ForwardPressedBtnNight") as UIImage?

var forwardImage = forwardImageDay
var forwardPressedImage = forwardPressedImageDay




let addImageDay = UIImage(named: "AddBtnDay") as UIImage?
var addImage = addImageDay


let keyboardBackgroundColorDay = UIColor(red: 206.0/255.0, green: 210.0/255.0, blue: 215.0/255.0, alpha: 1.0)
let keyboardBackgroundColorNight = UIColor(red: 58.0/255.0, green: 62.0/255.0, blue: 65.0/255.0, alpha: 1.0)
var keyboardBackgroundColor = keyboardBackgroundColorDay

let buttonPressedColorDay = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.15)
let buttonPressedColorNight = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.30)
var buttonPressedColor = buttonPressedColorDay



//BEGIN - this is the window Color oif you need a sub-division in the window
let subWindowborderRadius:CGFloat  = 7
let subWindowborderWidth:CGFloat = 0
//END

let subWindowborderColorDay = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
var subWindowborderColorNight = UIColor(red: 113.0/255.0, green: 121.0/255.0, blue: 132.0/255.0, alpha: 1.0)
var subWindowborderColor = subWindowborderColorDay

let subWindowColorDay: UIColor = UIColor( red: CGFloat(0/255.0), green: CGFloat(0/255.0), blue: CGFloat(0/255.0), alpha: CGFloat(0.10))
let subWindowColorNight: UIColor = UIColor( red: CGFloat(255/255.0), green: CGFloat(255/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(0.05))
var subWindowColor = subWindowColorDay

let keyboardKeyColorDay: UIColor = UIColor( red: CGFloat(255/255.0), green: CGFloat(255/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0))
let keyboardKeyColorNight: UIColor = UIColor( red: CGFloat(97/255.0), green: CGFloat(99/255.0), blue: CGFloat(102/255.0), alpha: CGFloat(1.0))
var keyboardKeyColor = keyboardKeyColorDay

let keyboardTextColorDay: UIColor = UIColor( red: CGFloat(0/255.0), green: CGFloat(0/255.0), blue: CGFloat(0/255.0), alpha: CGFloat(1.0))
let keyboardTextColorNight: UIColor = UIColor( red: CGFloat(255/255.0), green: CGFloat(255/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0))
var keyboardTextColor = keyboardTextColorDay



let textTitleColorDay: UIColor = UIColor( red: CGFloat(63/255.0), green: CGFloat(74/255.0), blue: CGFloat(101/255.0), alpha: CGFloat(1.0))
let textTitleColorNight: UIColor = UIColor( red: CGFloat(113.0/255.0), green: CGFloat(121.0/255.0), blue: CGFloat(132.0/255.0), alpha: CGFloat(1.0))
var textTitleColor = textTitleColorDay

let windowColorDay: UIColor = UIColor( red: CGFloat(208/255.0), green: CGFloat(212/255.0), blue: CGFloat(218/255.0), alpha: CGFloat(1.0))
let windowColorNight: UIColor = UIColor( red: CGFloat(39/255.0), green: CGFloat(46/255.0), blue: CGFloat(55/255.0), alpha: CGFloat(1.0))
var windowColor = windowColorDay

let tableSeperatorColorDay: UIColor = UIColor( red: CGFloat(0.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(0.0/255.0), alpha: CGFloat(0.10))
let tableSeperatorColorNight: UIColor = UIColor( red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(0.10))
var tableSeperatorColor =  tableSeperatorColorDay

let lineColorDay: UIColor = UIColor( red: CGFloat(255/255.0), green: CGFloat(255/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0))
let lineColorNight: UIColor = UIColor( red: CGFloat(113/255.0), green: CGFloat(121/255.0), blue: CGFloat(132/255.0), alpha: CGFloat(1.0))
var lineColor = lineColorDay

let mainTextColorDay: UIColor = UIColor( red: CGFloat(63.0/255.0), green: CGFloat(74.0/255.0), blue: CGFloat(101.0/255.0), alpha: CGFloat(1.0))
let mainTextColorNight: UIColor = UIColor( red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(1.0))
var mainTextColor = mainTextColorDay

let subTextColorDay: UIColor = UIColor( red: CGFloat(118.0/255.0), green: CGFloat(118.0/255.0), blue: CGFloat(118.0/255.0), alpha: CGFloat(1.0))
let subTextColorNight: UIColor = UIColor( red: CGFloat(113.0/255.0), green: CGFloat(121.0/255.0), blue: CGFloat(132.0/255.0), alpha: CGFloat(1.0))
var subTextColor = subTextColorDay

let attentionTextColorDay: UIColor = UIColor( red: CGFloat(48.0/255.0), green: CGFloat(80.0/255.0), blue: CGFloat(201.0/255.0), alpha: CGFloat(1.0))
let attentionTextColorNight: UIColor = UIColor( red: CGFloat(76.0/255.0), green: CGFloat(217.0/255.0), blue: CGFloat(100.0/255.0), alpha: CGFloat(1.0))
var attentionTextColor = attentionTextColorDay

let clockColorDay: UIColor = UIColor( red: CGFloat(0.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(0.0/255.0), alpha: CGFloat(1.0))
let clockColorNight: UIColor = UIColor( red: CGFloat(255.0/255.0), green: CGFloat(255.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(1.0))
var clockColor = clockColorDay


let timerInScreensaverColor: UIColor = UIColor( red: CGFloat(255.0/255.0), green: CGFloat(92.0/255.0), blue: CGFloat(52.0/255.0), alpha: CGFloat(1.0))


//BEGIN Night Colors

let nightBackgroundImage = UIImage(named: "Night Base Screen") as UIImage?

let noteBtnImageNight = UIImage(named: "NoteBtnNight") as UIImage?



let maxBirthdayCaldendarImageNight = UIImage(named: "MaxCurrentEventBtnNight") as UIImage?
let minBirthdayCaldendarImageNight = UIImage(named: "MinCurrentEventBtnNight") as UIImage?

let keyboardCloseImageNight = UIImage(named: "KeyboardCloseBtnNight") as UIImage?
let keyboardDeleteImageNight = UIImage(named: "KeyboardDeleteBtnNight") as UIImage?
let keyboardEditImageNight = UIImage(named: "KeyboardEditBtnNight") as UIImage?




let cancelCalendarEventImageNight = UIImage(named: "CancelCalendarEventBtnNight") as UIImage?
let addCalendarEventImageNight = UIImage(named: "AddCalendarEventBtnNight") as UIImage?
let updateCalendarEventImageNight = UIImage(named: "UpdateCalendarEventBtnNight") as UIImage?
let deleteCalendarEventImageNight = UIImage(named: "DeleteCalendarEventBtnNight") as UIImage?

let cancelCalendarEventPressedImageNight = UIImage(named: "CancelCalendarEventPressedBtnNight") as UIImage?
let addCalendarEventPressedImageNight = UIImage(named: "AddCalendarEventPressedBtnNight") as UIImage?
let updateCalendarEventPressedImageNight = UIImage(named: "UpdateCalendarEventPressedBtnNight") as UIImage?
let deleteCalendarEventPressedImageNight = UIImage(named: "DeleteCalendarEventPressedBtnNight") as UIImage?

//let infoImageNight = UIImage(named: "InfoBtnNight") as UIImage?



let TopHeaderImageNight = UIImage(named: "TopHeaderNight") as UIImage?
let TopHeaderTitleBoxWeekImageNight = UIImage(named: "HeaderTitleBoxWeekNight") as UIImage?

let selectPhotoAlbumImageNight = UIImage(named: "SelectPhotoAlbumBtnNight") as UIImage?
let selectPhotoAlbumImagePressedNight = UIImage(named: "SelectPhotoAlbumPressedBtnNight") as UIImage?

let vibrationMaxImageNight = UIImage(named: "VibrationMaxNight") as UIImage?
let vibrationMinImageNight = UIImage(named: "VibrationMinNight") as UIImage?

let brightnessMaxImageNight = UIImage(named: "BrightnessMaxNight") as UIImage?
let brightnessMinImageNight = UIImage(named: "BrightnessMinNight") as UIImage?

let photoSlideShowImageNight = UIImage(named: "PhotoSlideShowBtnNight") as UIImage?
let settingsImageNight = UIImage(named: "SettingsBtnNight") as UIImage?

let yesterdayImageNight = UIImage(named: "YesterdayBtnNight") as UIImage?
let nextDayImageNight = UIImage(named: "NextDayBtnNight") as UIImage?
let addImageNight = UIImage(named: "AddBtnNight") as UIImage?

let createCalendarBtnImageNight = UIImage(named: "CreateCalendarBtnNight") as UIImage?

let startBtnImageNight = UIImage(named: "StartBtnNight") as UIImage?
let startPressedBtnImageNight = UIImage(named: "StartPressedBtnNight") as UIImage?

let cancelPopupBtnImageNight = UIImage(named: "CancelPopupBtnNight") as UIImage?
let deletePopupBtnImageNight = UIImage(named: "DeletePopupBtnNight") as UIImage?

let cancelPopupBtnImagePressedNight = UIImage(named: "CancelPopupPressedBtnNight") as UIImage?
let deletePopupBtnImagePressedNight = UIImage(named: "DeletePopupPressedBtnNight") as UIImage?

let resetBtnImageNight = UIImage(named: "ResetBtnNight") as UIImage?
let resetPressedBtnImageNight = UIImage(named: "ResetPressedBtnNight") as UIImage?

let tickImageNight = UIImage(named: "TickNight") as UIImage?
let tickNotSelectedImageNight = UIImage(named: "TickNotSelectedNight") as UIImage?

let minutes10BtnImageNight = UIImage(named: "10MINBtnNight") as UIImage?
let minutes10PressedBtnImageNight = UIImage(named: "10MINPressedBtnNight") as UIImage?

let minute1BtnImageNight = UIImage(named: "1MINBtnNight") as UIImage?
let minute1PressedBtnImageNight = UIImage(named: "1MINPressedBtnNight") as UIImage?

let seconds10BtnImageNight = UIImage(named: "10SECBtnNight") as UIImage?
let seconds10PressedBtnImageNight = UIImage(named: "10SEC_PressedBtnNight") as UIImage?



let addBtnImageNight = UIImage(named: "CreateEventBtnNight") as UIImage?
let addPressedBtnImageNight = UIImage(named: "CreateEventPressedBtnNight") as UIImage?

let favouritesImageNight = UIImage(named: "FavouritesBtnNight") as UIImage?

var currentThemeIsDay = true

let calendarMarkerImageNight = UIImage(named: "CalendarMarkerNight") as UIImage?
let todayMarkerImageNight = UIImage(named: "TodayMarkerNight") as UIImage?

let upBtnImageNight = UIImage(named: "UpBtnNight") as UIImage?
let upPressedBtnImageNight = UIImage(named: "UpPressedBtnNight") as UIImage?
let downBtnImageNight = UIImage(named: "DownBtnNight") as UIImage?
let downPressedBtnImageNight = UIImage(named: "DownPressedBtnNight") as UIImage?

let amBtnImageNight = UIImage(named: "amBtnNight") as UIImage?
let pmBtnImageNight = UIImage(named: "pmBtnNight") as UIImage?


//END

func setStyle(daytime:Bool){
    dayMode = daytime //setting global variable (reset and start timer need this)
    
    if daytime == true{
        
        currentThemeIsDay = true
        backgroundImage = dayBackgroundImage
        topHeaderImage = TopHeaderImageDay
        TopHeaderTitleBoxWeekImage = TopHeaderTitleBoxWeekImageDay
        borderColor = borderColorDay
        subWindowborderColor = subWindowborderColorDay
        textTitleColor = textTitleColorDay
        windowColor = windowColorDay
        subWindowColor = subWindowColorDay
        lineColor = lineColorDay
        mainTextColor = mainTextColorDay
        subTextColor = subTextColorDay
        attentionTextColor = attentionTextColorDay
        clockColor = clockColorDay
        
        
        photoSlideShowImage = photoSlideShowImageDay
        photoSlideShowPressedImage = photoSlideShowImagePressedDay
        settingsImage = settingsImageDay
        settingsPressedImage = settingsPressedImageDay
        yesterdayImage = yesterdayImageDay
        nextDayImage = nextDayImageDay
        
        EditCalendarBtnImage = EditCalendarBtnImageDay
        EditCalendarPressedBtnImage = EditCalendarPressedBtnImageDay
        weekViewBtnImage = weekViewBtnImageDay
        monthViewBtnImage = monthViewBtnImageDay
        weekViewPressedBtnImage = weekViewPressedBtnImageDay
        monthViewPressedBtnImage = monthViewPressedBtnImageDay
        
        startBtnImage = startBtnImageDay
        resetBtnImage = resetBtnImageDay
        
        startPressedBtnImage = startPressedBtnImageDay
        resetPressedBtnImage = resetPressedBtnImageDay
        
        
        
        tableSeperatorColor = tableSeperatorColorDay
        tickImage = tickImageDay
        
        minutes10BtnImage = minutes10BtnImageDay
        minute1BtnImage = minute1BtnImageDay
        seconds10BtnImage = seconds10BtnImageDay
        minutes10PressedBtnImage = minutes10PressedBtnImageDay
        minute1PressedBtnImage = minute1PressedBtnImageDay
        seconds10PressedBtnImage = seconds10PressedBtnImageDay
        shareBtnImage = shareBtnImageDay
        shareBtnPressedImage = shareBtnImagePresssedDay
    
        addPressedBtnImage = addPressedBtnImageDay
        addBtnImage = addBtnImageDay
     
        
        favouritesImage = favouritesImageDay
        favouritesPressedImage = favouritesImagePressedDay
        
        cancelPopupBtnPressedImage = cancelPopupBtnImagePressedDay
        deletePopupBtnPressedImage = deletePopupBtnImagePressedDay
        cancelPopupBtnImage = cancelPopupBtnImageDay
        deletePopupBtnImage = deletePopupBtnImageDay
    
        keyboardBackgroundColor = keyboardBackgroundColorDay
        keyboardKeyColor = keyboardKeyColorDay
        keyboardTextColor = keyboardTextColorDay
        
        
        calendarMarkerImage = calendarMarkerImageDay
        todayMarkerImage = todayMarkerImageDay
        closeImage = closeImageDay
        closePressedImage = closePressedImageDay
        backImage = backImageDay
        backPressedImage = backPressedImageDay
        
        forwardImage = forwardImageDay
        forwardPressedImage = forwardPressedImageDay
        
        vibrationMinImage = vibrationMinImageDay
        vibrationMaxImage = vibrationMaxImageDay
        
        brightnessMinImage = brightnessMinImageDay
        brightnessMaxImage = brightnessMaxImageDay
        addImage = addImageDay
        headerTitleImage = TopHeaderTitleBoxImageDay
        
        tickNotSelectedImage = tickNotSelectedImageDay
    
        cancelCalendarEventImage = cancelCalendarEventImageDay
        addCalendarEventImage = addCalendarEventImageDay
        updateCalendarEventImage = updateCalendarEventImageDay
        deleteCalendarEventImage = deleteCalendarEventImageDay
    
        cancelCalendarEventPressedImage = cancelCalendarEventPressedImageDay
        addCalendarEventPressedImage = addCalendarEventPressedImageDay
        updateCalendarEventPressedImage = updateCalendarEventPressedImageDay
        deleteCalendarEventPressedImage = deleteCalendarEventPressedImageDay
        
        selectPhotoAlbumImage = selectPhotoAlbumImageDay
        selectPhotoAlbumImagePressed = selectPhotoAlbumImagePressedDay
    
        maxBirthdayCaldendarImage = maxBirthdayCaldendarImageDay
        minBirthdayCaldendarImage = minBirthdayCaldendarImageDay
    
        keyboardCloseImage = keyboardCloseImageDay
        keyboardDeleteImage = keyboardDeleteImageDay
        keyboardEditImage = keyboardEditImageDay
        
        upBtnImage = upBtnImageDay
        upPressedBtnImage = upPressedBtnImageDay
        downBtnImage = downBtnImageDay
        downPressedBtnImage = downPressedBtnImageDay
        amBtnImage = amBtnImageDay
        pmBtnImage = pmBtnImageDay
       
        
        noteBtnImage = noteBtnImageDay
        noteBtnPressedImage = noteBtnImagePressedDay
        lineBreakImage = lineBreakImageDay
        
        deleteImage = deleteImageDay
        deletePressedImage = deleteImagePressedDay
        editImg = editImgDay
        
        selectRectangleImg = selectRectangleImgDay
        notSelectRectangleImg = notSelectRectangleImgDay
        
        OKImg = OKImgDay
        OKPressedImg = OKPressedImgDay
        moreArrowImage = moreArrowImageDay
        updateButtonImage = updateButtonImageDay
        updatePressedButtonImage = updatePressedButtonImageDay
        
        collapseDrawerImage = collapseDrawerImageDay
        collapseDrawerPressedImage = collapseDrawerPressedImageDay
        expandDrawerImage = expandDrawerImageDay
        expandDrawerPressedImage = expandDrawerPressedImageDay
        
        upcommingEventImg = upcommingEventImgDay
        upcommingEventPressedImg = upcommingEventPressedImgDay
        
        searchCalendarImage = searchCalendarImageDay
        searchCalendarPressedImage = searchCalendarPressedImageDay
        
        infoSettingsImage = infoSettingsImageDay
        calendarSelectionSettingsImage = calendarSelectionSettingsImageDay
        inAppSettingsImage = inAppSettingsImageDay
        photoLibrarySelectionSettingsImage = photoLibrarySelectionSettingsImageDay
        photoDisplaySettingsImage = photoDisplaySettingsImageDay
        inAppRestoreSettingsImage = inAppRestoreSettingsImageDay
        screenBrightnessSettingsImage = screenBrightnessSettingsImageDay
        calendarEditSettingsImage = calendarEditSettingsImageDay
        buttonPressedColor = buttonPressedColorDay
        timerImage = timerImageDay
        timerPressedImage = timerPressedImageDay
        timerActiveImage = timerActiveImageDay
        timerActivePressedImage = timerActivePressedImageDay
        reminderImage = reminderImageDay
        reminderPressedImage = reminderPressedImageDay
        
        lockImage = lockImageDay
        lockPressedImage = lockPressedImageDay
        
        weekOutlookImage = WeekOutlookImageDay
        weekOutlookPressedImage = WeekOutlookPressedImageDay
    }
    else{
        
        currentThemeIsDay = false
        backgroundImage = nightBackgroundImage
        topHeaderImage = TopHeaderImageNight
        TopHeaderTitleBoxWeekImage = TopHeaderTitleBoxWeekImageNight
        borderColor = borderColorNight
        subWindowborderColor = subWindowborderColorNight
        textTitleColor = textTitleColorNight
        windowColor = windowColorNight
        subWindowColor = subWindowColorNight
        lineColor = lineColorNight
        mainTextColor = mainTextColorNight
        subTextColor = subTextColorNight
        attentionTextColor = attentionTextColorNight
        clockColor = clockColorNight
        
        
        photoSlideShowImage = photoSlideShowImageNight
        photoSlideShowPressedImage = photoSlideShowImagePressedNight
        settingsImage = settingsImageNight
        settingsPressedImage = settingsPressedImageNight
       

        yesterdayImage = yesterdayImageNight
        nextDayImage = nextDayImageNight
        EditCalendarBtnImage = EditCalendarBtnImageNight
        EditCalendarPressedBtnImage = EditCalendarPressedBtnImageNight
        weekViewBtnImage = weekViewBtnImageNight
        monthViewBtnImage = monthViewBtnImageNight
        weekViewPressedBtnImage = weekViewPressedBtnImageNight
        monthViewPressedBtnImage = monthViewPressedBtnImageNight
        startBtnImage = startBtnImageNight
        resetBtnImage = resetBtnImageNight
        startPressedBtnImage = startPressedBtnImageNight
        resetPressedBtnImage = resetPressedBtnImageNight
        
        deleteImage = deleteImageNight
        deletePressedImage = deleteImagePressedNight
        
        
        tableSeperatorColor = tableSeperatorColorNight
        tickImage = tickImageNight
        minutes10BtnImage = minutes10BtnImageNight
        minute1BtnImage = minute1BtnImageNight
        seconds10BtnImage = seconds10BtnImageNight
        minutes10PressedBtnImage = minutes10PressedBtnImageNight
        minute1PressedBtnImage = minute1PressedBtnImageNight
        seconds10PressedBtnImage = seconds10PressedBtnImageNight
        
        shareBtnImage = shareBtnImageNight
        shareBtnPressedImage = shareBtnImagePressedNight
        
        addPressedBtnImage = addPressedBtnImageNight
        addBtnImage = addBtnImageNight
        favouritesImage = favouritesImageNight
        favouritesPressedImage = favouritesImagePressedNight
        deleteImage = deleteImageNight
        cancelPopupBtnPressedImage = cancelPopupBtnImagePressedNight
        deletePopupBtnPressedImage = deletePopupBtnImagePressedNight
        cancelPopupBtnImage = cancelPopupBtnImageNight
        deletePopupBtnImage = deletePopupBtnImageNight
    
        keyboardBackgroundColor = keyboardBackgroundColorNight
        keyboardKeyColor = keyboardKeyColorNight
        keyboardTextColor = keyboardTextColorNight
        
        calendarMarkerImage = calendarMarkerImageNight
        todayMarkerImage = todayMarkerImageNight
        
        closeImage = closeImageNight
        closePressedImage = closePressedImageNight
        backImage = backImageNight
        backPressedImage = backPressedImageNight
        
        forwardImage = forwardImageNight
        forwardPressedImage = forwardPressedImageNight
        
        vibrationMinImage = vibrationMinImageNight
        vibrationMaxImage = vibrationMaxImageNight
        
        brightnessMinImage = brightnessMinImageNight
        brightnessMaxImage = brightnessMaxImageNight
        addImage = addImageNight
        tickNotSelectedImage = tickNotSelectedImageNight
        
        cancelCalendarEventImage = cancelCalendarEventImageNight
        addCalendarEventImage = addCalendarEventImageNight
        updateCalendarEventImage = updateCalendarEventImageNight
        deleteCalendarEventImage = deleteCalendarEventImageNight
    
        cancelCalendarEventPressedImage = cancelCalendarEventPressedImageNight
        addCalendarEventPressedImage = addCalendarEventPressedImageNight
        updateCalendarEventPressedImage = updateCalendarEventPressedImageNight
        deleteCalendarEventPressedImage = deleteCalendarEventPressedImageNight
        //Image = infoImageNight
        selectPhotoAlbumImage = selectPhotoAlbumImageNight
        selectPhotoAlbumImagePressed = selectPhotoAlbumImagePressedNight
    
        maxBirthdayCaldendarImage = maxBirthdayCaldendarImageNight
        minBirthdayCaldendarImage = minBirthdayCaldendarImageNight
        
        keyboardCloseImage = keyboardCloseImageNight
        keyboardDeleteImage = keyboardDeleteImageNight
        keyboardEditImage = keyboardEditImageNight
        
        
        upBtnImage = upBtnImageNight
        upPressedBtnImage = upPressedBtnImageNight
        downBtnImage = downBtnImageNight
        downPressedBtnImage = downPressedBtnImageNight
        amBtnImage = amBtnImageNight
        pmBtnImage = pmBtnImageNight
       
        noteBtnImage = noteBtnImageNight
        noteBtnPressedImage = noteBtnImagePressedNight
        lineBreakImage = lineBreakImageNight
        editImg = editImgNight
        selectRectangleImg = selectRectangleImgNight
        notSelectRectangleImg = notSelectRectangleImgNight
        
        OKImg = OKImgNight
        OKPressedImg = OKPressedImgNight
        moreArrowImage = moreArrowImageNight
        updateButtonImage = updateButtonImageNight
        updatePressedButtonImage = updatePressedButtonImageNight
        
        
        collapseDrawerImage = collapseDrawerImageNight
        collapseDrawerPressedImage = collapseDrawerPressedImageNight
        expandDrawerImage = expandDrawerImageNight
        expandDrawerPressedImage = expandDrawerPressedImageNight
        
        upcommingEventImg = upcommingEventImgNight
        upcommingEventPressedImg = upcommingEventPressedImgNight
        
        searchCalendarImage = searchCalendarImageNight
        searchCalendarPressedImage = searchCalendarPressedImageNight
        headerTitleImage = TopHeaderTitleBoxImageNight
        
        infoSettingsImage = infoSettingsImageNight
        calendarSelectionSettingsImage = calendarSelectionSettingsImageNight
        inAppSettingsImage = inAppSettingsImageNight
        photoLibrarySelectionSettingsImage = photoLibrarySelectionSettingsImageNight
        photoDisplaySettingsImage = photoDisplaySettingsImageNight
        inAppRestoreSettingsImage = inAppRestoreSettingsImageNight
        screenBrightnessSettingsImage = screenBrightnessSettingsImageNight
        calendarEditSettingsImage = calendarEditSettingsImageNight
        buttonPressedColor = buttonPressedColorNight
        timerImage = timerImageNight
        timerPressedImage = timerPressedImageNight
        
        timerActiveImage = timerActiveImageNight
        timerActivePressedImage = timerActivePressedImageNight
        reminderImage = reminderImageNight
        reminderPressedImage = reminderPressedImageNight
        lockImage = lockImageNight
        lockPressedImage = lockPressedImageNight
        
        weekOutlookImage = WeekOutlookImageNight
        weekOutlookPressedImage = WeekOutlookPressedImageNight
    }
}
