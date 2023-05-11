//
//  AlertService.swift
//  Udemy-push-notification-course
//
//  Created by REVE Systems on 11/5/23.
//

import UIKit

class AlertService {
    
    private init() { }
    
    static func actionSheet(in vc: UIViewController, title: String, completion: @escaping ()->Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { _ in
            completion()
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
