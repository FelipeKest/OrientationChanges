//
//  UICustomNavigationBar.swift
//  ARUI_Samples
//
//  Created by Felipe Kestelman on 19/02/19.
//  Copyright © 2019 Felipe Kestelman. All rights reserved.
//

import UIKit

class UICustomNavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
