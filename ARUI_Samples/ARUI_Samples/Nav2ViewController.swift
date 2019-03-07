//
//  Nav2ViewController.swift
//  ARUI_Samples
//
//  Created by Felipe Kestelman on 28/02/19.
//  Copyright © 2019 Felipe Kestelman. All rights reserved.
//

import UIKit

class Nav2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        guard let backArrow = UIImage(named: "CloseNavBarItem") else {
            print("no image")
            return
        }
        
        
        
        
        
        
        
        let b = UIImageView(frame: CGRect(x: 30, y: 100, width: 100, height: 100))
        
        b.image = backArrow
        
        self.view.addSubview(b)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.backIndicatorImage = backArrow
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backArrow
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setNavigationImage(){
        
    }
    
}
