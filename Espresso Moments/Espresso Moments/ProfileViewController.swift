//
//  ProfileViewController.swift
//  Espresso Moments
//
//  Created by WiLL on 8/2/15.
//  Copyright (c) 2015 Harvard. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            // user is logged in
            println("User's ID is \(accessToken.userID)")
            println("permissions: \(accessToken.permissions)")
            getFBUserData()
        } else {
            // user is not logged in
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
            }
        })
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
