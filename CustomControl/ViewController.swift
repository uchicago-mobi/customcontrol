//
//  ViewController.swift
//  CustomControl
//
//  Created by Chelsea Troy on 5/7/19.
//  Copyright © 2019 Chelsea Troy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let dualSlider = DualSlider(frame: CGRect.zero)
    let lowerLabel = UILabel()
    let upperLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        dualSlider.backgroundColor = UIColor.darkGray
        view.addSubview(dualSlider)
        
        view.addSubview(lowerLabel)
        view.addSubview(upperLabel)
        
        lowerLabel.text = "0"
        upperLabel.text = "1"
    }

    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        dualSlider.frame = CGRect(
            x: margin,
            y: margin * 3,
            width: width,
            height: 31.0
        )
        
        lowerLabel.frame = CGRect(
            x: margin + 20,
            y: margin * 3 + 40,
            width: 120,
            height: 31.0
        )
        
        upperLabel.frame = CGRect(
            x: width - 20,
            y: margin * 3 + 40,
            width: 120,
            height: 31.0
        )
    }
}

