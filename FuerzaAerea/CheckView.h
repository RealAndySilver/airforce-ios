//
//  CheckView.h
//  FuerzaAerea
//
//  Created by Andres Abril on 31/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckView : UIView{
    UILabel *checkText;
}
@property(nonatomic)BOOL isOn;
-(void)changeState;
@end
