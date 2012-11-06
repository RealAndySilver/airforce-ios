//
//  ViewController.m
//  FuerzaAerea
//
//  Created by Andres Abril on 18/10/12.
//  Copyright (c) 2012 Andres Abril. All rights reserved.
//

#import "LoginViewController.h"
#define USERNAME @"omar"
#define PASSWORD @"sinte"
#define IMEI @"1qaz"
#define SERIAL @"1234"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"device %@ uudid %@ macaddress %@",[DeviceInfo getModel],[DeviceInfo getUUDID],[DeviceInfo getMacAddress]);
    UITapGestureRecognizer *dismissRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignKeyboard)];
    [self.view addGestureRecognizer:dismissRecognizer];
    nombreTF.text=USERNAME;
    passTF.text=PASSWORD;
}
-(void)viewWillAppear:(BOOL)animated{
    frameInicial=CGRectMake(256, 100, 512, 374);
    frameFinal=CGRectMake(256, 187, 512, 374);

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma text delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    touchFlag=YES;
    [self animarHasta:frameInicial];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    touchFlag=NO;
    [self performSelector:@selector(delayed) withObject:nil afterDelay:0.01];
}
-(void)delayed{
    if (!touchFlag) {
        [self animarHasta:frameFinal];
    }
}
#pragma mark animacion
-(void)animarHasta:(CGRect)hasta{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    container.frame=hasta;
    [UIView commitAnimations];
}
#pragma mark dismiss keyboard
-(void)resignKeyboard{
    [nombreTF resignFirstResponder];
    [passTF resignFirstResponder];
}
#pragma mark acciones
-(IBAction)irAlDashboard{
    ServerCommunicator *server=[[ServerCommunicator alloc]init];
    server.caller=self;
    NSString *params=[NSString stringWithFormat:@"<user>%@</user><pass>%@</pass><imei>%@</imei><serial>%@</serial>",nombreTF.text,passTF.text,IMEI,SERIAL];
    [server callServerWithMethod:@"login" andParameter:params];
    
}
#pragma mark server response
-(void)receivedDataFromServer:(id)sender{
    ServerCommunicator *server=sender;
    NSLog(@"Sender %@",server.resDic);
    if ([[server.resDic objectForKey:@"return"] isEqualToString:@"true"]) {
        DashBoardViewController *dVC=[[DashBoardViewController alloc]init];
        dVC=[self.storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
        [self.navigationController pushViewController:dVC animated:YES];
    }
}
@end
