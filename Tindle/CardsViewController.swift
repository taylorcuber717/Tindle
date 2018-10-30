//
//  ViewController.swift
//  Tindle
//
//  Created by Taylor McLaughlin on 10/29/18.
//  Copyright © 2018 Taylor McLaughlin. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var infoImageView: UIImageView!
    var cardInitialCenter: CGPoint!
    var whereStarted: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundTheImage()
        cardInitialCenter = cardImage.center
        cardImage.isUserInteractionEnabled = true
        infoImageView.isUserInteractionEnabled = true
    }
    
    func roundTheImage() {
        cardImage.layer.cornerRadius = 50
        cardImage.clipsToBounds = true
    }
    
    @IBAction func onTapCard(_ sender: Any) {
        cardImage.transform = CGAffineTransform.identity
        cardImage.isHidden = false
    }
    @IBAction func didPanCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if sender.state == .began {
            whereStarted = sender.location(in: cardImage).y
        } else if sender.state == .changed {
            if whereStarted > 200 {
                if translation.x < 0 {
                    let translationAmount = max(-180, translation.x)
                    let rotationAmount = min(45, -Double(translation.x)/4) * Double.pi / 180
                    cardImage.transform = CGAffineTransform(translationX: translationAmount, y: 0)
                    cardImage.transform = cardImage.transform.rotated(by: CGFloat(rotationAmount))
                } else {
                    let translationAmount = min(180, translation.x)
                    let rotationAmount = max(-45, -Double(translation.x)/4) * Double.pi / 180
                    cardImage.transform = CGAffineTransform(translationX: translationAmount, y: 0)
                    cardImage.transform = cardImage.transform.rotated(by: CGFloat(rotationAmount))
                }
            } else {
                if translation.x < 0 {
                    let translationAmount = max(-180, translation.x)
                    let rotationAmount = max(-45, Double(translation.x)/4) * Double.pi / 180
                    cardImage.transform = CGAffineTransform(translationX: translationAmount, y: 0)
                    cardImage.transform = cardImage.transform.rotated(by: CGFloat(rotationAmount))
                } else {
                    let translationAmount = min(180, translation.x)
                    let rotationAmount = min(45, Double(translation.x)/4) * Double.pi / 180
                    cardImage.transform = CGAffineTransform(translationX: translationAmount, y: 0)
                    cardImage.transform = cardImage.transform.rotated(by: CGFloat(rotationAmount))
                }
            }
        } else if sender.state == .ended {
            pushOffScreen(translationCurrent: Int(translation.x))
        }
    }
    
    func pushOffScreen(translationCurrent: Int!) {
        if translationCurrent > 0 {
            if translationCurrent > 50 {
                UIView.animate(withDuration: 1) {
                    self.cardImage.center.x += 100
                }
            } else {
                UIView.animate(withDuration: 1) {
                    self.cardImage.transform = CGAffineTransform.identity
                }
            }
        } else {
            if translationCurrent < -50 {
                UIView.animate(withDuration: 1) {
                    self.cardImage.center.x -= 100
                    self.cardImage.isHidden = true
                }
            } else {
                UIView.animate(withDuration: 1) {
                    self.cardImage.transform = CGAffineTransform.identity
                }
            }
        }
    }
    
    @IBAction func onTapProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "ProfileSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profileViewController = segue.destination as! ProfileViewController
        profileViewController.profileImageView.image = cardImage.image
    }
    
}

