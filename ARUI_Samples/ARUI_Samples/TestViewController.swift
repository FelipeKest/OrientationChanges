//
//  TestViewController.swift
//  ARUI_Samples
//
//  Created by Felipe Kestelman on 11/02/19.
//  Copyright © 2019 Felipe Kestelman. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, DeviceOrientationHandler {
    
    var topViewBar: UITopViewBar?
    var orientationHandler = DeviceOrientationHelper.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orientationHandler.startDeviceOrientationNotifier(to: self)

        print(UIScreen.main.bounds.width)
        
        var buttons:[UIButton] = []
        let button = UIButton()
        let anotherButton = UIButton()
        let other = UIButton()
        other.backgroundColor = .green
        button.backgroundColor = .black
        anotherButton.backgroundColor = .white
//        buttons.append(anotherButton)
//        buttons.append(other)
        buttons.append(button)
        
        topViewBar = UITopViewBar(buttons: buttons, on: self.view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        orientationHandler.stopDeviceOrientationNotifier()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    func orientationChanged(deviceOrientation: UIDeviceOrientation){
        DispatchQueue.main.async {

            guard let barSubviews = self.topViewBar?.addedButtonsStackView.subviews else {return}
            for view in barSubviews {
                view.rotateConforming(deviceOrientation)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIView {
    func rotateConforming(_ deviceOrientation: UIDeviceOrientation) {
        let rotation = deviceOrientation.angle
        let transform = CGAffineTransform(rotationAngle: rotation)
            UIView.animate(withDuration: 0.3) {
                self.transform = transform
        }
    }
}
