//
//  ViewController.swift
//  rebuyRateImg
//
//  Created by Felicitas Figueroa Fagalde on 21.10.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var objTitle: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var imgView: UIImageView!
    
    var products : [Product] = []
    var progress : Float = 0.0
    var rateCounter : Int = 0
    
    //onboarding
    @IBOutlet weak var onboardingContainer: UIView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBAction func skipOnboarding(_ sender: UIButton) {
        sender.removeFromSuperview()
        onboardingContainer.removeFromSuperview()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView(){
        progressBar.progress = progress
        Task {
            do { try await downloadData()
                  fillData() }
            catch { print(error)}
        }
    }
    
    func downloadData() async throws{
        let response = try? await ProductRoute.searchWith(filters: [.limit(100)])
        guard let response = response else {
            throw NetworkManagerError.downloadingError
        }
        let prods = response.products
        for prod in prods {
            products.append(prod)
        }
    }

}



//MARK: Progress bar and Rate buttons

extension ViewController {
    
    @IBAction func rateBtn(_ sender: Any) {
        updateBar()
        fillData()
        if progress >= 1.0 {
            alert(title: "Here's your ticket", message: "A28KN29SJ2HHKSKM ")
            updateBar()
        }
    }
   
    @IBAction func skipBtn(_ sender: Any) {
      fillData()
    }

    func updateBar(){
        if rateCounter < 30 {
            progress += 0.033333333333333333
            rateCounter += 1
        } else {
            progress = 0.0
            rateCounter = 0
        }
        progressBar.progress = progress
        counterLabel.text = String("\(rateCounter) / 30")
    }
    
    func fillData(){
        if let index = products.indices.randomElement() {
            imgView.loadFrom(URLAddress: products[index].images[0])
            self.objTitle.text = products[index].title
            products.remove(at: index)
        }
    }
    

}

// MARK: DownloadImage
extension UIImageView {
    
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {return}
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage}
            }
        }
    }
    
}
