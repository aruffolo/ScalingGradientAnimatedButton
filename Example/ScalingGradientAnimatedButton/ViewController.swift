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
    
    do
    {
      try button.initButton(opacity: 1.0, color: UIColor.black, selectedColor: UIColor.cyan, buttonScale: 0.6, animationDuration: 0.5, shadowOpacity: 0.4, shadowRadius: 1.0, shouldHaveSelectedColorAnimation: true)
    }
    catch ScalingGradientAnimatedButtonViewError.startGradientColorsAndLocationMismatch(let errorMessage)
    {
      print(errorMessage)
    }
    catch
    {
      print(error)
    }

  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

