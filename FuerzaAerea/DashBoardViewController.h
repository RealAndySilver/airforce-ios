//
//  DashBoardViewController.h
//  FuerzaAerea
//
//  Created by Andres Abril on 30/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DocumentViewerController.h"
#import "ServerCommunicator.h"
#import "ImageDownloader.h"
#import "MBProgressHud.h"
#import "InfoAeroViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface DashBoardViewController : UIViewController<UITextFieldDelegate,UISearchBarDelegate,UIDocumentInteractionControllerDelegate,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>{
    IBOutlet UIView *containerOV;
    IBOutlet UIView *containerMetar;

    IBOutlet UITextField *ovTF;
    IBOutlet UITextField *mtTF;
    
    IBOutlet UISwitch *notamSwitch;
    IBOutlet UISwitch *metarSwitch;
    IBOutlet UISwitch *conservarSwitch;
    
    //IBOutlet UISearchDisplayController *leftSearchBar;

    IBOutlet UITableView *leftTableView;
    NSArray *leftTableArray;
    NSMutableArray *leftTableResults;
    NSArray *leftStaticArray;
    
    IBOutlet UITableView *rightTableView;
    NSMutableArray *rightTableArray;

    CGRect frameInicialOV;
    CGRect frameFinalOV;
    
    CGRect frameInicialMT;
    CGRect frameFinalMT;
    CGRect searchInicialMT;
    CGRect searchFinalMT;

    BOOL touchFlag;
    
    MBProgressHUD *hud;
    
}
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;
@property (weak, nonatomic) IBOutlet UISearchBar *leftSearchBar;

@end
