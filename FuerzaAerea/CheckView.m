//
//  CheckView.m
//  FuerzaAerea
//
//  Created by Andres Abril on 31/01/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "CheckView.h"

@implementation CheckView
@synthesize isOn;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 30, 30);
        self.backgroundColor=[UIColor grayColor];
        checkText=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        checkText.backgroundColor=[UIColor clearColor];
        checkText.font=[UIFont boldSystemFontOfSize:18];
        checkText.textAlignment=NSTextAlignmentCenter;
            checkText.textColor=[UIColor darkGrayColor];
            checkText.text=@"X";
        [self addSubview:checkText];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeState)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)changeState{
    if (!isOn) {
        isOn=YES;
        checkText.textColor=[UIColor greenColor];
        checkText.text=@"√";
        return;
    }
    else{
        isOn=NO;
        checkText.textColor=[UIColor darkGrayColor];
        checkText.text=@"X";
        return;
    }
}


@end
