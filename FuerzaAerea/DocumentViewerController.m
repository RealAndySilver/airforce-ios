//
//  DocumentViewerController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 8/11/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "DocumentViewerController.h"

@interface DocumentViewerController ()

@end
@implementation DocumentViewerController
@synthesize path;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self loadDocument:@"x" inView:nil];
    //webView.scalesPageToFit=YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    //self.navigationController.navigationBarHidden= YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark external request
-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView1{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

@end
