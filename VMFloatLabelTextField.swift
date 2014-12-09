//
//  VMFloatLabelTextField.swift
//  VMFloatLabel
//
//  Created by Jimmy Jose on 08/12/14.
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

class VMFloatLabelTextField: UITextField {
    
    var floatingLabel = UILabel()
    
    var floatingLabelYPadding:CGFloat = 0.0
    
    var placeholderYPadding:CGFloat = 0.0
    
    var floatingLabelFont:UIFont?
    
    var floatingLabelTextColor = UIColor.grayColor()
    
    var floatingLabelActiveTextColor:UIColor?
    
    var animateEvenIfNotFirstResponder:NSInteger = 0
    
    var floatingLabelShowAnimationDuration = 0.3
    
    var floatingLabelHideAnimationDuration = 0.3
    
    
    private override init(){
        
        super.init()
        commonInit()
        
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit(){
        
        self.floatingLabel = UILabel()
        self.floatingLabel.alpha = 0.0
        
        self.addSubview(self.floatingLabel)
        
        self.floatingLabelFont = UIFont.boldSystemFontOfSize(12.0)
        self.floatingLabel.font = self.floatingLabelFont
        self.floatingLabel.textColor = self.floatingLabelTextColor
        
        
        self.floatingLabelTextColor = UIColor.grayColor()
        self.floatingLabel.textColor = self.floatingLabelTextColor
        self.floatingLabelActiveTextColor = self.tintColor
        self.animateEvenIfNotFirstResponder = 0
        
        setFloatingLabelText(self.placeholder!)
        
    }
    
    func setFloatingLabelText(text:String){
        
        self.floatingLabel.text = text
        self.setNeedsLayout()
        
    }
    
    
    func labelActiveColor() -> UIColor {
        
        if(self.floatingLabelActiveTextColor != nil){
            
            return self.floatingLabelActiveTextColor!
            
        }else {
            
            
            let window = UIApplication.sharedApplication().keyWindow
            if((window) != nil){
                let color = window?.tintColor
                if((color) != nil){
                    return color!
                    
                }
            }
            
            
        }
        
        return UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        
    }
    
    func setFloatingLabelFont(floatingLabelFont:UIFont){
        
        self.floatingLabelFont = floatingLabelFont
        //self.floatingLabel.font = (floatingLabelFont ? floatingLabelFont : UIFont.boldSystemFontOfSize(12.0))
        self.placeholder = self.placeholder
        
    }
    
    func showFloatingLabel(animated:Bool){
        
        if (animated || self.animateEvenIfNotFirstResponder != 0){
            
            UIView.animateWithDuration(self.floatingLabelShowAnimationDuration, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                self.floatingLabel.alpha = 1.0
                self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x, self.floatingLabelYPadding, self.floatingLabel.frame.width, self.floatingLabel.frame.height)
                
                
                }, completion:nil)
            
        }else {
            
            self.floatingLabel.alpha = 1.0
            self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x, self.floatingLabelYPadding, self.floatingLabel.frame.width, self.floatingLabel.frame.height)
            
        }
        
    }
    
    
    func hideFloatingLabel(animated:Bool){
        
        if (animated || self.animateEvenIfNotFirstResponder != 0){
            
            UIView.animateWithDuration(self.floatingLabelHideAnimationDuration, delay: 0.0, options: UIViewAnimationOptions.BeginFromCurrentState | UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                
                self.floatingLabel.alpha = 0.0
                self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x, self.floatingLabel.font.lineHeight + self.floatingLabelYPadding, self.floatingLabel.frame.width, self.floatingLabel.frame.height)
                
                }, completion:nil)
            
        }else {
            
            self.floatingLabel.alpha = 0.0
            self.floatingLabel.frame = CGRectMake(self.floatingLabel.frame.origin.x, self.floatingLabel.font.lineHeight + self.floatingLabelYPadding, self.floatingLabel.frame.width, self.floatingLabel.frame.height)
            
        }
        
    }
    
    
    func setLabelOriginForTextAlignment(){
        
        var textRect:CGRect = textRectForBounds(self.bounds)
        var originX = textRect.origin.x
        
        if (self.textAlignment == NSTextAlignment.Center) {
            originX = textRect.origin.x + (textRect.size.width/2) - (self.floatingLabel.frame.size.width/2)
        }
        else if (self.textAlignment == NSTextAlignment.Right) {
            originX = textRect.origin.x + textRect.size.width - self.floatingLabel.frame.size.width
        } else if (self.textAlignment == NSTextAlignment.Natural) {
            
            /*
            var baseDirection:JVTextDirection = self.floatingLabel.text!.getBaseDirection()
            if (baseDirection == JVTextDirection.JVTextDirectionRightToLeft) {
            originX = textRect.origin.x + textRect.size.width - self.floatingLabel.frame.size.width
            }*/
        }
        
        self.floatingLabel.frame = CGRectMake(originX, self.floatingLabel.frame.origin.y,
            self.floatingLabel.frame.size.width, self.floatingLabel.frame.size.height)
        
    }
    override func textRectForBounds(bounds:CGRect) -> CGRect {
        var rect:CGRect = super.textRectForBounds(bounds)
        
        let text = self.text!
        
        if (countElements(text) > 0) {
            
            var topInset:CGFloat = CGFloat(ceilf(Float(self.floatingLabel.font.lineHeight + self.placeholderYPadding)))
            topInset = min(topInset, maxTopInset())
            rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(topInset, 0.0, 0.0, 0.0))
            
            
        }
        
        return CGRectIntegral(rect)
        
    }
    
    func setPlaceholder(placeholder:NSString){
        
        super.placeholder = placeholder
        self.floatingLabel.text = placeholder
        self.floatingLabel.sizeToFit()
        
    }
    
    
    func setAttributedPlaceholder(attributedPlaceholder:NSAttributedString){
        super.placeholder = placeholder
        self.floatingLabel.text = attributedPlaceholder.string
        self.floatingLabel.sizeToFit()
        
    }
    
    
    func setAttributedPlaceholder(placeholder:NSAttributedString, floatingTitle:NSString){
        super.attributedPlaceholder = placeholder
        self.floatingLabel.text = floatingTitle
        self.floatingLabel.sizeToFit()
        
    }
    
    
    override func editingRectForBounds(bounds:CGRect) -> CGRect {
        
        var rect:CGRect = super.editingRectForBounds(bounds)
        
        let text = self.text!
        
        if (countElements(text) > 0) {
            var topInset:CGFloat = CGFloat(ceilf(Float (self.floatingLabel.font.lineHeight + self.placeholderYPadding)))
            topInset = min(topInset, maxTopInset())
            rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(topInset, 0.0, 0.0, 0.0))
            
        }
        
        return CGRectIntegral(rect)
        
    }
    
    override func clearButtonRectForBounds(bounds:CGRect) -> CGRect {
        
        var rect:CGRect = super.clearButtonRectForBounds(bounds)
        
        let text = self.text!
        
        if (countElements(text) > 0) {
            
            var topInset:CGFloat = CGFloat(ceilf(Float (self.floatingLabel.font.lineHeight + self.placeholderYPadding)))
            topInset = min(topInset, maxTopInset())
            rect = CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0, rect.size.width, rect.size.height)
            
        }
        
        
        return CGRectIntegral(rect)
        
    }
    
    func maxTopInset() -> CGFloat {
        
        let initialValue:CGFloat = 0.0
        return max(initialValue, CGFloat(floorf(Float (self.bounds.size.height - self.font.lineHeight - 4.0))))
        
    }
    
    
    func setTextAlignment(textAlignment:NSTextAlignment){
        
        super.textAlignment = textAlignment
        self.setNeedsLayout()
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        setLabelOriginForTextAlignment()
        
        if((self.floatingLabelFont) != nil){
            
            self.floatingLabel.font = self.floatingLabelFont
            
        }
        
        self.floatingLabel.sizeToFit()
        
        var firstResponder:Bool = self.isFirstResponder()
        
        let text = self.text!
        
        if(firstResponder && countElements(text) > 0 ){
            
            self.floatingLabel.textColor = self.labelActiveColor()
            
        }else {
            self.floatingLabel.textColor = self.floatingLabelTextColor
        }
        
        
        if (countElements(text) == 0) {
            hideFloatingLabel(firstResponder)
        }
        else {
            
            showFloatingLabel(firstResponder)
        }
        
        
    }
    
    
}
