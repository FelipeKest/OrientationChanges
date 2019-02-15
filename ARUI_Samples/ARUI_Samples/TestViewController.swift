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

        var buttons:[UIButton] = []
        let button = UIButton()
        let anotherButton = UIButton()
        let other = UIButton()
        other.backgroundColor = .green
        button.backgroundColor = .black
        anotherButton.backgroundColor = .white
//        button.addTarget(self, action: #selector(rotateAction), for: .touchDown)
//        anotherButton.addTarget(self,action: #selector(rotateAction), for: .touchDown)
//        buttons.append(other)
//        buttons.append(button)
        buttons.append(anotherButton)
//
        topViewBar = UITopViewBar(buttons: buttons, on: self.view, orientation: .vertical)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        orientationChanged(deviceOrientation: UIDevice.current.orientation)
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
