    //
//  ProfileViewController.swift
//  Espresso Moments
//
//  Created by WiLL on 8/2/15.
//  Copyright (c) 2015 Harvard. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fbLoginView: FBSDKLoginButton!{
        didSet {
            fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        }
    }
    @IBOutlet weak var fbProfileView: FBSDKProfilePictureView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult: true, error: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            // user is logged in
            let accessHash = FBSDKAccessToken.currentAccessToken()
            println("\(accessHash)")
            println("User's ID is \(accessToken.userID)")
            println("permissions: \(accessToken.permissions)")
            
            //unhide UI elements
            profileImageView.hidden = false
            nameLabel.hidden = false
            
            //obtain user data
            getFBUserData()
        } else {
            // user is not logged in
            //println("not logged in")
            
            //hide UI elements - default is hidden
            profileImageView.hidden = true
            nameLabel.hidden = true
            
            self.loginButtonDidLogOut(fbLoginView)
            
        }
    }
    
    func getFBUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me?fields=id,email,name,friends", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil) {
                // Process error
                println("Error: \(error)")
            } else {
                println("fetched result: \(result)")
                
                //imageURL
                let userImageURL = "https://graph.facebook.com/\(FBSDKAccessToken.currentAccessToken().userID)/picture?type=small"
                let url = NSURL(string: userImageURL)
                let imageData = NSData(contentsOfURL: url!)
                let image = UIImage(data: imageData!)
                self.profileImageView.image = image!
                
                //Populate Label with user name
                //self.nameLabel.text = "Welcome William"
                
                //let facebookName = FBSDKProfile().firstName!
                
                self.nameLabel.text = "Welcome \(FBSDKProfile().firstName)"
                

            }
        })
    }
    
    //implement FB Delegate method
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
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
