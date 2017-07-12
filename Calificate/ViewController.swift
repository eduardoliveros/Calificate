//
//  ViewController.swift
//  Calificate
//
//  Created by Eduardo Oliveros on 11/01/17.
//  Copyright © 2017 CEO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if (defaults.value(forKey: "rated") as! Int) == 3 {
            showRateMessage()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showRateMessage(){
    
        let alert = UIAlertController(title: "You like the App??", message: "Please leave a comment in the App Store", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "I like It!", style: .default) { (action) in
            self.rateApp(withId: "id1054417526", completion: { (success) in
                let defaults = UserDefaults.standard
                defaults.set(16, forKey: "rated")
                print("rated")
            })
        }
        
        let noAction = UIAlertAction(title: "No Thanks", style: .cancel) { (action) in
            let defaults = UserDefaults.standard
            defaults.set(0, forKey: "rated")
        }
        alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func rateApp(withId id:String, completion: @escaping ((_ success: Bool)->())){
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + id) else{
            completion(false)
            return
        }
        
        guard #available(iOS 10, *) else{
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    
    }


}

