//
//  ProfileViewController.swift
//  Tindle
//
//  Created by Taylor McLaughlin on 10/30/18.
//  Copyright © 2018 Taylor McLaughlin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var topBarImageView: UIImageView!
    var passedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topBarImageView.isUserInteractionEnabled = true
        profileImageView.image = passedImage
    }
    
    @IBAction func didPressDone(_ sender: Any) {
        self.performSegue(withIdentifier: "ReturnSegue", sender: nil)
    }
    
}
