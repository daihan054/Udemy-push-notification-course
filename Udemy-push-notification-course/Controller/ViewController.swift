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
        CLService.shared.authorize()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterRegion),
                                               name:NSNotification.Name("internalNotification.enteredRegion"), object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleAction(_:)),
                                               name:NSNotification.Name("internalNotification.handleAction"), object: nil)
        
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
        view.backgroundColor = .yellow
        AlertService.actionSheet(in: self, title: "When i return") {
            CLService.shared.updateLocation()
        }
    }
    
    
    @objc func didEnterRegion() {
        UNService.shared.locationRequest()
    }
    
    @objc func handleAction(_ sender: Notification) {
        guard let action = sender.object as? NotificationActionID else { return }
        
        switch action {
        case .timer:
            print("timer logic")
        case .date:
            print("date logic")
        case .location:
            changeBackground()
        }
    }
    
    func changeBackground() {
        view.backgroundColor = .red
    }
}

