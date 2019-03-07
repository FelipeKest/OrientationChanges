//
//  OrientationHelper.swift
//  ARUI_Samples
//
//  Created by Felipe Kestelman on 14/02/19.
//  Copyright © 2019 Felipe Kestelman. All rights reserved.
//

import UIKit
import CoreMotion

protocol DeviceOrientationHandler {
    func orientationChanged(deviceOrientation: UIDeviceOrientation)
}


class DeviceOrientationHelper {
    static let shared = DeviceOrientationHelper() // Singleton is recommended because an app should create only a single instance of the CMMotionManager class.

    private var eventReceiver: DeviceOrientationHandler?
    private let motionManager: CMMotionManager
    private let queue: OperationQueue

    public var currentDeviceOrientation: UIDeviceOrientation = .unknown

    private init() {
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.2 // Specify an update interval in seconds, personally found this value provides a good UX

        queue = OperationQueue()
    }

    public func startDeviceOrientationNotifier(to eventReceiver: DeviceOrientationHandler) {
        self.eventReceiver = eventReceiver
        //  Using main queue is not recommended. So create new operation queue and pass it to startAccelerometerUpdatesToQueue.
        //  Dispatch U/I code to main thread using dispach_async in the handler.

        motionManager.startAccelerometerUpdates(to: queue) { (data, error) in
            if let accelerometerData = data {
                
                let orientationCase = (x:Int(round(accelerometerData.acceleration.x)), y: Int(round(accelerometerData.acceleration.y)))
                
                var newDeviceOrientation: UIDeviceOrientation = .unknown

                switch orientationCase {
                case (x:0, y:-1):
                    newDeviceOrientation = .portrait
                case (x:1, y:0):
                    newDeviceOrientation = .landscapeRight
                case (x:-1, y:0):
                    newDeviceOrientation = .landscapeLeft
                case (x:0, y:1):
                    newDeviceOrientation = .portraitUpsideDown
                default:
                    return
                }
                
                
                if newDeviceOrientation != self.currentDeviceOrientation {
                    self.eventReceiver?.orientationChanged(deviceOrientation: newDeviceOrientation)
                    self.currentDeviceOrientation = newDeviceOrientation
                }

            }
        }
    }

    public func stopDeviceOrientationNotifier() {
        motionManager.stopAccelerometerUpdates()
        self.eventReceiver = nil
    }
}


extension UIDeviceOrientation {
    var angle:CGFloat {
        switch self {
        case .portrait:
            return 0
        case .portraitUpsideDown:
            return CGFloat.pi
        case .landscapeLeft:
            return CGFloat.pi / 2
        case .landscapeRight:
            return -CGFloat.pi / 2
        default:
            return 0
        }
    }
    var description:String {
        switch self {
        case .unknown:
            return String("unknown")
            
        case .portrait: // Device oriented vertically, home button on the bottom
            return String("portrait")

        case .portraitUpsideDown: // Device oriented vertically, home button on the top
            return String("portraitUpsideDown")

        case .landscapeLeft: // Device oriented horizontally, home button on the right
            return String("landscapeLeft")

        case .landscapeRight: // Device oriented horizontally, home button on the left
            return String("landscapeRight")

        case .faceUp: // Device oriented flat, face up
            return String("faceUp")

        case .faceDown:
            return String("faceDown")
        }
    }

}


extension CGFloat {
    
    var orientationForAngle: UIDeviceOrientation {
        switch self {
        case 0:
            return .portrait
        case CGFloat.pi:
            return .portraitUpsideDown
        case CGFloat.pi / 2:
            return .landscapeLeft
        case -CGFloat.pi / 2:
            return .landscapeRight
        default:
            return .portrait
        }
    }
}

