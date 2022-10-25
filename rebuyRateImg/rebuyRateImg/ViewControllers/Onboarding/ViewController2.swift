//
//  ViewController.swift
//  rebuyRateImg
//
//Created by Felicitas Figueroa Fagalde on 25.10.22.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var onboardingContainer: UIView!
    @IBOutlet weak var skipBtn: UIButton!
    
    
    @IBAction func skipOnboarding(_ sender: UIButton) {
        sender.removeFromSuperview()
        onboardingContainer.removeFromSuperview()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
