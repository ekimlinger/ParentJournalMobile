//
//  RegisterViewController.swift
//  Parent Journal
//
//  Created by Evan Kimlinger on 8/7/16.
//  Copyright © 2016 Parent Journal. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func createAccountPressed(sender: AnyObject) {
        
        let parameters = [
            "username": username.text!,
            "password": password.text!,
            "firstname": firstname.text!,
            "lastname": lastname.text!
        ]
        
        print("Attempting login. User: ", parameters)
        
        Alamofire.request(.POST, "https://parentjournal.herokuapp.com/mobile/register", parameters: parameters, encoding: .JSON)
            .responseJSON{ (response) -> Void in
                if response.response?.statusCode == 200 {

                    let alertController = UIAlertController(title: "Account created", message:
                        "Thanks for registering, please login!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: { (UIAlertAction) -> Void in
                        // Continue to home page
                        self.performSegueWithIdentifier("backToLogin", sender: nil)
                    }))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                } else {
                    let message : String
                    if let httpStatusCode = response.response?.statusCode {
                        switch(httpStatusCode) {
                        case 401:
                            message = "Email has been taken, please try again!"
                            break
                        default:
                            message = "Temporarily unavailable, please try again!"
                            break
                        }
                    } else {
                        message = "Something went wrong please try again"
                    }
                    // display alert with error message
                    let alertController = UIAlertController(title: "Whoops", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
        }
        // End register attempt
    }
    

}


