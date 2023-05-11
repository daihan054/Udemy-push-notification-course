//
//  ViewController.swift
//  Udemy-push-notification-course
//
//  Created by REVE Systems on 11/5/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNService.shared.authorize()
    }

    @IBAction func timerTapped(_ sender: Any) {
        print("timer")
        AlertService.actionSheet(in: self, title: "5 seconds") {
            UNService.shared.timerRequest(with: 5)
        }
    }
    
    @IBAction func dateTapped(_ sender: Any) {
        print("date")
        
        AlertService.actionSheet(in: self, title: "Some future time") {
            var components = DateComponents()
            components.second = 0
            UNService.shared.dateRequest(with: components)
        }
        
    }
    
    @IBAction func onLocationTapped(_ sender: Any) {
        print("location")
        
        AlertService.actionSheet(in: self, title: "When i return") {
            
        }
    }
    
}

