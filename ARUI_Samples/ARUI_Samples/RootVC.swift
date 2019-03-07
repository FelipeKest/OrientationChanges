//
//  RootVC.swift
//  ARUI_Samples
//
//  Created by Felipe Kestelman on 19/02/19.
//  Copyright © 2019 Felipe Kestelman. All rights reserved.
//

import UIKit

class RootVC: UIViewController, UINavigationControllerDelegate, DeviceOrientationHandler {
    
    
    var orientationHandler = DeviceOrientationHelper.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orientationHandler.startDeviceOrientationNotifier(to: self)

        guard let reload = UIImage(named: "backArrow") else {return}
        let reloadSize = CGRect(origin: .zero, size: CGSize(width: 44, height: 44))
        let reloadButton = UIButton(frame: reloadSize)
        reloadButton.setBackgroundImage(reload, for: .normal)
        let customView = UIView(frame: reloadSize)
        customView.backgroundColor = .red
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.customView = customView
        
        
        self.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(customView: customView)
        let a3 = UIBarButtonItem(customView: customView)
        let buttonItem = UIBarButtonItem(customView: reloadButton)
        let btnArray = [a3,buttonItem]
        
        self.navigationItem.rightBarButtonItems = btnArray
        

//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
//        view.backgroundColor = .red
//        customView.backgroundColor = .red
//        otherBarItem.customView = customView
//
//
        
//        barItem.customView = customView
//        otherBarItem.customView = customView
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.title = "Experience"
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func navigate() {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "teste")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func push(_ sender: Any) {
//        if let rightItems = self.navigationItem.rightBarButtonItems {
//            print("rodou")
//            for item in rightItems {
//                UIView.animate(withDuration: 0.5, animations: {
//                    item.customView?.transform = CGAffineTransform(rotationAngle: .pi/2)
//                })
//            }
//        }
        navigate()
//        guard let reload = UIImage(named: "reloadButton") else {return}
//        let reloadSize = CGRect(origin: .zero, size: CGSize(width: 44, height: 44))
//        let reloadButton = UIButton(frame: reloadSize)
//        reloadButton.setBackgroundImage(reload, for: .normal)
//        let customView = UIView(frame: reloadSize)
//        customView.backgroundColor = .blue
//
//        let otherItem = UIBarButtonItem(customView: customView)
//        self.navigationItem.rightBarButtonItems?.append(otherItem)
    }
    
    private func makeNavigationTransparent(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func orientationChanged(deviceOrientation: UIDeviceOrientation) {
        if let rightItems = self.navigationItem.rightBarButtonItems {
            for item in rightItems {
                DispatchQueue.main.async {
                    item.customView?.rotateConforming(deviceOrientation)
                }
            }
        }
    }
    
    
}
