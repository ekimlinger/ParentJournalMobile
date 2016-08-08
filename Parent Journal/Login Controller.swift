//
//  Login Controller.swift
//  Parent Journal
//
//  Created by Evan Kimlinger on 5/4/16.
//  Copyright © 2016 Parent Journal. All rights reserved.
//

import UIKit
import Alamofire

class Login_Controller: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dismisses Keyboard
        func dismissKeyboard(){
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
        }
        //Dismisses Keyboard when return is hit
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true
            
        }
        
        
        //Dismisses Keyboad when tapped outside of keyboard
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var ImageView: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //
    // My functions
    //
    
    @IBAction func sendLogin(sender: AnyObject) {
        
        let parameters = [
            "username": email.text!,
            "password": password.text!
        ]

        
        Alamofire.request(.POST, "https://parentjournal.herokuapp.com/mobile/login", parameters: parameters, encoding: .JSON)
            .responseJSON{ (response) -> Void in
                
            if response.response?.statusCode == 200{
                //Save userdata
                let JSON = response.result.value
                
                var userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
                userDefaults.setValue(JSON as! NSDictionary, forKey: "userInfo")
                self.performSegueWithIdentifier("successfulLogin", sender: nil)
            } else {
                let title : String
                let message : String
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 401:
                        title = "Whoops!"
                        message = "Wrong email or password, please try again."
                        break
                    default:
                        title = "Oh no!"
                        message = "Something went wrong, please try again."
                        break
                    }
                } else {
                    title = ""
                    message = "Something went wrong please try again"
                }
                // display alert with error message
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }
        // End login attempt
    }
    
    

}
