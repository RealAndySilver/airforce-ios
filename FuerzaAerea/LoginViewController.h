//
//  ViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 18/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashBoardViewController.h"
#import "DeviceInfo.h"
#import "ServerCommunicator.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>{
    CGRect frameInicial;
    CGRect frameFinal;
    BOOL touchFlag;
    
    IBOutlet UIView *container;
    IBOutlet UITextField *nombreTF;
    IBOutlet UITextField *passTF;
}

@end
