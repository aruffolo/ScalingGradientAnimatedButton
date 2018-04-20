//
//  ViewController.swift
//  ScalingGradientAnimatedButton
//
//  Created by Antonio Ruffolo on 04/19/2018.
//  Copyright (c) 2018 Antonio Ruffolo. All rights reserved.
//

import UIKit
import ScalingGradientAnimatedButton

class ViewController: UIViewController
{
  @IBOutlet weak var button: ScalingGradientAnimatedButton!
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    button.initButton(opacity: 1.0, color: UIColor.black, selectedColor: UIColor.cyan, buttonScale: 0.6, animationDuration: 0.5, shadowOpacity: 0.4, shadowRadius: 1.0, shouldHaveSelectedColorAnimation: true)
    button.initButton(opacity: 1.0, color: UIColor.cyan, buttonScale: 1.3, animationDuration: 0.5, shadowOpacity: 0.6, shadowRadius: 1.0)
    
    button.buttonPosition = .left
    
    button.calculatorButtonEvent = { tag in
      print("Tap or long press received")
    }
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

