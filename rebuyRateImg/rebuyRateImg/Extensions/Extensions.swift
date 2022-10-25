//
//  Extensions.swift
//  rebuyRateImg
//
//  Created by Felicitas Figueroa Fagalde on 25.10.22.
//

import UIKit

// MARK: Alert
extension ViewController {
    func alert(title: String, message: String){
         let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
          })
         dialogMessage.addAction(ok)
         self.present(dialogMessage, animated: true, completion: nil)

    }
    
}

