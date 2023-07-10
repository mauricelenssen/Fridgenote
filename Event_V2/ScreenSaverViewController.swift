//
//  ScreenSaverViewController.swift
//  Event_V2
//
//  Created by Lenssen, Maurice (M.) on 18/6/19.
//  Copyright © 2019 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit
import Photos
import CoreMotion

enum subTitleState : Int {
    case date,deltaTime,off
}
var upNextImage: UIImage? = UIImage(named: "") as UIImage?
var photoUpNextCounter: Int = 0    //Counter to track the next photo in the playlist to display in screensave, if photo shuffle is off

//var photoView: UIView!                    //need to be set here else you can't remove it
var photoTimer: Timer?
var clockTimer: Timer?                      //Timer to update the time
var subTitleStatus: subTitleState = .date   //Default for the subtitle is the date when the photo was taken

var motionManager: CMMotionManager!        //you need this to monitor if ipad moves for door detection
var photoAccessApproved:Bool = false
//var authorizationPhotoAccessUpdate:Bool = false
var animationInProgress: Bool = false     //This flasg is to make sure you do nto start another instance of the animatio nwhen one is running
var imageDateTaken: Date = Date()         //Date when the photo was taken
var currentImageDateTaken: Date = Date()  //Date when the photo was taken, which is shown at the moment


var longitude :CLLocationDegrees = -122.0312186
var latitude :CLLocationDegrees = -122.0312186
var locationDataAvailable: Bool = false  //This flag tells future function if there is valid location data in the photo

var imageIsInCache: Bool = false

//BEGIN - Ask for permission to access photos

func  PhotoAuthorizations() -> (Bool) {
    
    var accessAproved: Bool = false
    let status = PHPhotoLibrary.authorizationStatus()
    
    switch status {
    case .authorized:
        accessAproved = true
    case .notDetermined:
        PHPhotoLibrary.requestAuthorization() { status in
            if status == .authorized {
                DispatchQueue.main.async {
                    accessAproved = true
                    //authorizationPhotoAccessUpdate = true //update the the main loop so the feature gets enabled
                }
            }
        }
    case .restricted:
        print ("Photo Access Restricted")
    case .denied:
        print ("Photo Access Denied")
    default:
        accessAproved = false
    }
    return accessAproved
}
//END


private func fetchOptions() -> PHFetchOptions {
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    return fetchOptions
}


class ScreenSaverViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet var clockLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var screenSaverBackgroundView: UIView!
    @IBOutlet var timerLbl: UILabel!
    @IBOutlet var timerView: UIView!
    @IBOutlet var photoSkipBtn: UIButton!
    @IBOutlet var creationDateLbl: UILabel!
    @IBOutlet var subTitleBtn: UIButton!
    @IBOutlet var timerBarView: UIView?
    @IBOutlet var locationLable: UILabel!
    
    var blockSkipButton:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("View Did Load")
    }
    
    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        print ("View Appear, Screen Saver")
        photoAccessApproved = PhotoAuthorizations()
        upNextImage = UIImage(named: "") as UIImage?
        loadImage(cacheImage: false) // load the initial photo, so no need to cache
        
        
        //BEGIN - Set the photo Skip button, this button has no day/night version as it is overlayed on the phot
        let photoSkipImg = UIImage(named: "PhotoSkipBtn") as UIImage?
        let photoSkipPressedImg = UIImage(named: "PhotoSkipPressedBtn") as UIImage?
        photoSkipBtn!.setImage(photoSkipImg, for: .normal)
        photoSkipBtn!.setImage(photoSkipPressedImg, for: .highlighted)
        photoSkipBtn!.layer.shadowColor = UIColor.black.cgColor
        photoSkipBtn!.layer.shadowOpacity = shadowOpacityButtons
        photoSkipBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        photoSkipBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
        //END
        
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
        timerView?.layer.cornerRadius = cornerRadiusWindow
        screenSaverActive = true
        screenSaverAllowed = false //stop the screen saver delay timer
        screenSaverCounter = 0     //Reset the screen saver counter, so when you return it does not get activated directly
        screenSaverBackgroundView.backgroundColor = .black
        clockLbl.isHidden = true
        dateLbl.isHidden = true
        timerBarView?.backgroundColor = timerInScreensaverColor
        timerLbl?.textColor = timerInScreensaverColor
        timerLbl?.font = UIFont.monospacedDigitSystemFont(ofSize: 60.0, weight: UIFont.Weight.regular)
        
        if (photoMotion){
            animatePhotoView()
        }
        else{
            staticPhotoView()
        }
        
        currentImageDateTaken = imageDateTaken
        if displayCreationDateInPhoto == true
        {
            updatePhotoSubtitle(state:subTitleStatus, photoDate: currentImageDateTaken)
        }
        else
        {
            updatePhotoSubtitle(state:.off, photoDate: currentImageDateTaken)
        }
        
        
        updateClockLbl()
        //BEGIN we will only use the gyro to detect the fridge door
        motionManager = CMMotionManager()
        if (motionManager.isGyroAvailable){
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(
                to: OperationQueue.current!,
                withHandler: { (gyroData: CMGyroData?, errorOC: Error?) in
                    self.outputGyroData(gyro: gyroData!)
                })
        }
        
        //BEGIN - Start to update the photo slide
        if (photoMotion){
            photoTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.animatePhotoView), userInfo: nil, repeats: true)
        }
        else{
            photoTimer = Timer.scheduledTimer(timeInterval: photoDelayBetweenPhotos, target: self, selector: #selector(self.staticPhotoView), userInfo: nil, repeats: true)
        }
        clockTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateClockLbl), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("View will disappear, Stop notification")
        photoTimer?.invalidate()
        clockTimer?.invalidate()
        motionManager.stopGyroUpdates() // Stop the gyro so they don't go off in other viewcontrollers.
        screenSaverAllowed = true //enable the screen saver delay timer
        screenSaverCounter = 0     //Reset the screen saver counter, so when you return it does not get activated directly
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AlarmNotification"), object: nil)
    }
    
    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print("TimerExpiredSegue4")
        performSegue(withIdentifier: "TimerExpiredSegue4", sender: nil)
    }
    //END
    
    @objc func updateClockLbl(){
        if (clockInPhoto){
            clockLbl.textColor = .white
            clockLbl.isHidden = false
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm"
            clockLbl!.text = dateFormatter.string(from: Date() as Date)
        }
        
        if (dateInPhoto){
            dateLbl.textColor = .white
            dateLbl.isHidden = false
            let dateFormatter = DateFormatter()
            //dateFormatter.dateFormat = "d MMMM"
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMMMM", options: 0, locale: Locale.current)
            dateLbl!.text = dateFormatter.string(from: Date() as Date)
        }
        
        if (timerRunning == true) //display timer in screen saver if kitchentimer is running
        {
            timerView?.isHidden = false
            timerLbl!.text = timeString(time: timerSeconds)
        }
        else {
            timerView?.isHidden = true
        }
    }
    
    @IBAction func nextPhotoPressed(){
        
        if (photoMotion){
            //BEGIN - Fade the foto out
            //photoSkipBtn.isEnabled = false // prevents black screen, when you press button very quickly a number of times
            if blockSkipButton == false {
                UIView.animate(withDuration: 0.01, animations: {
                    self.photoImageView.alpha = 0
                    
                }) { (finished) in
                    
                    //print ("Photo Animation Finished")
                }
                animationInProgress = false
                photoImageView.layer.removeAllAnimations() // remove layer based animations
                view.layer.removeAllAnimations()
            }
        }
        
        else{
            //BEGIN - you need to do this, else if user presses skip 1 seocnd before the end the new foto is only displayed for 1 sec.
            photoTimer?.invalidate()
            photoTimer = Timer.scheduledTimer(timeInterval: photoDelayBetweenPhotos, target: self, selector: #selector(self.staticPhotoView), userInfo: nil, repeats: true)
            //staticPhotoView()
            skip_staticPhotoView()
        }
    }
    
    @objc func animatePhotoView() {
        //BEGIN - update the photo
        if (animationInProgress == false)
        {
            self.locationLable.text = ""
            photoImageView.backgroundColor = UIColor.black
            
            self.photoImageView.image = upNextImage
            
            
            if locationInPhoto && locationDataAvailable
            {
                let location = CLLocation(latitude: latitude, longitude: longitude)
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    print(location)
                    guard error == nil else {
                        print("Reverse geocoder failed with error" + error!.localizedDescription)
                        return
                    }
                    guard placemarks!.count > 0 else {
                        print("Problem with the data received from geocoder")
                        return
                    }
                    let pm = placemarks![0]
                    if pm.locality != nil {
                        print(pm.locality as Any)
                        self.locationLable.text = pm.locality!
                    }
                })
            }
            
            currentImageDateTaken = imageDateTaken
            
            if displayCreationDateInPhoto == true
            {
                updatePhotoSubtitle(state:subTitleStatus, photoDate: currentImageDateTaken)
            }
            else
            {
                updatePhotoSubtitle(state:.off, photoDate: currentImageDateTaken)
            }

            self.photoImageView.alpha = 0.0
            loadImage(cacheImage: true)
            self.photoImageView.transform = CGAffineTransform.identity
            
            animationInProgress = true
            self.blockSkipButton = true
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                print ("Photo Animation Started")
                self.photoImageView.alpha = 1.0
            }) { (finished) in
                self.blockSkipButton = false
                UIView.animate(withDuration: photoDelayBetweenPhotos, delay: 0.0, options: .curveEaseIn, animations: {
                    self.photoImageView.transform = CGAffineTransform.identity.scaledBy(x: 1.1+CGFloat(photoMotionSpeed*maxZoomLevelPhoto), y: 1.1+CGFloat(photoMotionSpeed*maxZoomLevelPhoto))
                    
                }) { (finished) in
                    self.blockSkipButton = true
                    UIView.animate(withDuration: 0.3, animations: {
                        self.photoImageView.alpha = 0
                        
                    }) { (finished) in
                        print ("Photo Animation Finished")
                        self.blockSkipButton = false
                        
                    }
                    
                    animationInProgress = false
                }
            }
        }
    }
    
    @IBAction func photoSubTittlePressed () {
        if displayCreationDateInPhoto {
            switch subTitleStatus {
            case .date:
                subTitleStatus = .deltaTime
                //print ("Date subtitle")
                
            case .deltaTime:
                subTitleStatus = .date
                //print ("delta time subtite")
            case . off:
                subTitleStatus = .off
            }
            updatePhotoSubtitle(state:subTitleStatus, photoDate: currentImageDateTaken)
        }
    }
    
    
    
    
    
    func updatePhotoSubtitle(state:subTitleState, photoDate: Date) {
        switch state {
        case .date:
            print ("Date subtitle")
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMMMMYYYY", options: 0, locale: Locale.current)
            self.creationDateLbl.text = dateFormatter.string(from: photoDate as Date)
            
        case .deltaTime:
            print ("delta time subtite")
            let components = Calendar.current.dateComponents([.year,.month,.day], from: photoDate, to: Date())
            var dayInput = components.day
            var monthInput = components.month
            let yearInput = components.year
            
            if yearInput! > 0 {dayInput = 0} // if the data of the photo taken was more than a year, the days do not count
            if yearInput! > 5 {monthInput = 0} // if the data of the photo taken was more than 5 years ago, the months do not count
            self.creationDateLbl.text = updatePhotoDurationString (day:dayInput ?? 0, month:monthInput ?? 0, year: yearInput ?? 0) + NSLocalizedString("ago.", comment: "")
            
        case .off:
            print ("date subtite is switched off")
            self.creationDateLbl.text = ""
        }
    }
    
    @objc func staticPhotoView()
    {
        self.locationLable.text = ""
        photoImageView.backgroundColor = UIColor.black
        self.photoImageView.image = upNextImage
        currentImageDateTaken = imageDateTaken
        if locationInPhoto && locationDataAvailable
        {
            let location = CLLocation(latitude: latitude, longitude: longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                print(location)
                guard error == nil else {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                guard placemarks!.count > 0 else {
                    print("Problem with the data received from geocoder")
                    return
                }
                let pm = placemarks![0]
                if pm.locality != nil {
                    print(pm.locality as Any)
                    self.locationLable.text = pm.locality!
                }
            })
        }
        updatePhotoSubtitle(state:subTitleStatus, photoDate: currentImageDateTaken)
        loadImage(cacheImage: true) // load the next image in memory for next time
    }
    
    @objc func skip_staticPhotoView()
    {
        self.locationLable.text = ""
        photoImageView.backgroundColor = UIColor.black
        
        if imageIsInCache
        {
            self.photoImageView.image = upNextImage
            currentImageDateTaken = imageDateTaken
            if locationInPhoto && locationDataAvailable
            {
                let location = CLLocation(latitude: latitude, longitude: longitude)
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    print(location)
                    guard error == nil else {
                        print("Reverse geocoder failed with error" + error!.localizedDescription)
                        return
                    }
                    guard placemarks!.count > 0 else {
                        print("Problem with the data received from geocoder")
                        return
                    }
                    let pm = placemarks![0]
                    if pm.locality != nil {
                        print(pm.locality as Any)
                        self.locationLable.text = pm.locality!
                    }
                })
            }
            
            if displayCreationDateInPhoto == true
            {
                updatePhotoSubtitle(state:subTitleStatus, photoDate: currentImageDateTaken)
            }
            else
            {
                updatePhotoSubtitle(state:.off, photoDate: currentImageDateTaken)
            }
            
            
            loadImage(cacheImage: true)
        }
        else
        {
            loadImage(cacheImage: false) //this need to load directly and it will update the image untill full resolution image has been donwloaded
            if locationInPhoto && locationDataAvailable
            {
                let location = CLLocation(latitude: latitude, longitude: longitude)
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    print(location)
                    guard error == nil else {
                        print("Reverse geocoder failed with error" + error!.localizedDescription)
                        return
                    }
                    guard placemarks!.count > 0 else {
                        print("Problem with the data received from geocoder")
                        return
                    }
                    let pm = placemarks![0]
                    if pm.locality != nil {
                        print(pm.locality as Any)
                        self.locationLable.text = pm.locality!
                    }
                })
            }
        }
    }
    
    func outputGyroData(gyro: CMGyroData){
        
        let fridgeDoorMovedx: Double = abs(gyro.rotationRate.x)
        let fridgeDoorMovedy: Double = abs(gyro.rotationRate.y)
        let fridgeDoorMovedz: Double = abs(gyro.rotationRate.z)
        let movement = fridgeDoorMovedx + fridgeDoorMovedy + fridgeDoorMovedz
        
        if (movement > Double(fridgeDoorSensitivity)) && (fridgeDoorMovementUserEnabled == true){
            print("Fridge door opened or closed")
            photoBackBtnClicked()
        }
    }
    
    @IBAction func photoBackBtnClicked()
    {
        print ("Stop the Screensaver")
        screenSaverActive = false
        screenSaverAllowed = true  //allow slide show to start when in settings screen
        screenSaverCounter = 0    //Reset the screen saver counter
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    
    
    
    func loadImage(cacheImage: Bool) {
        var assetCollection = PHAssetCollection()
        var photoAssets = PHFetchResult<PHAsset>()
        locationDataAvailable = false
        if (photoAccessApproved)
        {
            if userSelectedPhotoAlbum == allPhotoAlbumCode
            {
                print ("All photo albums loading")
                let fetchOptions = PHFetchOptions()
                photoAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            }
            else
            {
                let fetchOptions = PHFetchOptions()
                fetchOptions.predicate = NSPredicate(format: "localIdentifier = %@", userSelectedPhotoAlbum)
                let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
                if let firstObject = collection.firstObject{
                    //Found the album
                    assetCollection = firstObject
                    photoAssets = PHAsset.fetchAssets(in: assetCollection, options: nil)
                }
            }
            
            let maxNumberOfPhotosWithoutPurchase = 5
            
            var numberOfImagesInPlaylist = photoAssets.count
            //BEGIN - Only allow user to see limited images if he did not buy the inapp purchase
            if inAppPurchased == false {
                if numberOfImagesInPlaylist > maxNumberOfPhotosWithoutPurchase {numberOfImagesInPlaylist = maxNumberOfPhotosWithoutPurchase}
                print ("I LIMIT THE NUMBER OF PHOTOS")
            }
            //END
            if numberOfImagesInPlaylist != 0 { //if the user has selected an album with no photo's selected, this prevents a crash
                
                if (photoShuffle){
                    photoUpNextCounter = Int.random(in: 0 ..< numberOfImagesInPlaylist)
                }
                else
                {
                    photoUpNextCounter = photoUpNextCounter + 1
                    if photoUpNextCounter == (numberOfImagesInPlaylist)
                    {
                        photoUpNextCounter = 0
                    }
                }
                
                
                print ("I show photo number: \(photoUpNextCounter)")
                
                let manager = PHImageManager.default()
                var imageRequestOptions: PHImageRequestOptions {
                    let options = PHImageRequestOptions()
                    options.version = .current
                    options.resizeMode = .exact
                    options.deliveryMode = .opportunistic
                    options.isNetworkAccessAllowed = true
                    options.isSynchronous = false
                    return options
                }
                
                manager.requestImage(for: photoAssets.object(at: photoUpNextCounter),targetSize: CGSize(width: screenWidth, height: screenHeight), contentMode: .default, options: imageRequestOptions)
                {
                    
                    (thumbnail, info) in
                    
                    if let img = thumbnail
                    {
                        if cacheImage
                        {
                            let  imageMetaData : PHAsset = photoAssets.object(at: photoUpNextCounter)
                            imageDateTaken = (imageMetaData.creationDate! as Date)
                            upNextImage = img
                            
                            if locationInPhoto
                            {
                                
                                if ( imageMetaData.location?.coordinate.longitude != nil && imageMetaData.location?.coordinate.latitude != nil)
                                {
                                    longitude = (imageMetaData.location?.coordinate.longitude)!
                                    latitude = (imageMetaData.location?.coordinate.latitude)!
                                    //let location = CLLocation(latitude: latitude, longitude: longitude)
                                    locationDataAvailable = true
                                }
                            }
                        imageIsInCache = true
                        }
                        else //Don't Cache Image, get it straight
                        {
                            let  imageMetaData : PHAsset = photoAssets.object(at: photoUpNextCounter)
                            imageDateTaken = (imageMetaData.creationDate! as Date)
                            self.photoImageView.image = img
                            print ("displayed the image")
                            self.locationLable.text = ""
                            
                            if locationInPhoto
                            {
                                
                                if ( imageMetaData.location?.coordinate.longitude != nil && imageMetaData.location?.coordinate.latitude != nil)
                                {
                                    longitude = (imageMetaData.location?.coordinate.longitude)!
                                    latitude = (imageMetaData.location?.coordinate.latitude)!
                                    locationDataAvailable = true
                                }
                            }
                        imageIsInCache = false
                        }
                    }
                }
            }
        }
    }
}

