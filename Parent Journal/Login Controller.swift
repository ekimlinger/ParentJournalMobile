//
//  Login Controller.swift
//  Parent Journal
//
//  Created by Evan Kimlinger on 5/4/16.
//  Copyright © 2016 Parent Journal. All rights reserved.
//

import UIKit

class Login_Controller: UIViewController {

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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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

}
