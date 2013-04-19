//
//  AdminViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 9/03/13.
//  Copyright (c) 2013 Andres Abril. All rights reserved.
//

#import "AdminViewController.h"

@interface AdminViewController ()

@end

@implementation AdminViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    FileSaver *file=[[FileSaver alloc]init];
    tf.text=[file getIp];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)sender:(id)sender{
    FileSaver *file=[[FileSaver alloc]init];
    if (tf.text) {
        [file setIP:tf.text];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
