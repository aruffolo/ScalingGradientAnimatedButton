//
//  ScalingGradientAnimatedButton.swift
//  Pods-ScalingGradientAnimatedButton_Example
//
//  Created by Ruffolo Antonio on 19/04/2018.
//

import UIKit

public struct ButtonPosition: OptionSet
{
  public let rawValue: Int
  
  public init(rawValue: Int)
  {
    self.rawValue = rawValue
  }
  
  static let top = ButtonPosition(rawValue: 1 << 0)
  static let bottom = ButtonPosition(rawValue: 1 << 1)
  static let left = ButtonPosition(rawValue: 1 << 2)
  static let right = ButtonPosition(rawValue: 1 << 3)
  static let middle = ButtonPosition(rawValue: 1 << 4)
  
  static let bottomRight: ButtonPosition = [.right, .bottom]
  static let bottomLeft: ButtonPosition = [.left, .bottom]
  static let topRight: ButtonPosition = [.right, .top]
  static let topLeft: ButtonPosition = [.left, .top]
}

public enum ScalingGradientAnimatedButtonViewError: Error
{
  case startGradientColorsAndLocationMismatch(String)
}

public class ScalingGradientAnimatedButton: UIView
{
  /// this is going to be set by the caller that wants to receive events of this view
  public var calculatorButtonEvent: ((_ tag: Int) -> Void)?
  // position of the button relative to the container in which it is. This position will make the button scale but keep the margin at a constant distance
  public var buttonPosition: ButtonPosition = .middle
  
  private var isExpanded: Bool = false
  private var animDuration: TimeInterval = 0.3
  private var buttonScale: CGFloat = 1.5
  
  private let FORWARD_ANIMATION = "forwardAnimation"
  
  private var shadowRadius: CGFloat = 0.8
  private var shadowOpacity: CGFloat = 0.6
  
  private var buttonOpacity: Float = 0.3
  private var startGradientColors: [UIColor] = [UIColor.white, UIColor.white]
  private var startLocations: [NSNumber] = [0.1, 0.9]
  
  private var selectedGradientColors: [UIColor] = [UIColor.yellow, UIColor.orange]
  private var selectedLocations: [NSNumber] = []
  
  private var shouldHaveGradientAnimation: Bool = false
  
  var gradientLayer: CAGradientLayer = {
    let gradientLayer = CAGradientLayer()
    
    gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.2)
    gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
    
    let colors = [UIColor.white, UIColor.white].map { return $0.cgColor }
    gradientLayer.colors = colors
    
    let locations: [NSNumber] = [0.1, 0.9]
    gradientLayer.locations = locations
    
    return gradientLayer
  }()
  
  private func createInitialGradientLayer() -> CAGradientLayer
  {
    let gradientLayer = CAGradientLayer()
    
    gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.2)
    gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.8)
    
    gradientLayer.colors = startGradientColors.map{ return $0.cgColor }
    
    gradientLayer.locations = startLocations
    
    return gradientLayer
  }

  /// init function to inject dependencies into the button
  ///
  /// - Parameters:
  ///   - opacity: opacity that the button must have
  ///   - startGradientColors: the button can have a gradient when not selected
  ///   - startLocations: locatons of the gradient when not selected
  ///   - selectedGradientColors: gradient colors for when the button is selected
  ///   - selectedLocations: locations of the gradient when the button is selected
  ///   - buttonScale: scale of the selected button, it will move forward if grater than one or back if less than one
  ///   - animationDuration: duration of the animation for the selection of the gradient and the scale
  ///   - shadowOpacity: opacity of the button shadow
  ///   - shadowRadius: radius of the shadow
  ///   - shouldHaveSelectedGradientAnimation: a boolean to choose if the button must change gradient when selected
  /// - Throws: startGradientColorsAndLocationMismatch, thown when there is a mismatch in the colors for the selected gradient and the no selected gradient
  public func initButton(opacity: Float,
                         startGradientColors: [UIColor],
                         startLocations: [NSNumber],
                         selectedGradientColors: [UIColor],
                         selectedLocations: [NSNumber],
                         buttonScale: CGFloat,
                         animationDuration: TimeInterval,
                         shadowOpacity: CGFloat,
                         shadowRadius: CGFloat,
                         shouldHaveSelectedGradientAnimation: Bool) throws
  {
    guard startLocations.count == startGradientColors.count && selectedGradientColors.count == selectedLocations.count
      else
    {
      throw ScalingGradientAnimatedButtonViewError.startGradientColorsAndLocationMismatch("Gradient Locations and Gradient Colors must have the same size")
    }
    self.startGradientColors = startGradientColors
    self.startLocations = startLocations
    
    self.selectedGradientColors = selectedGradientColors
    self.selectedLocations = selectedLocations
    self.buttonOpacity = opacity
    
    gradientLayer.removeFromSuperlayer()
    
    gradientLayer = createInitialGradientLayer()
    gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
    layer.insertSublayer(gradientLayer, at: 0)
    
    gradientLayer.opacity = buttonOpacity
    self.buttonScale = buttonScale
    self.animDuration = animationDuration
    self.shadowRadius = shadowRadius
    self.shadowOpacity = shadowOpacity
    
    self.shouldHaveGradientAnimation = shouldHaveSelectedGradientAnimation
  }
  
  
  /// init function for inject dependencies into the button
  ///
  /// - Parameters:
  ///   - opacity: opacity that the button must have
  ///   - color: color for the button when not selected
  ///   - selectedColor: color for the button when selected
  ///   - buttonScale: scale of the selected button, it will move forward if greater than one or back if less than one
  ///   - animationDuration: duration of the animation for the selction of the color and the scale
  ///   - shadowOpacity: opacity for the button shadow
  ///   - shadowRadius: radius of the shadow
  ///   - shouldHaveSelectedColorAnimation: a boolean to choose fi the button must change color when selected
  public func initButton(opacity: Float,
                         color: UIColor,
                         selectedColor: UIColor,
                         buttonScale: CGFloat,
                         animationDuration: TimeInterval,
                         shadowOpacity: CGFloat,
                         shadowRadius: CGFloat,
                         shouldHaveSelectedColorAnimation: Bool) throws
  {
    self.startGradientColors = [color, color]
    self.startLocations = [0.1, 0.9]
    
    self.selectedGradientColors = [selectedColor, selectedColor]
    self.selectedLocations = [0.1, 0.9]
    self.buttonOpacity = opacity
    
    gradientLayer.removeFromSuperlayer()
    
    gradientLayer = createInitialGradientLayer()
    gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
    layer.insertSublayer(gradientLayer, at: 0)
    
    gradientLayer.opacity = buttonOpacity
    self.buttonScale = buttonScale
    self.animDuration = animationDuration
    self.shadowRadius = shadowRadius
    self.shadowOpacity = shadowOpacity
    
    self.shouldHaveGradientAnimation = shouldHaveSelectedColorAnimation
  }
  
  override public func layoutSubviews()
  {
    gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
  }
  
  override public func didMoveToWindow()
  {
    layer.insertSublayer(gradientLayer, at: 0)
    gradientLayer.opacity = buttonOpacity
    
    addTapGestureRecognizer()
    addLongPressGestureRecognizer()
  }
  
  private func createSquareMaskLayer(rect: CGRect) -> CALayer
  {
    let layer = CAShapeLayer()
    layer.path = createRectPath(rect: rect, borderWidth: 0.5)
    layer.fillColor = UIColor.magenta.cgColor
    layer.fillRule = kCAFillRuleNonZero
    layer.lineJoin = kCALineJoinMiter
    return layer
  }
  
  private func createRectPath(rect: CGRect, borderWidth: CGFloat) -> CGPath
  {
    let path = UIBezierPath()
    
    let offset:CGFloat = borderWidth
    let negativeOffset = -borderWidth
    path.move(to: CGPoint(x: (rect.origin.x + offset), y: (rect.origin.y) + offset))
    path.addLine(to: CGPoint(x: (rect.origin.x) + rect.size.width + negativeOffset, y: (rect.origin.y) + offset))
    path.addLine(to: CGPoint(x: (rect.origin.x + rect.size.width  + negativeOffset), y: (rect.origin.y + rect.size.height + negativeOffset)))
    path.addLine(to: CGPoint(x: (rect.origin.x) + offset, y: (rect.origin.y + rect.size.height) + negativeOffset))
    path.close()
    
    return path.cgPath
  }
  
  private func createCirclePathLayer(radius: CGFloat) -> CALayer
  {
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2),
                                  radius: radius,
                                  startAngle: 0,
                                  endAngle: CGFloat.pi * 2,
                                  clockwise: true)
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    
    return shapeLayer
  }
  
  private func addTapGestureRecognizer()
  {
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapArrived))
    tap.delegate = self
    self.addGestureRecognizer(tap)
  }
  
  private func addLongPressGestureRecognizer()
  {
    let long = UILongPressGestureRecognizer(target: self, action: #selector(pressing))
    long.minimumPressDuration = 0.1
    addGestureRecognizer(long)
  }
  
  @objc func tapArrived()
  {
    changeAndSaveZPositionToBeAboveAllViews()
    moveLeftOrRithAnimation(revertAnimation: true, direction: buttonPosition)
    addShadowAnimation()
    if shouldHaveGradientAnimation
    {
      addGradientAnimation()
    }
    
    calculatorButtonEvent?(tag)
  }
  
  @objc func pressing(sender: UILongPressGestureRecognizer)
  {
    switch sender.state
    {
    case .began:
      changeAndSaveZPositionToBeAboveAllViews()
      moveLeftOrRithAnimation(revertAnimation: false, direction: buttonPosition)
      addShadowAnimation()
      if shouldHaveGradientAnimation
      {
        addGradientAnimation()
      }
    case .ended:
      revertMoveLeftOrRightAnimation(direction: buttonPosition)
      revertShadowAnimation()
      if shouldHaveGradientAnimation
      {
        revertGradientAnimation()
      }
      calculatorButtonEvent?(tag)
    default:
      break
    }
  }
  
  private func changeAndSaveZPositionToBeAboveAllViews()
  {
    var father = superview
    while father != nil
    {
      father?.layer.zPosition = 1
      father = father?.superview
    }
    
    self.superview?.superview?.layer.zPosition = 1
    self.superview?.layer.zPosition = 1
    self.layer.zPosition = 1
  }
  
  private func restoreZPosition()
  {
    var father = superview
    while father != nil
    {
      father?.layer.zPosition = 0
      father = father?.superview
    }
    self.superview?.superview?.layer.zPosition = 0
    self.superview?.layer.zPosition = 0
    self.layer.zPosition = 0
  }
  
  private func scaleViewAnimation(revertAnimation: Bool)
  {
    let moveFrwd = CABasicAnimation(keyPath: "transform")
    moveFrwd.fromValue =  NSValue(caTransform3D: CATransform3DIdentity)
    moveFrwd.toValue = NSValue(caTransform3D: CATransform3DMakeScale(buttonScale, buttonScale, 1.0))
    
    moveFrwd.duration = animDuration
    moveFrwd.fillMode = kCAFillModeForwards
    moveFrwd.isRemovedOnCompletion = false
    moveFrwd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    if revertAnimation
    {
      moveFrwd.setValue("springScale", forKey: "name")
      moveFrwd.delegate = self
    }
    else
    {
      moveFrwd.delegate = nil
    }
    layer.add(moveFrwd, forKey: nil)
  }
  
  private func moveLeftOrRithAnimation(revertAnimation: Bool, direction: ButtonPosition)
  {
    let scaledWidth = bounds.size.width * buttonScale
    let scaledHeight = bounds.size.height * buttonScale
    
    var deltaWidth = !direction.isDisjoint(with: [.left, .right]) ? (scaledWidth - bounds.size.width) / 2 : 0
    var deltaHeight = !direction.isDisjoint(with: [.top, .bottom]) ? (scaledHeight - bounds.size.height) / 2 : 0
    
    if direction.contains(.right)
    {
      deltaWidth = -deltaWidth
    }
    if direction.contains(.bottom)
    {
      deltaHeight = -deltaHeight
    }
    
    let anim = CABasicAnimation(keyPath: "transform")
    anim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
    let scale = CATransform3DMakeScale(buttonScale, buttonScale, 1.0)
    let translateLeft = CATransform3DTranslate(CATransform3DIdentity, deltaWidth, deltaHeight, 0)
    let result = CATransform3DConcat(scale, translateLeft)
    anim.toValue = NSValue(caTransform3D: result)
    
    anim.duration = animDuration
    anim.fillMode = kCAFillModeForwards
    anim.isRemovedOnCompletion = false
    anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    if revertAnimation
    {
      anim.setValue("springScale", forKey: "name")
      anim.delegate = self
    }
    else
    {
      anim.delegate = nil
    }
    layer.add(anim, forKey: nil)
  }
  
  private func addShadowAnimation()
  {
    let shadowGroupAnimation = CAAnimationGroup()
    shadowGroupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    shadowGroupAnimation.duration = animDuration
    shadowGroupAnimation.fillMode = kCAFillModeForwards
    shadowGroupAnimation.isRemovedOnCompletion = false
    shadowGroupAnimation.autoreverses = false
    
    let colorAnimation = CABasicAnimation(keyPath: "shadowColor")
    colorAnimation.fromValue = UIColor.clear.cgColor
    colorAnimation.toValue = UIColor.black.cgColor
    
    let opacityAnimation = CABasicAnimation(keyPath: "shadowOpacity")
    opacityAnimation.fromValue = 0.0
    opacityAnimation.toValue = shadowOpacity
    
    let radiusAnimation = CABasicAnimation(keyPath: "shadowRadius")
    radiusAnimation.fromValue = 0
    radiusAnimation.toValue = shadowRadius
    
    let shadowOffsetAnim = CABasicAnimation(keyPath: "shadowOffset")
    shadowOffsetAnim.fromValue = CGSize(width: 0, height: 0)
    shadowOffsetAnim.toValue = createShadowOffset(direction: self.buttonPosition)
    
    shadowGroupAnimation.animations = [colorAnimation, opacityAnimation, radiusAnimation, shadowOffsetAnim]
    layer.add(shadowGroupAnimation, forKey: nil)
  }
  
  private func createShadowOffset(direction: ButtonPosition) -> CGSize
  {
    var verticalOffset = shadowRadius
    var horizontalOffset = shadowRadius
    
    if direction.contains(.right)
    {
      horizontalOffset = -horizontalOffset
    }
    else if !direction.contains(.left)
    {
      horizontalOffset = 0
    }
    
    if direction.contains(.bottom)
    {
      verticalOffset = -verticalOffset
    }
    else if !direction.contains(.top)
    {
      verticalOffset = 0
    }
    
    return CGSize(width: horizontalOffset, height: verticalOffset)
  }
  
  private func addGradientAnimation()
  {
    let gradientGroupAnimation = CAAnimationGroup()
    gradientGroupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    gradientGroupAnimation.duration = animDuration
    gradientGroupAnimation.fillMode = kCAFillModeForwards
    gradientGroupAnimation.isRemovedOnCompletion = false
    gradientGroupAnimation.autoreverses = false
    
    let opacityAnim = selectedButtonGradientOpacityAnimation()
    let colorsAnimation = selectedButtonGradientColorsAnimation()
    
    gradientGroupAnimation.animations = [colorsAnimation, opacityAnim]
    gradientLayer.add(gradientGroupAnimation, forKey: nil)
  }
  
  private func selectedButtonGradientOpacityAnimation() -> CABasicAnimation
  {
    let anim = CABasicAnimation(keyPath: "opacity")
    anim.fromValue = buttonOpacity
    anim.toValue = 1.0
    return anim
  }
  
  private func selectedButtonGradientColorsAnimation() -> CABasicAnimation
  {
    let anim = CABasicAnimation(keyPath: "colors")
    anim.toValue = selectedGradientColors.map { return $0.cgColor }
    return anim
  }
  
  func moveBackwardGradientLayer()
  {
    let moveFrwd = CABasicAnimation(keyPath: "transform")
    moveFrwd.fromValue = NSValue(caTransform3D: CATransform3DMakeScale(buttonScale, buttonScale, 1.0))
    moveFrwd.toValue = NSValue(caTransform3D: CATransform3DIdentity)
    
    moveFrwd.duration = 0.1
    moveFrwd.fillMode = kCAFillModeForwards
    moveFrwd.isRemovedOnCompletion = false
    layer.add(moveFrwd, forKey: nil)
  }
  
  private func revertMoveLeftOrRightAnimation(direction: ButtonPosition)
  {
    let scaledWidth = bounds.size.width * buttonScale
    let scaledHeight = bounds.size.height * buttonScale
    
    var deltaWidth = !direction.isDisjoint(with: [.left, .right]) ? (scaledWidth - bounds.size.width) / 2 : 0
    var deltaHeight = !direction.isDisjoint(with: [.top, .bottom]) ? (scaledHeight - bounds.size.height) / 2 : 0
    
    if direction.contains(.right)
    {
      deltaWidth = -deltaWidth
    }
    if direction.contains(.bottom)
    {
      deltaHeight = -deltaHeight
    }
    
    let anim = CABasicAnimation(keyPath: "transform")
    let scale = CATransform3DMakeScale(buttonScale, buttonScale, 1.0)
    let translateAndScale = CATransform3DTranslate(CATransform3DIdentity, deltaWidth, deltaHeight, 0)
    let result = CATransform3DConcat(scale, translateAndScale)
    
    anim.fromValue = NSValue(caTransform3D: result)
    anim.toValue = NSValue(caTransform3D: CATransform3DIdentity)
    
    anim.setValue("revertScale", forKey: "name")
    anim.delegate = self
    
    anim.duration = animDuration
    anim.fillMode = kCAFillModeForwards
    anim.isRemovedOnCompletion = false
    anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    layer.add(anim, forKey: nil)
  }
  
  private func revertShadowAnimation()
  {
    let shadowGroupAnimation = CAAnimationGroup()
    shadowGroupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    shadowGroupAnimation.duration = animDuration
    shadowGroupAnimation.fillMode = kCAFillModeForwards
    shadowGroupAnimation.isRemovedOnCompletion = false
    shadowGroupAnimation.autoreverses = false
    
    let colorAnimation = CABasicAnimation(keyPath: "shadowColor")
    colorAnimation.fromValue = UIColor.black.cgColor
    colorAnimation.toValue = UIColor.clear.cgColor
    
    let opacityAnimation = CABasicAnimation(keyPath: "shadowOpacity")
    opacityAnimation.fromValue = shadowOpacity
    opacityAnimation.toValue = 0.0
    
    let radiusAnimation = CABasicAnimation(keyPath: "shadowRadius")
    radiusAnimation.fromValue = shadowRadius
    radiusAnimation.toValue = 0
    
    shadowGroupAnimation.animations = [colorAnimation, opacityAnimation, radiusAnimation]
    layer.add(shadowGroupAnimation, forKey: nil)
  }
  
  private func revertGradientAnimation()
  {
    let gradientGroupAnimation = CAAnimationGroup()
    gradientGroupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    gradientGroupAnimation.duration = animDuration
    gradientGroupAnimation.fillMode = kCAFillModeForwards
    gradientGroupAnimation.isRemovedOnCompletion = false
    
    let opacityAnim = revertGradientOpacityAnimation()
    let colorsAnimation = revertGradientColorsAnimation()
    
    gradientGroupAnimation.animations = [colorsAnimation, opacityAnim]
    gradientLayer.add(gradientGroupAnimation, forKey: nil)
  }
  
  private func revertGradientOpacityAnimation() -> CABasicAnimation
  {
    let anim = CABasicAnimation(keyPath: "opacity")
    anim.fromValue = 1.0
    anim.toValue = buttonOpacity
    return anim
  }
  
  private func revertGradientColorsAnimation() -> CABasicAnimation
  {
    let anim = CABasicAnimation(keyPath: "colors")
    anim.fromValue = selectedGradientColors.map { return $0.cgColor }
    anim.toValue = startGradientColors.map { return $0.cgColor }
    
    return anim
  }
}

extension ScalingGradientAnimatedButton: CAAnimationDelegate
{
  public func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
  {
    guard let name = anim.value(forKey: "name") as? String
      else { return }
    
    if name == "springScale"
    {
      revertMoveLeftOrRightAnimation(direction: buttonPosition)
      revertShadowAnimation()
      
      if shouldHaveGradientAnimation
      {
        revertGradientAnimation()
      }
    }
    if name == "revertScale"
    {
      restoreZPosition()
    }
  }
}

extension ScalingGradientAnimatedButton: UIGestureRecognizerDelegate
{
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool
  {
    return  gestureRecognizer is UITapGestureRecognizer && otherGestureRecognizer is UILongPressGestureRecognizer
  }
}


