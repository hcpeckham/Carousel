//
//  LoginViewController.swift
//  Carousel
//
//  Created by Hannah Peckham on 2/12/16.
//  Copyright © 2016 Hannah Peckham. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonParentView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInIndicator: UIActivityIndicatorView!
    
    
    var buttonInitialY: CGFloat!
    var buttonOffset: CGFloat!

    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        scrollView.delegate = self
        
        scrollView.contentSize = scrollView.frame.size
        scrollView.contentInset.bottom = 100
        
        buttonInitialY = buttonParentView.frame.origin.y
        buttonOffset = -120
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        
        // add the cancel action to the AlertControllers
        
       

    }
    
    
    
    // The keyboard is about to be shown...
    func keyboardWillShow(notification: NSNotification) {
        // Move the button up above keyboard
        buttonParentView.frame.origin.y = buttonInitialY + buttonOffset
        // Scroll the scrollview up
        scrollView.contentOffset.y = scrollView.contentInset.bottom
    }
    
    
    
    
    // The scrollView is in the proccess of scrolling...
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // If the scrollView has been scrolled down by 50px or more...
        if scrollView.contentOffset.y <= -50 {
            // Hide the keyboard
            view.endEditing(true)
        }
    }
    
    
    // The keyboard is about to be hidden...
    func keyboardWillHide(notification: NSNotification) {
        // Move the buttons back down to it's original position
        buttonParentView.frame.origin.y = buttonInitialY
    }

    

    
    
    @IBAction func onBackTap(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    
    
    @IBAction func didPressLoginButton(sender: AnyObject) {
        self.signInIndicator.startAnimating()
               
        
        delay(2) { () -> () in
            self.signInIndicator.stopAnimating()
            
            if self.emailField.text!.isEmpty || self.passwordField.text!.isEmpty {
                let alertEmptyController = UIAlertController(title: "Enter email or password", message: "Please enter a valid email and password", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                })
                alertEmptyController.addAction(OKAction)
                self.presentViewController(alertEmptyController, animated: true, completion: { (action) -> Void in
                })

                
            } else if self.emailField.text == "hp" && self.passwordField.text == "pw" {
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            } else {
                let alertController = UIAlertController(title: "Invalid email or password", message: "Please enter a valid email and password", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                })
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: { (action) -> Void in
                })
            }
        }

        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
