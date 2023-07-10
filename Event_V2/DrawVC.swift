//
//  DrawVC.swift
//  Event_V2
//
//  Created by Maurice Lenssen on 24/2/21.
//  Copyright © 2021 Lenssen, Maurice (M.). All rights reserved.
//

import UIKit

var lastPoint = CGPoint.zero
var color = UIColor.red
var selectedColorState = 0
var brushWidth: CGFloat = 5.0
var selectedBrushWidthState = 0
var opacity: CGFloat = 1.0
var swiped = false
var drawerIsOpen = true
var drawerXLocation:CGFloat = 0
var drawerYLocation:CGFloat = 0
var drawerHeight:CGFloat = 0
var drawerWidth:CGFloat = 0

class DrawVC: UIViewController {
    @IBOutlet var closeBtn: UIButton!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var tempImageView: UIImageView!
    @IBOutlet var drawerView: UIView!
    @IBOutlet var colourPick0Btn: UIButton!
    @IBOutlet var colourPick1Btn: UIButton!
    @IBOutlet var colourPick2Btn: UIButton!
    @IBOutlet var colourPick3Btn: UIButton!
    @IBOutlet var colourPick4Btn: UIButton!
    @IBOutlet var colourPick5Btn: UIButton!
    @IBOutlet var colourPick6Btn: UIButton!
    @IBOutlet var colourPick7Btn: UIButton!
    
    @IBOutlet weak var drawerTopConstraint: NSLayoutConstraint!
    @IBOutlet var tipSize0Btn: UIButton!
    @IBOutlet var tipSize1Btn: UIButton!
    
    @IBOutlet var drawerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func drawButtonPressed(sender: UIButton!){
        
        if drawerIsOpen == true {
            drawerIsOpen = false
            self.drawerBtn.isHidden = true
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
                self.drawerTopConstraint.constant = -51
                
                self.view.layoutIfNeeded()
            }) { _ in
                self.drawerBtn.isHidden = false
                print ("Finished Animation 1")
            }
        }
        else {
            drawerIsOpen = true
            self.drawerBtn.isHidden = true
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseIn, animations: {
                
                self.drawerTopConstraint.constant = 0
                self.view.layoutIfNeeded()
            }) { _ in
                self.drawerBtn.isHidden = false
                print ("Finished Animation 2")
            }
            
        }
        updateDrawerButton()
    }
    
    func updateDrawerButton() {
        if drawerIsOpen == true {
            let collapseImg = UIImage(named: "CollapseDrawerNight") as UIImage?
            let collapsePressedImg = UIImage(named: "CollapseDrawerPressedNight") as UIImage?
            drawerBtn?.setImage(collapseImg, for: .normal)
            drawerBtn?.setImage(collapsePressedImg, for: .highlighted)
            drawerBtn!.layer.shadowColor = UIColor.black.cgColor
            drawerBtn!.layer.shadowOpacity = shadowOpacityButtons
            drawerBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
            drawerBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
         }
        else {
            let expandImg = UIImage(named: "ExpandDrawerNight") as UIImage?
            let expandPressedImg = UIImage(named: "ExpandDrawerPressedNight") as UIImage?
            drawerBtn?.setImage(expandImg, for: .normal)
            drawerBtn?.setImage(expandPressedImg, for: .highlighted)
            drawerBtn!.layer.shadowColor = UIColor.black.cgColor
            drawerBtn!.layer.shadowOpacity = shadowOpacityButtons
            drawerBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
            drawerBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
         }
    }
        
        @IBAction func drawAttributeBtnPressed(sender: UIButton!){
        switch (sender.tag){
        case 0:
            color = UIColor( red: CGFloat(208.0/255.0), green: CGFloat(2.0/255.0), blue: CGFloat(27.0/255.0), alpha: CGFloat(1.0))
            selectedColorState = 0
        case 1:
            color = UIColor( red: CGFloat(74.0/255.0), green: CGFloat(144.0/255.0), blue: CGFloat(226.0/255.0), alpha: CGFloat(1.0))
            selectedColorState = 1
        case 2:
            color = UIColor( red: CGFloat(76.0/255.0), green: CGFloat(217.0/255.0), blue: CGFloat(100.0/255.0), alpha: CGFloat(1.0))
            selectedColorState = 2
        case 3:
            color = UIColor( red: CGFloat(2489.0/255.0), green: CGFloat(231.0/255.0), blue: CGFloat(28.0/255.0), alpha: CGFloat(1.0))
            selectedColorState = 3
        case 4:
            color = UIColor( red: CGFloat(245.0/255.0), green: CGFloat(166.0/255.0), blue: CGFloat(35.0/255.0), alpha: CGFloat(1.0))
            selectedColorState = 4
        case 5:
            color = UIColor( red: CGFloat(173.0/255.0), green: CGFloat(51.0/255.0), blue: CGFloat(195.0/255.0), alpha: CGFloat(1.0))
            selectedColorState = 5
        case 6:
            color = UIColor.white
            selectedColorState = 6
        case 7:
            color = UIColor( red: CGFloat(0.0/255.0), green: CGFloat(0.0/255.0), blue: CGFloat(0.0/255.0), alpha: CGFloat(1.0))
            selectedColorState = 7
        case 8:
            brushWidth = 5.0
            selectedBrushWidthState  = 0
        case 9:
            brushWidth = 10.0
            selectedBrushWidthState  = 1
        default:
            print ("Error: Color Attribute switch fell through")
        }
        updateScreen()
    }
    
    
    
    @IBAction func deletePressed() {
    mainImageView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      guard let touch = touches.first else {
        return
      }
      swiped = false
      lastPoint = touch.location(in: view)
      screenSaverCounter = 0 //reset the timer when user is drawing.
    }

    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
      UIGraphicsBeginImageContext(view.frame.size)
      guard let context = UIGraphicsGetCurrentContext() else {
        return
      }
      tempImageView.image?.draw(in: view.bounds)
        
      // 2
      context.move(to: fromPoint)
      context.addLine(to: toPoint)
      
      // 3
      context.setLineCap(.round)
      context.setBlendMode(.normal)
      context.setLineWidth(brushWidth)
      context.setStrokeColor(color.cgColor)
      
      // 4
      context.strokePath()
      
      // 5
      tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
      tempImageView.alpha = opacity
      UIGraphicsEndImageContext()
      screenSaverCounter = 0 //reset the timer when user is drawing.
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      if !swiped {
        // draw a single point
        drawLine(from: lastPoint, to: lastPoint)
      }
        
      // Merge tempImageView into mainImageView
      UIGraphicsBeginImageContext(mainImageView.frame.size)
      mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
      tempImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
      mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
        
      tempImageView.image = nil
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      guard let touch = touches.first else {
        return
      }

      // 6
      swiped = true
      let currentPoint = touch.location(in: view)
      drawLine(from: lastPoint, to: currentPoint)
        
      // 7
      lastPoint = currentPoint
      screenSaverCounter = 0 //reset the timer when user is drawing
    }
    
    @IBAction func CloseSettings(_ sender: Any) {
        print ("Close the Settings View")
        screenSaverCounter = 0 //reset the timer when user is exitting.
        screenSaverAllowed = true //allow to show the screen saver again once you are out off the settings screen
        //BEGIN - Go back to your Root View Controller
        self.dismiss(animated: true, completion: nil)
    
    }

    //BEGIN - This removes the home button bar on higher iPad devices
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    //END
    
    override func viewWillAppear(_ animated: Bool){
        print ("DRAW View will appear, Main Loop - Screen saver NOT allowed")
        screenSaverAllowed = true
        screenSaverCounter = 0 //reset the slide show counter, else it might start straight away after you return from a viewcontroller
        //BEGIN - Load previous user drawn image
        mainImageView.image = userDrawingImg
        //END
        print ("Drawer View will appear")
        //BEGIN - send me a notification when the Alarm is going OFF
        NotificationCenter.default.addObserver(self, selector: #selector(self.ReceivedNotification(notification:)), name: Notification.Name("AlarmNotification"), object: nil)
        //END
        NotificationCenter.default.addObserver(self, selector: #selector(self.screensaverRequested), name: Notification.Name("ScreensaverNotification"), object: nil)
        
        updateScreen()
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
        print ("Store Image")
        //BEGIN - Remove all notifications
        NotificationCenter.default.removeObserver(self)
        //END
        
        //BEGIN - Store user drawn notice board image, so if user come back here it is still there else it gets cleared by viewcontroller
        userDrawingImg = mainImageView.image
        //END
    }

    
    func updateScreen() {
        tempImageView.backgroundColor = .clear
        updateDrawerButton()
        let closeImg = UIImage(named: "CloseBtnNight") as UIImage?
        let closePressedImg = UIImage(named: "ClosePressedBtnNight") as UIImage?
        closeBtn?.setImage(closeImg, for: .normal)
        closeBtn?.setImage(closePressedImg, for: .highlighted)
        closeBtn!.layer.shadowColor = UIColor.black.cgColor
        closeBtn!.layer.shadowOpacity = shadowOpacityButtons
        closeBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        closeBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    
        let deleteImg = UIImage(named: "ClearBtnNight") as UIImage?
        let deletePressedImg = UIImage(named: "ClearBtnPressedNight") as UIImage?
        deleteBtn?.setImage(deleteImg, for: .normal)
        deleteBtn?.setImage(deletePressedImg, for: .highlighted)
        deleteBtn!.layer.shadowColor = UIColor.black.cgColor
        deleteBtn!.layer.shadowOpacity = shadowOpacityButtons
        deleteBtn!.layer.shadowOffset = CGSize(width: shadowOffsetWidthButtons, height: shadowOffsetHeightButtons)
        deleteBtn!.layer.shadowRadius = CGFloat(shadowRadiusButtons)
    
        let colourPick0Image = UIImage(named: "ColorPick0Night") as UIImage?
        let colourPick1Image = UIImage(named: "ColorPick1Night") as UIImage?
        let colourPick2Image = UIImage(named: "ColorPick2Night") as UIImage?
        let colourPick3Image = UIImage(named: "ColorPick3Night") as UIImage?
        let colourPick4Image = UIImage(named: "ColorPick4Night") as UIImage?
        let colourPick5Image = UIImage(named: "ColorPick5Night") as UIImage?
        let colourPick6Image = UIImage(named: "ColorPick6Night") as UIImage?
        let colourPick7Image = UIImage(named: "ColorPick7Night") as UIImage?
        let brushWidth0Image = UIImage(named: "BrushWidth0Night") as UIImage?
        let brushWidth1Image = UIImage(named: "BrushWidth1Night") as UIImage?
        
        
        let colourPick0SelectedImage = UIImage(named: "ColorPick0NightSelected") as UIImage?
        let colourPick1SelectedImage = UIImage(named: "ColorPick1NightSelected") as UIImage?
        let colourPick2SelectedImage = UIImage(named: "ColorPick2NightSelected") as UIImage?
        let colourPick3SelectedImage = UIImage(named: "ColorPick3NightSelected") as UIImage?
        let colourPick4SelectedImage = UIImage(named: "ColorPick4NightSelected") as UIImage?
        let colourPick5SelectedImage = UIImage(named: "ColorPick5NightSelected") as UIImage?
        let colourPick6SelectedImage = UIImage(named: "ColorPick6NightSelected") as UIImage?
        let colourPick7SelectedImage = UIImage(named: "ColorPick7NightSelected") as UIImage?
        let brushWidth0SelectedImage = UIImage(named: "BrushWidth0NightSelected") as UIImage?
        let brushWidth1SelectedImage = UIImage(named: "BrushWidth1NightSelected") as UIImage?
        
        
        colourPick0Btn?.setImage(colourPick0Image, for: .normal)
        colourPick1Btn?.setImage(colourPick1Image, for: .normal)
        colourPick2Btn?.setImage(colourPick2Image, for: .normal)
        colourPick3Btn?.setImage(colourPick3Image, for: .normal)
        colourPick4Btn?.setImage(colourPick4Image, for: .normal)
        colourPick5Btn?.setImage(colourPick5Image, for: .normal)
        colourPick6Btn?.setImage(colourPick6Image, for: .normal)
        colourPick7Btn?.setImage(colourPick7Image, for: .normal)
    
        tipSize0Btn?.setImage(brushWidth0Image, for: .normal)
        tipSize1Btn?.setImage(brushWidth1Image, for: .normal)
        
        switch (selectedBrushWidthState){
        case 0:
            brushWidth = 5.0
            tipSize0Btn?.setImage(brushWidth0SelectedImage, for: .normal)
        case 1:
            brushWidth = 10.0
            tipSize1Btn?.setImage(brushWidth1SelectedImage, for: .normal)
        
        default:
            print ("Error: wrong brush width selected")
        }
        
        
        switch (selectedColorState){
        case 0:
            colourPick0Btn?.setImage(colourPick0SelectedImage, for: .normal)
        case 1:
            colourPick1Btn?.setImage(colourPick1SelectedImage, for: .normal)
        case 2:
            colourPick2Btn?.setImage(colourPick2SelectedImage, for: .normal)
        case 3:
            colourPick3Btn?.setImage(colourPick3SelectedImage, for: .normal)
        case 4:
            colourPick4Btn?.setImage(colourPick4SelectedImage, for: .normal)
        case 5:
            colourPick5Btn?.setImage(colourPick5SelectedImage, for: .normal)
        case 6:
            colourPick6Btn?.setImage(colourPick6SelectedImage, for: .normal)
        case 7:
            //BEGIN - Eraser has been selected so give user a bigger brush to erase text, else the selected brush will be used
            brushWidth = 40.0
            colourPick7Btn?.setImage(colourPick7SelectedImage, for: .normal)
        default:
            print ("Error: wrong colour selected")
        }
    }

    //BEGIN - The Alarm went off
    @objc func ReceivedNotification(notification: Notification){
        print ("TimerExpiredSegue")
        performSegue(withIdentifier: "TimerExpiredSegue", sender: nil)
    }
    //END


}
