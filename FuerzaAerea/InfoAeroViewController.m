//
//  InfoAeroViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 15/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "InfoAeroViewController.h"

@interface InfoAeroViewController ()

@end

@implementation InfoAeroViewController
@synthesize delegatedString;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //label.frame=CGRectMake(0, 0, self.view.frame.size.width-20, 80);
    //label.center=CGPointMake(self.view.frame.size.height/2, self.view.frame.size.width/2);
    UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
    [self.view addGestureRecognizer:tapRecognizer];
    
    label.text=delegatedString;
    label.numberOfLines=2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
