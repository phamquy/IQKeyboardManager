//
//  IQUIView+IQKeyboardToolbar.swift
// https://github.com/hackiftekhar/IQKeyboardManager
// Copyright (c) 2013-14 Iftekhar Qurashi.
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

/*  @const kIQRightButtonToolbarTag        Default tag for toolbar with Right button           -1001.   */
let kIQRightButtonToolbarTag : NSInteger            =   -1001
/*  @const kIQDoneButtonToolbarTag         Default tag for toolbar with Done button            -1002.   */
let  kIQDoneButtonToolbarTag : NSInteger            =   -1002
/*  @const kIQRightLeftButtonToolbarTag    Default tag for toolbar with Right/Left buttons     -1003.   */
let  kIQRightLeftButtonToolbarTag : NSInteger       =   -1003
/*  @const kIQCancelDoneButtonToolbarTag   Default tag for toolbar with Cancel/Done buttons    -1004.   */
let  kIQCancelDoneButtonToolbarTag : NSInteger      =   -1004
/*  @const kIQPreviousNextButtonToolbarTag Default tag for toolbar with Previous/Next buttons  -1005.   */
let  kIQPreviousNextButtonToolbarTag : NSInteger    =   -1005

extension UIView {
    
    /*!
    @method addDoneOnKeyboardWithTarget:action:
    
    @abstract Helper functions to add Done button on keyboard.
    
    @param target: Target object for selector. Usually 'self'.
    
    @param action: Done button action name. Usually 'doneAction:(IQBarButtonItem*)item'.
    
    @param shouldShowPlaceholder: A boolean to indicate whether to show textField placeholder on IQToolbar'.
    
    @param titleText: text to show as title in IQToolbar'.
    */
    func addRightButtonOnKeyboardWithText (text : String, target : AnyObject, action : Selector, titleText: String!) {
        
        //If can't set InputAccessoryView. Then return
        if self.respondsToSelector("setInputAccessoryView:") == false  {
            return
        }
        
        //  Creating a toolBar for phoneNumber keyboard
        var toolbar = IQToolbar()
        toolbar.tag = kIQRightButtonToolbarTag
        
        var items = NSMutableArray()
        
        if ( titleText != nil && countElements(titleText) != 0 /* && self.shouldHideTitle == false */)
        {
            var buttonFrame : CGRect
            
            if (IQ_IS_IOS7_OR_GREATER)
            {
                /*
                50 done button frame.
                24 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-50.0-24, 44)
            }
            else
            {
                /*
                57 done button frame.
                8 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-57.0-8, 44)
            }
            
            var title = IQTitleBarButtonItem(frame: buttonFrame, title: titleText?)
            items.addObject(title)
        }
        
        
        //  Create a fake button to maintain flexibleSpace between doneButton and nilButton. (Actually it moves done button to right side.
        var nilButton = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.addObject(nilButton)
    
        //  Create a done button to show on keyboard to resign it. Adding a selector to resign it.
        var doneButton = IQBarButtonItem(title: text, style: UIBarButtonItemStyle.Done, target: target, action: action)
        items.addObject(doneButton)
        
        //  Adding button to toolBar.
        toolbar.items = items
        
        //  Setting toolbar to keyboard.
        if (self is UITextField) == true {
            
            var textField : UITextField = self as UITextField
            textField.inputAccessoryView = toolbar
        }
        else if (self is UITextView) == true {
            
            var textView : UITextView = self as UITextView
            textView.inputAccessoryView = toolbar
        }
    }
    
    func addRightButtonOnKeyboardWithText (text : String, target : AnyObject, action : Selector, shouldShowPlaceholder: Bool) {
        
        var title : String!

        if shouldShowPlaceholder {
            var textField : UITextField? = self as? UITextField
            
            title = textField?.placeholder
        }
        
        addRightButtonOnKeyboardWithText(text, target: target, action: action, titleText: title)
    }
    
    func addRightButtonOnKeyboardWithText (text : String, target : AnyObject, action : Selector) {
        
        addRightButtonOnKeyboardWithText(text, target: target, action: action, titleText: nil)
    }

    func addDoneOnKeyboardWithTarget (target : AnyObject, action : Selector, titleText: String!) {
        
        //If can't set InputAccessoryView. Then return
        if self.respondsToSelector("setInputAccessoryView:") == false  {
            return
        }
        
        //  Creating a toolBar for phoneNumber keyboard
        var toolbar = IQToolbar()
        toolbar.tag = kIQRightButtonToolbarTag
        
        var items = NSMutableArray()
        
        if ( titleText != nil && countElements(titleText) != 0 /* && self.shouldHideTitle == false */)
        {
            var buttonFrame : CGRect
            
            if (IQ_IS_IOS7_OR_GREATER)
            {
                /*
                50 done button frame.
                24 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-50.0-24, 44)
            }
            else
            {
                /*
                57 done button frame.
                8 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-57.0-8, 44)
            }
            
            var title = IQTitleBarButtonItem(frame: buttonFrame, title: titleText?)
            items.addObject(title)
        }
        
        
        //  Create a fake button to maintain flexibleSpace between doneButton and nilButton. (Actually it moves done button to right side.
        var nilButton = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.addObject(nilButton)
        
        //  Create a done button to show on keyboard to resign it. Adding a selector to resign it.
        var doneButton = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: target, action: action)
        items.addObject(doneButton)
        
        //  Adding button to toolBar.
        toolbar.items = items
        
        //  Setting toolbar to keyboard.
        if (self is UITextField) == true {
            
            var textField : UITextField = self as UITextField
            textField.inputAccessoryView = toolbar
        }
        else if (self is UITextView) == true {
            
            var textView : UITextView = self as UITextView
            textView.inputAccessoryView = toolbar
        }
    }
    
    func addDoneOnKeyboardWithTarget (target : AnyObject, action : Selector, shouldShowPlaceholder: Bool) {
        
        var title : String!
        
        if shouldShowPlaceholder {
            var textField : UITextField? = self as? UITextField
            
            title = textField?.placeholder
        }

        addDoneOnKeyboardWithTarget(target, action: action, titleText: title)
    }
    
    func addDoneOnKeyboardWithTarget (target : AnyObject, action : Selector) {
        
        addDoneOnKeyboardWithTarget(target, action: action, titleText: nil)
    }

    
    /*!
    @method addCancelDoneOnKeyboardWithTarget:cancelAction:doneAction:
    
    @abstract Helper function to add Cancel and Done button on keyboard.
    
    @param target: Target object for selector. Usually 'self'.
    
    @param cancelAction: Crevious button action name. Usually 'cancelAction:(IQBarButtonItem*)item'.
    
    @param doneAction: Done button action name. Usually 'doneAction:(IQBarButtonItem*)item'.
    
    @param shouldShowPlaceholder: A boolean to indicate whether to show textField placeholder on IQToolbar'.
    
    @param titleText: text to show as title in IQToolbar'.
    */
    
    func addRightLeftOnKeyboardWithTarget( target : AnyObject, leftButtonTitle : String, rightButtonTitle : String, rightButtonAction : Selector, leftButtonAction : Selector, titleText: String!) {
        
        //If can't set InputAccessoryView. Then return
        if self.respondsToSelector("setInputAccessoryView:") == false  {
            return
        }
        
        //  Creating a toolBar for phoneNumber keyboard
        var toolbar = IQToolbar()
        toolbar.tag = kIQPreviousNextButtonToolbarTag
        
        var items = NSMutableArray()
        
        
        //  Create a cancel button to show on keyboard to resign it. Adding a selector to resign it.
        var cancelButton = IQBarButtonItem(title: leftButtonTitle, style: UIBarButtonItemStyle.Bordered, target: target, action: leftButtonAction)
        items.addObject(cancelButton)
        
        if ( titleText != nil && countElements(titleText) != 0 /* && self.shouldHideTitle == false */)
        {
            var buttonFrame : CGRect
            
            if (IQ_IS_IOS7_OR_GREATER)
            {
                /*
                66 Cancel button maximum x.
                50 done button frame.
                8+8 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-66-50.0-16, 44);
            }
            else
            {
                /*
                66 Cancel button maximum x.
                57 done button frame.
                8+8 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-66-57.0-16, 44);
            }
            
            var title = IQTitleBarButtonItem(frame: buttonFrame, title: titleText?)
            items.addObject(title)
        }
        
        //  Create a fake button to maintain flexibleSpace between doneButton and nilButton. (Actually it moves done button to right side.
        var nilButton = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.addObject(nilButton)
        
        //  Create a done button to show on keyboard to resign it. Adding a selector to resign it.
        var doneButton = IQBarButtonItem(title: rightButtonTitle, style: UIBarButtonItemStyle.Bordered, target: target, action: rightButtonAction)
        items.addObject(doneButton)
        
        //  Adding button to toolBar.
        toolbar.items = items
        
        //  Setting toolbar to keyboard.
        if (self is UITextField) == true {
            
            var textField : UITextField = self as UITextField
            textField.inputAccessoryView = toolbar
        }
        else if (self is UITextView) == true {
            
            var textView : UITextView = self as UITextView
            textView.inputAccessoryView = toolbar
        }
    }
    
    func addRightLeftOnKeyboardWithTarget( target : AnyObject, leftButtonTitle : String, rightButtonTitle : String, rightButtonAction : Selector, leftButtonAction : Selector, shouldShowPlaceholder: Bool) {
        
        var title : String!
        
        if shouldShowPlaceholder {
            var textField : UITextField? = self as? UITextField
            
            title = textField?.placeholder
        }
        
        addRightLeftOnKeyboardWithTarget(target, leftButtonTitle: leftButtonTitle, rightButtonTitle: rightButtonTitle, rightButtonAction: rightButtonAction, leftButtonAction: leftButtonAction, titleText: title)
    }
    
    func addRightLeftOnKeyboardWithTarget( target : AnyObject, leftButtonTitle : String, rightButtonTitle : String, rightButtonAction : Selector, leftButtonAction : Selector) {
        
        addRightLeftOnKeyboardWithTarget(target, leftButtonTitle: leftButtonTitle, rightButtonTitle: rightButtonTitle, rightButtonAction: rightButtonAction, leftButtonAction: leftButtonAction, titleText: nil)
    }
    
    func addCancelDoneOnKeyboardWithTarget (target : AnyObject, cancelAction : Selector, doneAction : Selector, titleText: String!) {
        
        //If can't set InputAccessoryView. Then return
        if self.respondsToSelector("setInputAccessoryView:") == false  {
            return
        }
        
        //  Creating a toolBar for phoneNumber keyboard
        var toolbar = IQToolbar()
        toolbar.tag = kIQPreviousNextButtonToolbarTag
        
        var items = NSMutableArray()
        
        
        //  Create a cancel button to show on keyboard to resign it. Adding a selector to resign it.
        var cancelButton = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: target, action: cancelAction)
        items.addObject(cancelButton)
        
        if ( titleText != nil && countElements(titleText) != 0 /* && self.shouldHideTitle == false */)
        {
            var buttonFrame : CGRect
            
            if (IQ_IS_IOS7_OR_GREATER)
            {
                /*
                66 Cancel button maximum x.
                50 done button frame.
                8+8 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-66-50.0-16, 44);
            }
            else
            {
                /*
                66 Cancel button maximum x.
                57 done button frame.
                8+8 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-66-57.0-16, 44);
            }
            
            var title = IQTitleBarButtonItem(frame: buttonFrame, title: titleText?)
            items.addObject(title)
        }
        
        //  Create a fake button to maintain flexibleSpace between doneButton and nilButton. (Actually it moves done button to right side.
        var nilButton = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        items.addObject(nilButton)
        
        //  Create a done button to show on keyboard to resign it. Adding a selector to resign it.
        var doneButton = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: target, action: doneAction)
        items.addObject(doneButton)
        
        //  Adding button to toolBar.
        toolbar.items = items
        
        //  Setting toolbar to keyboard.
        if (self is UITextField) == true {
            
            var textField : UITextField = self as UITextField
            textField.inputAccessoryView = toolbar
        }
        else if (self is UITextView) == true {
            
            var textView : UITextView = self as UITextView
            textView.inputAccessoryView = toolbar
        }
    }
    
    func addCancelDoneOnKeyboardWithTarget (target : AnyObject, cancelAction : Selector, doneAction : Selector, shouldShowPlaceholder: Bool) {
        
        var title : String!
        
        if shouldShowPlaceholder {
            var textField : UITextField? = self as? UITextField
            
            title = textField?.placeholder
        }
        
        addCancelDoneOnKeyboardWithTarget(target, cancelAction: cancelAction, doneAction: doneAction, titleText: title)
    }
    
    func addCancelDoneOnKeyboardWithTarget (target : AnyObject, cancelAction : Selector, doneAction : Selector) {
        
        addCancelDoneOnKeyboardWithTarget(target, cancelAction: cancelAction, doneAction: doneAction, titleText: nil)
    }
    
    
    /*!
    @method addPreviousNextDoneOnKeyboardWithTarget:previousAction:nextAction:doneAction
    
    @abstract Helper function to add SegmentedNextPrevious and Done button on keyboard.
    
    @param target: Target object for selector. Usually 'self'.
    
    @param previousAction: Previous button action name. Usually 'previousAction:(IQSegmentedNextPrevious*)segmentedControl'.
    
    @param nextAction: Next button action name. Usually 'nextAction:(IQSegmentedNextPrevious*)segmentedControl'.
    
    @param doneAction: Done button action name. Usually 'doneAction:(IQBarButtonItem*)item'.
    
    @param shouldShowPlaceholder: A boolean to indicate whether to show textField placeholder on IQToolbar'.
    
    @param titleText: text to show as title in IQToolbar'.
    */
    func addPreviousNextDoneOnKeyboardWithTarget ( target : AnyObject, previousAction : Selector, nextAction : Selector, doneAction : Selector,  titleText: String!) {
        
        //If can't set InputAccessoryView. Then return
        if self.respondsToSelector("setInputAccessoryView:") == false  {
            return
        }
        
        //  Creating a toolBar for phoneNumber keyboard
        var toolbar = IQToolbar()
        toolbar.tag = kIQPreviousNextButtonToolbarTag
        
        var items = NSMutableArray()
        
        //  Create a done button to show on keyboard to resign it. Adding a selector to resign it.
        
        var doneButton = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: target, action: doneAction)
        
        if (IQ_IS_IOS7_OR_GREATER)
        {
            var prev = IQBarButtonItem(image: UIImage(named: "IQKeyboardManager.bundle/IQButtonBarArrowLeft"), style: UIBarButtonItemStyle.Plain, target: target, action: previousAction)
            
            var fixed = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
            fixed.width = 23
            
            var next = IQBarButtonItem(image: UIImage(named: "IQKeyboardManager.bundle/IQButtonBarArrowRight"), style: UIBarButtonItemStyle.Plain, target: target, action: nextAction)
            
            items.addObject(prev)
            items.addObject(fixed)
            items.addObject(next)
        }
        else
        {
            var segControl = IQSegmentedNextPrevious(target: target, previousAction: previousAction, nextAction: nextAction)
            var segButton = IQBarButtonItem(customView: segControl)

            items.addObject(segButton)
        }
        
        if ( titleText != nil && countElements(titleText) != 0 /* && self.shouldHideTitle == false */)
        {
            var buttonFrame : CGRect
            
            if (IQ_IS_IOS7_OR_GREATER)
            {
                /*
                72.5 next/previous maximum x.
                50 done button frame.
                8+8 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-72.5-50.0-16, 44)
            }
            else
            {
                /*
                135 next/previous maximum x.
                57 done button frame.
                8+8 distance maintenance
                */
                buttonFrame = CGRectMake(0, 0, toolbar.frame.size.width-135-57.0-16, 44)
            }
            
            var title = IQTitleBarButtonItem(frame: buttonFrame, title: titleText?)
            items.addObject(title)
        }
        
        //  Create a fake button to maintain flexibleSpace between doneButton and nilButton. (Actually it moves done button to right side.
        var nilButton = IQBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)

        items.addObject(nilButton)
        items.addObject(doneButton)
        
        //  Adding button to toolBar.
        toolbar.items = items

        //  Setting toolbar to keyboard.
        if (self is UITextField) == true {

            var textField : UITextField = self as UITextField
            textField.inputAccessoryView = toolbar
        }
        else if (self is UITextView) == true {

            var textView : UITextView = self as UITextView
            textView.inputAccessoryView = toolbar
        }
    }
    
    public func addPreviousNextDoneOnKeyboardWithTarget ( target : AnyObject, previousAction : Selector, nextAction : Selector, doneAction : Selector, shouldShowPlaceholder: Bool) {
        
        var title : String?
        
        if shouldShowPlaceholder {
            
            var textField : UITextField? = self as? UITextField
            
            title = textField?.placeholder
        }
        
        addPreviousNextDoneOnKeyboardWithTarget(target, previousAction: previousAction, nextAction: nextAction, doneAction: doneAction, titleText: title)
    }
    
    func addPreviousNextDoneOnKeyboardWithTarget ( target : AnyObject, previousAction : Selector, nextAction : Selector, doneAction : Selector) {
        
        addPreviousNextDoneOnKeyboardWithTarget(target, previousAction: previousAction, nextAction: nextAction, doneAction: doneAction, titleText: nil)
    }
    
    /*!
    @method setEnablePrevious:next:
    
    @abstract Helper function to enable and disable previous next buttons.
    
    @param isPreviousEnabled: BOOL to enable/disable previous button on keyboard.
    
    @param isNextEnabled:  BOOL to enable/disable next button on keyboard..
    */
    func setEnablePrevious ( isPreviousEnabled : Bool, isNextEnabled : Bool) {
        
        //  Getting inputAccessoryView.
        var inputAccessoryView : IQToolbar? = self.inputAccessoryView as? IQToolbar
        
        //  If it is IQToolbar and it's items are greater than zero.
        if (inputAccessoryView?.isKindOfClass(IQToolbar) == true && inputAccessoryView?.items?.count>0)
        {
            if (IQ_IS_IOS7_OR_GREATER && inputAccessoryView?.items?.count>3)
            {
                //  Getting first item from inputAccessoryView.
                var items : NSArray? = inputAccessoryView?.items
                
                var prevButton : IQBarButtonItem? = items?.objectAtIndex(0) as? IQBarButtonItem
                var nextButton : IQBarButtonItem? = items?.objectAtIndex(2) as? IQBarButtonItem

                //  If it is UIBarButtonItem and it's customView is not nil.
                if (prevButton?.isKindOfClass(IQBarButtonItem) == true && nextButton?.isKindOfClass(IQBarButtonItem) == true)
                {
                    if (prevButton?.enabled != isPreviousEnabled) {
                        prevButton?.enabled = isPreviousEnabled
                    }
                    
                    if (nextButton?.enabled != isNextEnabled) {
                        nextButton?.enabled = isNextEnabled
                    }
                }
            }
            else
            {
                //  Getting first item from inputAccessoryView.
                var barButtonItem : IQBarButtonItem? = inputAccessoryView?.items![0] as? IQBarButtonItem
                
                //  If it is IQBarButtonItem and it's customView is not nil.
                if (barButtonItem != nil && barButtonItem?.customView != nil)
                {
                    //  Getting it's customView.
                    var segmentedControl : IQSegmentedNextPrevious? = barButtonItem?.customView as? IQSegmentedNextPrevious

                    //  If its customView is IQSegmentedNextPrevious and has 2 segments
                    if (segmentedControl?.numberOfSegments == 2)
                    {
                        if (segmentedControl?.isEnabledForSegmentAtIndex(0) != isPreviousEnabled)
                        {
                            //  Setting it's first segment enable/disable.
                            segmentedControl?.setEnabled(isPreviousEnabled, forSegmentAtIndex: 0)
                        }
                        
                        if (segmentedControl?.isEnabledForSegmentAtIndex(1) != isNextEnabled)
                        {
                            //  Setting it's second segment enable/disable.
                            segmentedControl?.setEnabled(isNextEnabled, forSegmentAtIndex: 1)
                        }
                    }
                }
            }
        }
    }
}

