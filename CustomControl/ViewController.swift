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

    override func viewDidLoad() {
        super.viewDidLoad()
        dualSlider.backgroundColor = UIColor.darkGray
        view.addSubview(dualSlider)
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
    }
}

