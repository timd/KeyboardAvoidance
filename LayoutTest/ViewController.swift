//
//  ViewController.swift
//  LayoutTest
//
//  Created by Tim Duckett on 24.08.17.
//  Copyright © 2017 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlet for the constraint between the bottom of the container view
    // and the bottom of the safe area
    @IBOutlet weak var backgroundContainerViewBottomLayoutConstraint: NSLayoutConstraint!
    
    // Outlet for the constraint between the top of the container view
    // and the top of the safe area
    @IBOutlet weak var backgroundContainerViewTopLayoutConstraint: NSLayoutConstraint!
    
    // property to hold the default value for the constraint between the
    // bottom of the background view and the bottom of the safe area
    var backgroundContainerViewBottomConstant: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register this class for keyboard notifications
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Grab default spacing between background container and the safe area
        // when the view first appears
        backgroundContainerViewBottomConstant = backgroundContainerViewBottomLayoutConstraint.constant
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Will be fired just before the keyboard appears
    @objc func keyboardWillShow(notification: Notification) {
        
        // If there's no userInfo in the notification,
        // can't do anything so just return
        guard let userInfo = notification.userInfo else {
            return
        }

        // If there's no keyboardRect in the notification,
        // can't do anything so just return
        guard let keyboardRect = userInfo["UIKeyboardBoundsUserInfoKey"] as? CGRect else {
            return
        }
        
        // Adjust the background container's spacing to the
        // bottom of the safe area by the height of the keyboard
        backgroundContainerViewBottomLayoutConstraint.constant = backgroundContainerViewBottomConstant - keyboardRect.height
        
        // Adjust the background container's spacing to the
        // top of the safe area by the height of the keyboard
        backgroundContainerViewTopLayoutConstraint.constant = backgroundContainerViewTopLayoutConstraint.constant - keyboardRect.height

    }
   
    // Will be fired just before the keyboard is hidden
    @objc func keyboardWillHide(notification: Notification) {
        
        // Adjust the background container's spacing to the
        // top and bottom of the safe area back to the original values
        backgroundContainerViewBottomLayoutConstraint.constant = backgroundContainerViewBottomConstant
        backgroundContainerViewTopLayoutConstraint.constant = 0
        
    }
}

