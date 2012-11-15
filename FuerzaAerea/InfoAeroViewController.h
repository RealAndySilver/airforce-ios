//
//  InfoAeroViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 15/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoAeroViewController : UIViewController{
    IBOutlet UILabel *label;
}
@property(nonatomic,retain)NSString *delegatedString;
@end
