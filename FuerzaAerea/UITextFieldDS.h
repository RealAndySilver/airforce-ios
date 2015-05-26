//
//  UITextView+DataStore.h
//  FuerzaAerea
//
//  Created by Andres Abril on 23/04/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UITextFieldDS:UITextField<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic, retain) NSString* data1;
@end
