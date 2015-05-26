//
//  UITextView+DataStore.m
//  FuerzaAerea
//
//  Created by Andres Abril on 23/04/15.
//  Copyright (c) 2015 Andres Abril. All rights reserved.
//

#import "UITextFieldDS.h"

@implementation UITextFieldDS
@synthesize data1;
#pragma mark - picker delegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==2001) {
        return 1;
    }
    else{
        return 0;
    }
    return 0;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        if (pickerView.tag==2001) {
            
        }
    }
    else{
        return nil;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        if (pickerView.tag==2001) {
            
            return;
        }
    }
    return;
    
}
@end
