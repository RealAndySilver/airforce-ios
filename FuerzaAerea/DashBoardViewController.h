//
//  DashBoardViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 30/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DashBoardViewController : UIViewController<UITextFieldDelegate,UISearchBarDelegate>{
    IBOutlet UIView *containerOV;
    IBOutlet UIView *containerMetar;

    IBOutlet UITextField *ovTF;
    IBOutlet UITextField *mtTF;
    
    IBOutlet UISearchBar *leftSearchBar;

    CGRect frameInicialOV;
    CGRect frameFinalOV;
    
    CGRect frameInicialMT;
    CGRect frameFinalMT;
    CGRect searchInicialMT;
    CGRect searchFinalMT;

    BOOL touchFlag;
}

@end
